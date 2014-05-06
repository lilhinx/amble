//
//  AmbleBeaconLocationManager.m
//  Amble
//
//  Created by Chris Hinkle on 5/6/14.
//  Copyright (c) 2014 Chris Hinkle. All rights reserved.
//

#import "AmbleBeaconLocationManager.h"

@interface AmbleBeaconLocationManager( )

@property (nonatomic,strong) RACSubject* rangedBeaconSubject;

@end

@implementation AmbleBeaconLocationManager


- (id)init
{
	self = [super init];
	if( self )
	{
		__weak typeof(self) weakSelf = self;
		[self.regionStateChangedSignal subscribeNext:^( NSArray* regionStateTuple ) {
			CLRegionState state = (CLRegionState)[[regionStateTuple objectAtIndex:0] integerValue];
			id region = [regionStateTuple objectAtIndex:1];
			BOOL isBeaconRegion = [region isKindOfClass:[CLBeaconRegion class]];
			if( state == CLRegionStateInside && isBeaconRegion && [weakSelf autoRangeBeacons] )
			{
				CLBeaconRegion* beaconRegion = (CLBeaconRegion*)region;
				[self startRangingBeaconsInRegion:beaconRegion];
			}
		}];
	}
	return self;
}

- (RACSubject*)rangedBeaconSubject
{
	if( _rangedBeaconSubject == nil )
	{
		_rangedBeaconSubject = [RACSubject subject];
	}
	return _rangedBeaconSubject;
}


- (RACSignal*)rangedBeaconSignal
{
	return (RACSignal*)self.rangedBeaconSubject;
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
	for( CLBeacon* beacon in beacons )
	{
		[self.rangedBeaconSubject sendNext:beacon];
	}
}


@end
