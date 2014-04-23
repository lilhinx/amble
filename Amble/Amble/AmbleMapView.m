//
//  AmbleMapView.m
//  Amble
//
//  Created by Chris Hinkle on 4/19/14.
//  Copyright (c) 2014 Chris Hinkle. All rights reserved.
//

#import "AmbleMapView.h"

@implementation AmbleMapView

- (void)setDelegate:(id<MKMapViewDelegate>)delegate
{
	NSAssert( delegate == self, @"Amble Map View delegate not available to the outside" );
}

@end
