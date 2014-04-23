//
//  MKMapView+RACSignalSupport.m
//  Amble
//
//  Created by Chris Hinkle on 4/19/14.
//  Copyright (c) 2014 Chris Hinkle. All rights reserved.
//

#import "MKMapView+RACSignalSupport.h"
#import "EXTScope.h"

@implementation MKMapView (RACSignalSupport)

- (RACSignal *)rac_regionSignal
{
	return RACObserve( self, region );
}


@end
