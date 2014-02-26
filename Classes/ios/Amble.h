//
//  Amble.h
//  Amble
//
//  Created by Chris Hinkle on 2/25/14.
//  Copyright (c) 2014 Chris Hinkle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>

@interface Amble : NSObject

@property (nonatomic,strong) RACSignal* signal;
@property (nonatomic,strong) CLLocationManager* manager;
@property (nonatomic,strong) CMMotionManager* motionManager;


@end
