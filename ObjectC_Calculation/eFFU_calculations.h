//
//  eFFU_calculations.h
//  eFFU
//
//  Created by lpery on 22/09/2015.
//  Copyright (c) 2015 SII. All rights reserved.
//

#ifndef eFFU_eFFU_calculations_h
#define eFFU_eFFU_calculations_h

#import "RMMapView.h"
#import "RMAnnotation.h"
#import "RMMarker.h"
#import "eFFU_enum.h"

@interface eFFU_calculations : NSObject

+ (double)getDistanceSpherical:(CLLocationCoordinate2D)latLongA latLongB:(CLLocationCoordinate2D)latLongB;

+ (double)getDistanceDirect:(CLLocationCoordinate2D)latLongA latLongB:(CLLocationCoordinate2D)latLongB;

+ (double)getCourse:(CLLocationCoordinate2D)latLongA latLongB:(CLLocationCoordinate2D)latLongB;

+ (turnDirection)getTurnDirection:(double)directionA :(double)directionB;



@end

#endif
