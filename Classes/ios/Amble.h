//
//  Amble.h
//  Amble
//
//  Created by Chris Hinkle on 2/25/14.
//  Copyright (c) 2014 Chris Hinkle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface Amble : NSObject

@property (nonatomic,strong) RACSignal* signal;

@end
