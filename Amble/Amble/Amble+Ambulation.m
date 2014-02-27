//
//  Amble+Ambulation.m
//  Amble
//
//  Created by Chris Hinkle on 2/26/14.
//  Copyright (c) 2014 Chris Hinkle. All rights reserved.
//

#import "Amble+Ambulation.h"
#import <CoreMotion/CoreMotion.h>

#define TRACK_STEPS 20

@interface AmbulationManager : NSObject

+ (instancetype)sharedManager;

@property (nonatomic,strong) NSOperationQueue* stepCounterQueue;
@property (nonatomic,strong) CMStepCounter* stepCounter;

- (void)startTracking;


@end

@implementation AmbulationManager

+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    static AmbulationManager* sharedManager;
    dispatch_once(&onceToken, ^{
        sharedManager = [[AmbulationManager alloc] init];
    });
    return sharedManager;
}

- (id)init
{
    self = [super init];
    if( self )
    {
        self.stepCounterQueue = [NSOperationQueue mainQueue];
        self.stepCounter = [[CMStepCounter alloc] init];
        
        
    }
    return self;
}

- (void)startTracking
{
    [self.stepCounter startStepCountingUpdatesToQueue:self.stepCounterQueue updateOn:TRACK_STEPS withHandler:^(NSInteger numberOfSteps, NSDate *timestamp, NSError *error) {
       
        if( error != nil )
        {
            NSLog( @"erorr: %@", error );
        }
        NSLog( @"Steps %@ %@", @(numberOfSteps), timestamp );
        
    }];
}


@end


@implementation Amble (Ambulation)

+ (RACSignal*)isAmbulatory
{
    if( ! [CMStepCounter isStepCountingAvailable] )
    {
        NSLog( @"Step counting not available on this device, isAmbulatory signal to available" );
        return nil;
    }
    
    [[AmbulationManager sharedManager] startTracking];
    
    
    return nil;
}

@end
