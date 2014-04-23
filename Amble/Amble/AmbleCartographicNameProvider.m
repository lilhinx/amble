//
//  AmbleLocationInformationProvider.m
//  Amble
//
//  Created by Chris Hinkle on 4/19/14.
//  Copyright (c) 2014 Chris Hinkle. All rights reserved.
//

#import "AmbleCartographicNameProvider.h"

@interface AmbleCartographicNameProvider( )

@property (nonatomic,strong,readwrite) RACSignal* neighborhoodName;
@property (nonatomic,strong,readwrite) RACSignal* localityName;
@property (nonatomic,strong,readwrite) RACSignal* areaName;
@property (nonatomic,strong,readwrite) RACSignal* administrativeName;
@property (nonatomic,strong,readwrite) RACSignal* countryName;
@property (nonatomic,strong,readwrite) RACSignal* countryCode;

@property (nonatomic,strong) RACBehaviorSubject* countryNameSubject;

@end

@implementation AmbleCartographicNameProvider

- (id)init
{
	self = [super init];
	if( self )
	{
		self.countryNameSubject = [RACBehaviorSubject behaviorSubjectWithDefaultValue:@"Country Name"];
		
		[RACObserve( self, locationOfConcern ) subscribeError:^(NSError *error) {
			[self.countryNameSubject sendNext:@"Yo"];
		}];
	}
	return self;
}


@end
