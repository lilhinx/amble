//
//  AmbleRegionalLocationManager.h
//  Amble
//
//  Created by Chris Hinkle on 5/6/14.
//  Copyright (c) 2014 Chris Hinkle. All rights reserved.
//

#import "AmbleLocationManager.h"

@interface AmbleRegionalLocationManager : AmbleLocationManager

- (RACSignal*)regionEnteredSignal;
- (RACSignal*)regionExitedSignal;
- (RACSignal*)regionStateChangedSignal;

@end
