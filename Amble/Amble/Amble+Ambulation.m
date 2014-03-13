//
//  Amble+Ambulation.m
//  Amble
//
//  Created by Chris Hinkle on 2/26/14.
//  Copyright (c) 2014 Chris Hinkle. All rights reserved.
//

#import "Amble+Ambulation.h"
#import <CoreMotion/CoreMotion.h>

#define TRACK_STEPS 5
#define STEP_TIMER_INTERVAL 5.0

@implementation AmbleStepsMessage

@end

@interface AmbulationManager : NSObject

+ (instancetype)sharedManager;

@property (nonatomic,strong) NSOperationQueue* stepCounterQueue;
@property (nonatomic,strong) CMStepCounter* stepCounter;

@property (nonatomic,strong) RACSubject* stepsSubject;
@property (nonatomic,strong) RACSubject* walkingSpeedSubject;
@property (nonatomic,strong) RACSignal* ambulatorySignal;

- (void)startTracking;
- (void)stopTracking;

@property (nonatomic,strong) NSTimer* stepTimer;
- (void)stepTimer_fire:(NSTimer*)timer;


@property (nonatomic,strong) AmbleStepsMessage* lastStepMessage;

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
    [self.stepCounter startStepCountingUpdatesToQueue:self.stepCounterQueue updateOn:TRACK_STEPS withHandler:^( NSInteger numberOfSteps, NSDate *timestamp, NSError *error )
     {
        if( error != nil )
        {
            [self.stepsSubject sendError:error];
        }
         
         AmbleStepsMessage* msg = [[AmbleStepsMessage alloc] init];
         msg.steps = @(numberOfSteps);
         msg.timestamp = timestamp;
         
         if( self.lastStepMessage )
         {
             NSTimeInterval elapsed = [msg.timestamp timeIntervalSinceDate:self.lastStepMessage.timestamp];
             CGFloat speed = [msg.steps floatValue] / elapsed;
             [self.walkingSpeedSubject sendNext:@(speed)];
         }
         
         self.lastStepMessage = msg;
         
         [self.stepsSubject sendNext:msg];
		 
		 
    }];
	
	[self.stepTimer invalidate];
	self.stepTimer = [NSTimer scheduledTimerWithTimeInterval:STEP_TIMER_INTERVAL target:self selector:@selector(stepTimer_fire:) userInfo:nil repeats:YES];
    
    
}

- (void)stopTracking
{
    [self.stepCounter stopStepCountingUpdates];
    [self.stepTimer invalidate];
}

- (RACSubject*)stepsSubject
{
    if( _stepsSubject == nil )
    {
         AmbleStepsMessage* dflt = [[AmbleStepsMessage alloc] init];
        dflt.steps = @(0);
        dflt.timestamp = [NSDate date];
        _stepsSubject = [RACBehaviorSubject behaviorSubjectWithDefaultValue:dflt];
    }
    return _stepsSubject;
}

- (RACSubject*)walkingSpeedSubject
{
    if( _walkingSpeedSubject == nil )
    {
        _walkingSpeedSubject = [RACSubject subject];
    }
    return _walkingSpeedSubject;
}

- (RACSignal*)ambulatorySignal
{
	if( _ambulatorySignal == nil )
	{
		_ambulatorySignal = (RACSignal*)[[[AmbulationManager sharedManager] walkingSpeedSubject] map:^NSNumber*( NSNumber* speed )
		{
			if( speed.floatValue > 0 )
			{
				return @(YES);
			}
			else
			{
				return @(NO);
			}
		}];
	}
	
	return _ambulatorySignal;
}



- (void)stepTimer_fire:(NSTimer*)timer
{
	if( self.lastStepMessage )
	{
		NSTimeInterval elapsed = [self.lastStepMessage.timestamp timeIntervalSinceNow];
		if( fabs( elapsed ) > ( STEP_TIMER_INTERVAL * 1.0 ) )
		{
			NSDate* now = [NSDate date];
			[self.stepCounter queryStepCountStartingFrom:self.lastStepMessage.timestamp to:now toQueue:self.stepCounterQueue withHandler:^(NSInteger numberOfSteps, NSError *error)
			{
				AmbleStepsMessage* msg = [[AmbleStepsMessage alloc] init];
				msg.steps = @(numberOfSteps);
				msg.timestamp = now;
				self.lastStepMessage = msg;
				
				if( numberOfSteps == 0 )
				{
					[self.walkingSpeedSubject sendNext:@(0)];
				}
			}];
		}
	}
}


@end

@interface Amble (AmbulationPrivate)

+ (void)startTracker;

@end


@implementation Amble (Ambulation)

+ (void)startStepsTracker
{
    if( ! [CMStepCounter isStepCountingAvailable] )
    {
        NSLog( @"Step counting not available on this device, isAmbulatory signal not available" );
        return;
    }
    
    [[AmbulationManager sharedManager] startTracking];
}

+ (RACSignal*)isAmbulatory
{
    [Amble startStepsTracker];
    return [[AmbulationManager sharedManager] ambulatorySignal];
}

+ (RACSignal*)steps
{
    [Amble startStepsTracker];
    return (RACSignal*)[[AmbulationManager sharedManager] stepsSubject];
}

+ (RACSignal*)walkingSpeed
{
    [Amble startStepsTracker];
    return (RACSignal*)[[AmbulationManager sharedManager] walkingSpeedSubject];
}

@end
