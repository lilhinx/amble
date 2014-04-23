//
//  AmbleLocationManager.m
//  Amble
//
//  Created by Chris Hinkle on 4/23/14.
//  Copyright (c) 2014 Chris Hinkle. All rights reserved.
//

#import "AmbleLocationManager.h"

@interface AmbleLocationManager( )<CLLocationManagerDelegate>

@property (nonatomic,strong) RACSubject* authorizationStatusSubject;
@property (nonatomic,strong) RACSubject* locationSubject;

@property (nonatomic,strong) NSDate* lastLocationTime;

@end

@implementation AmbleLocationManager


+ (instancetype)sharedManager
{
	static dispatch_once_t onceToken;
	static AmbleLocationManager* sharedManager;
	dispatch_once(&onceToken, ^{
		sharedManager = [[AmbleLocationManager alloc] init];
	});
	return sharedManager;
}

- (id)init
{
	self = [super init];
	if( self )
	{
		self.delegate = self;
	}
	return self;
}


- (void)setDelegate:(id<CLLocationManagerDelegate>)delegate
{
	if( delegate != nil )
	{
		NSAssert( [delegate isKindOfClass:[AmbleLocationManager class]], @"Delegate not externally available" );
	}
	[super setDelegate:delegate];
}

- (RACSubject*)authorizationStatusSubject
{
	if( _authorizationStatusSubject == nil )
	{
		_authorizationStatusSubject = [RACBehaviorSubject behaviorSubjectWithDefaultValue:@([CLLocationManager authorizationStatus])];
	}
	return _authorizationStatusSubject;
}

- (RACSignal*)currentAuthorizationStatus
{
	return (RACSignal*)self.authorizationStatusSubject;
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
	[self.authorizationStatusSubject sendNext:@(status)];
}

- (RACSignal*)currentAuthorizationStatus_humanReadable
{
	return [[self currentAuthorizationStatus] map:^id(NSNumber* status ) {
		switch( (CLAuthorizationStatus)[status integerValue] )
		{
			case kCLAuthorizationStatusRestricted:
				return @"Restricted";
			case kCLAuthorizationStatusDenied:
				return @"Denied";
			case kCLAuthorizationStatusAuthorized:
				return @"Authorized";
			case kCLAuthorizationStatusNotDetermined:
			default:
				return @"Not determined";
		}
		
	}];
}

- (RACSubject*)locationSubject
{
	if( _locationSubject == nil )
	{
		_locationSubject = [RACBehaviorSubject behaviorSubjectWithDefaultValue:self.location];
	}
	return _locationSubject;
}

- (NSDate*)lastLocationTime
{
	if( _lastLocationTime == nil )
	{
		_lastLocationTime = [NSDate distantPast];
	}
	return _lastLocationTime;
}

- (RACSignal*)currentLocation
{
	//filtering for only chronologically ascending location values
	__weak typeof(self) weakSelf = self;
	return (RACSignal*)[self.locationSubject filter:^BOOL( CLLocation* locationValue ) {
		if( locationValue == nil )
		{
			return NO;
		}
		NSComparisonResult rslt = [locationValue.timestamp compare:weakSelf.lastLocationTime];
		BOOL isLatest = rslt == NSOrderedSame || rslt == NSOrderedDescending;
		if( isLatest )
		{
			weakSelf.lastLocationTime = locationValue.timestamp;
		}
		return isLatest;
	}];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray*)locations
{
	for( CLLocation* location in locations )
	{
		[self.locationSubject sendNext:location];
	}
}

@end
