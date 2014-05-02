//
//  AmbleLocationManager.h
//  Amble
//
//  Created by Chris Hinkle on 4/23/14.
//  Copyright (c) 2014 Chris Hinkle. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface AmbleLocationManager : CLLocationManager

- (RACSignal*)currentAuthorizationStatus;
- (RACSignal*)authorizedSignal;
- (RACSignal*)currentAuthorizationStatus_humanReadable;


- (RACSignal*)currentLocation;

+ (instancetype)sharedManager;

@end
