//
//  AmbleLocationInformationProvider.h
//  Amble
//
//  Created by Chris Hinkle on 4/19/14.
//  Copyright (c) 2014 Chris Hinkle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface AmbleCartographicNameProvider : NSObject

@property (nonatomic,copy) CLLocation* locationOfConcern;
@property (nonatomic) MKCoordinateSpan spanOfConcern;

@property (nonatomic,strong,readonly) RACSignal* neighborhoodName;
@property (nonatomic,strong,readonly) RACSignal* localityName;
@property (nonatomic,strong,readonly) RACSignal* areaName;
@property (nonatomic,strong,readonly) RACSignal* administrativeName;
@property (nonatomic,strong,readonly) RACSignal* countryName;
@property (nonatomic,strong,readonly) RACSignal* countryCode;

@end