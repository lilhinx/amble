//
//  AmbleRegionalLocationManager.m
//  Amble
//
//  Created by Chris Hinkle on 5/6/14.
//  Copyright (c) 2014 Chris Hinkle. All rights reserved.
//

#import "AmbleRegionalLocationManager.h"

@interface AmbleRegionalLocationManager( )<CLLocationManagerDelegate>

@property (nonatomic,strong) RACSubject* regionEnteredSubject;
@property (nonatomic,strong) RACSubject* regionExitedSubject;
@property (nonatomic,strong) RACSubject* regionStateChangedSubject;

@end

@implementation AmbleRegionalLocationManager

- (RACSubject*)regionEnteredSubject
{
	if( _regionEnteredSubject == nil )
	{
		_regionEnteredSubject =  [RACBehaviorSubject behaviorSubjectWithDefaultValue:nil];
	}
	return _regionEnteredSubject;
}

- (RACSignal*)regionEnteredSignal
{
	return (RACSignal*)self.regionEnteredSubject;
}

- (RACSubject*)regionExitedSubject
{
	if( _regionExitedSubject == nil )
	{
		_regionExitedSubject =  [RACBehaviorSubject behaviorSubjectWithDefaultValue:nil];
	}
	return _regionExitedSubject;
}

- (RACSignal*)regionExitedSignal
{
	return (RACSignal*)self.regionExitedSubject;
}

- (RACSubject*)regionStateChangedSubject
{
	if( _regionStateChangedSubject == nil )
	{
		_regionStateChangedSubject = [RACBehaviorSubject behaviorSubjectWithDefaultValue:nil];
	}
	return _regionStateChangedSubject;
}

- (RACSignal*)regionStateChangedSignal
{
	return (RACSignal*)self.regionStateChangedSubject;
}


- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
	[self.regionEnteredSubject sendNext:region];
}


- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
	[self.regionExitedSubject sendNext:region];
}


- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
	[self.regionStateChangedSubject sendNext:@[ @(state), region ] ];
}

- (void)locationManager:(CLLocationManager *)manager rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error
{
	NSLog( @"beacon range error: %@ %@", region, error );
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error
{
	NSLog( @"monitoringDidFailForRegion: %@ %@", region, error );
}

@end
