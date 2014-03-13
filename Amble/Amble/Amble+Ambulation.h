//
//  Amble+Ambulation.h
//  Amble
//
//  Created by Chris Hinkle on 2/26/14.
//  Copyright (c) 2014 Chris Hinkle. All rights reserved.
//

#import "Amble.h"

@interface AmbleStepsMessage : NSObject

@property (nonatomic,strong) NSNumber* steps;
@property (nonatomic,strong) NSDate* timestamp;

@end

@interface Amble (Ambulation)

+ (RACSignal*)isAmbulatory;

+ (RACSignal*)steps;
+ (RACSignal*)walkingSpeed;

@end
