//
//  AmbleBeaconLocationManager.h
//  Amble
//
//  Created by Chris Hinkle on 5/6/14.
//  Copyright (c) 2014 Chris Hinkle. All rights reserved.
//

#import "AmbleRegionalLocationManager.h"

@interface AmbleBeaconLocationManager : AmbleRegionalLocationManager

- (RACSignal*)rangedBeaconSignal;

@property (nonatomic) BOOL autoRangeBeacons;

@end
