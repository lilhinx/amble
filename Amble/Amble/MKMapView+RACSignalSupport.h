//
//  MKMapView+RACSignalSupport.h
//  Amble
//
//  Created by Chris Hinkle on 4/19/14.
//  Copyright (c) 2014 Chris Hinkle. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface MKMapView (RACSignalSupport)

/// Creates and returns a signal for the region of the map. It always starts with
/// the current region. The signal sends next when value of region changes
- (RACSignal *)rac_regionSignal;

@end
