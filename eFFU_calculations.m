//
//  eFFU_calculations.m
//  eFFU
//
//  Created by lpery on 22/09/2015.
//  Copyright (c) 2015 SII. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "eFFU_calculations.h"
#import "eFFU_constants.h"


@implementation eFFU_calculations

/*
 * Calculates the distance between two points of the map with their coordinates.
 * Based on the spherical algorithm
 * cf http://williams.best.vwh.net/avform.htm#Implement section Some great circle formulae
 * Input  : coordinates in degree
 * Output : distance in Nautique Miles
 */
+ (double)getDistanceSpherical:(CLLocationCoordinate2D)latLongA latLongB:(CLLocationCoordinate2D)latLongB {
    
    double distKmResult = [self getDistanceSphericalInRadian:latLongA  latLongB:latLongB]*6371.0*0.539956803;
    
    return distKmResult;
}


/*
 * Calculates the distance between two points of the map with their coordinates.
 * Based on the spherical algorithm
 * cf http://williams.best.vwh.net/avform.htm#Implement section Some great circle formulae
 * Input  : coordinates in degree
 * Output : distance in radian
 */
+ (double)getDistanceSphericalInRadian:(CLLocationCoordinate2D)latLongA latLongB:(CLLocationCoordinate2D)latLongB {
    
    double latA = latLongA.latitude * degree_to_radian;
    double latB = latLongB.latitude * degree_to_radian;
    double longA = latLongA.longitude * degree_to_radian;
    double longB = latLongB.longitude * degree_to_radian;
    
    double distance = acos(sin(latA)*sin(latB)+cos(latA)*cos(latB)*cos(longA-longB));
    
    if (distance < 20.0/(6371.0*0.539956803)) {
        distance = 2*asin(sqrt( pow((sin((latA-latB)/2.0)),2.0) +
                                   cos(latA)*cos(latB)* pow((sin((longA-longB)/2.0)),2.0)));
    }
    
    return distance;
}

/*
 * Calculates the distance between two points of the map with their coordinates.
 * Based on direct algorithm
 * Input  : coordinates in degree
 * Output : distance in Nautique Miles
 */
+ (double)getDistanceDirect:(CLLocationCoordinate2D)latLongA latLongB:(CLLocationCoordinate2D)latLongB {
    
    double latA = latLongA.latitude * degree_to_radian;
    double latB = latLongB.latitude * degree_to_radian;
    
    double distKmResult = sqrt(pow((latLongB.latitude - latLongA.latitude)*60,2.0) + pow((latLongB.longitude - latLongA.longitude)*60 * cos((latB + latA)/2.0),2.0));
    
  //  NSLog(@"getDistanceBetweenTwoPoints2 distKmResult : %0.4f",distKmResult);
    
    // The result is in km, we want nm
    // 1 kilometer = 0.539956803 nautical miles
    return distKmResult;
}

/*
 * Calculates the course between two points of the map with their coordinates.
 * Based on the spherical algorithm
 * cf http://williams.best.vwh.net/avform.htm#Implement section Course between points
 * Input  : coordinates in degree
 * Output : course in degree
 */
+ (double)getCourse:(CLLocationCoordinate2D)latLongA latLongB:(CLLocationCoordinate2D)latLongB{
    
    double distance = [self getDistanceSphericalInRadian:latLongA latLongB:latLongB];
    double course;
    double latA = latLongA.latitude * degree_to_radian;
    double latB = latLongB.latitude * degree_to_radian;
    double longA = latLongA.longitude * degree_to_radian;
    double longB = latLongB.longitude * degree_to_radian;

    if( (latLongA.latitude > 89.9) || (latLongA.latitude < -89.9) ){
        if(latLongA.latitude > 0){
            course = 180.0;
        }else{
            course = 0.0;
        }
        
    }else{
        // sin(longB - longA) > 0.0 instead of sin(longB - longA) < 0.0 from web site
        if(sin(longB - longA) > 0.0 ){
            course = radian_to_degree * acos((sin(latB)-sin(latA)*cos(distance))/(sin(distance)*cos(latA)));
        }else{
            course = radian_to_degree*(2*M_PI-acos((sin(latB)-sin(latA)*cos(distance))/(sin(distance)*cos(latA))));
        }
    }
    
    return course;
}


/*
 * return TRUE if turn direction is RIGHT
 * return FALSE if turn direction is LEFT
 *
*/

+(turnDirection)getTurnDirection:(double)directionA :(double)directionB{
    
    turnDirection b_turnDirection;
    float dirAMinusDirB = directionA - directionB;
    float absDirAMinusDirB = fabsf(dirAMinusDirB);
    
    if (absDirAMinusDirB < 2){
        b_turnDirection = Straight;
    }else{
        if (dirAMinusDirB > 0 ){
            if (dirAMinusDirB > 180) {
                b_turnDirection = Right;
            }else{
                b_turnDirection = Left;
            }
        }else{
            if (absDirAMinusDirB > 180) {
                b_turnDirection = Left;
            }else{
                b_turnDirection = Right;
            }
        }
    }
    
    return b_turnDirection;
    
}





@end
