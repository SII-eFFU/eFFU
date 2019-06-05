//
//  Calculation.swift
//  eFFU
//
//  Created by admin on 28/05/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import CoreLocation

class Calculation {
    
    let degree_to_radian : Double = .pi / 180.0
    let radian_to_degree : Double = 180.0 / .pi
    
    /*
     * Calculates the distance between two points of the map with their coordinates.
     * Based on the spherical algorithm
     * cf http://williams.best.vwh.net/avform.htm#Implement section Some great circle formulae
     * Input  : coordinates in degree
     * Output : distance in radian
     */
    func getDistanceSphericalInRadian(latLongA: CLLocationCoordinate2D, latLongB: CLLocationCoordinate2D) -> Double {
        
        let latA : Double = latLongA.latitude * degree_to_radian
        let latB : Double = latLongB.latitude * degree_to_radian
        let longA : Double = latLongA.longitude * degree_to_radian
        let longB : Double = latLongB.longitude * degree_to_radian
        
        var distance : Double = acos(sin(latA)*sin(latB)+cos(latA)*cos(latB)*cos(longA-longB))
        
        if (distance < 20.0 / (6371.0 * 0.539956803)) {
            distance = 2 * asin(sqrt(pow((sin((latA - latB) / 2.0)), 2.0) +
                cos(latA) * cos(latB) * pow((sin((longA - longB) / 2.0)), 2.0)));
        }
        
        return distance
    }
    
    /*
     * Calculates the distance between two points of the map with their coordinates.
     * Based on the spherical algorithm
     * cf http://williams.best.vwh.net/avform.htm#Implement section Some great circle formulae
     * Input  : coordinates in degree
     * Output : distance in Nautique Miles
     */
    func getDistanceSpherical(latLongA: CLLocationCoordinate2D, latLongB: CLLocationCoordinate2D) -> Double{
        
        let distKmResult: Double = self.getDistanceSphericalInRadian(latLongA: latLongA, latLongB: latLongB) * 6371.0 * 0.539956803
        
        return distKmResult
    }
    
    /*
     * Calculates the distance between two points of the map with their coordinates.
     * Based on direct algorithm
     * Input  : coordinates in degree
     * Output : distance in Nautique Miles
     */
    func getDistanceDirect(latLongA: CLLocationCoordinate2D, latLongB: CLLocationCoordinate2D) -> Double {
        
        let latA : Double = latLongA.latitude * degree_to_radian
        let latB : Double = latLongB.latitude * degree_to_radian
        
        let distKmResult = sqrt(pow((latLongB.latitude - latLongA.latitude) * 60, 2.0)
            + pow((latLongB.longitude - latLongA.longitude) * 60 * cos((latB + latA) / 2.0), 2.0))
        
        // The result is in km, we want nm
        // 1 kilometer = 0.539956803 nautical miles
        return distKmResult
    }
    
    /*
     * Calculates the course between two points of the map with their coordinates.
     * Based on the spherical algorithm
     * cf http://williams.best.vwh.net/avform.htm#Implement section Course between points
     * Input  : coordinates in degree
     * Output : course in degree
     */
    func getCourse(latLongA: CLLocationCoordinate2D, latLongB: CLLocationCoordinate2D) -> Double {
        
        let distance : Double = self.getDistanceSphericalInRadian(latLongA: latLongA, latLongB: latLongB)
        var course : Double
        let latA : Double = latLongA.latitude * degree_to_radian
        let latB : Double = latLongB.latitude * degree_to_radian
        let longA : Double = latLongA.longitude * degree_to_radian
        let longB : Double = latLongB.longitude * degree_to_radian
        
        if( (latLongA.latitude > 89.9) || (latLongA.latitude < -89.9) ){
            if(latLongA.latitude > 0){
                course = 180.0;
            }else{
                course = 0.0;
            }
            
        }else{
            // sin(longB - longA) > 0.0 instead of sin(longB - longA) < 0.0 from web site
            if(sin(longB - longA) > 0.0 ){
                course = radian_to_degree * acos((sin(latB) - sin(latA) * cos(distance)) / (sin(distance) * cos(latA)));
            }else{
                course = radian_to_degree * (2 * .pi - acos((sin(latB) - sin(latA) * cos(distance)) / (sin(distance) * cos(latA))));
            }
        }
        
        return course
    }
    
    /*
     * return TRUE if turn direction is RIGHT
     * return FALSE if turn direction is LEFT
     *
     */
    func getTurnDirection(directionA: Double, directionB: Double) -> String {
        
        var turnDirection : String
        
        let dirAMinusDirB: Double = directionA - directionB
        let absDirAMinusDirB: Double = abs(dirAMinusDirB)
        
        if (absDirAMinusDirB < 2){
            turnDirection = "Straight"
        }else{
            if (dirAMinusDirB > 0 ){
                if (dirAMinusDirB > 180) {
                    turnDirection = "Right"
                }else{
                    turnDirection = "Left"
                }
            }else{
                if (absDirAMinusDirB > 180) {
                    turnDirection = "Left"
                }else{
                    turnDirection = "Right"
                }
            }
        }
        
        return turnDirection
    }
    
    func getCoordOfflineMap(departureLat: Double, departureLong: Double, arrivalLat: Double, arrivalLong: Double) -> (CLLocationCoordinate2D, CLLocationCoordinate2D) {
        
        var northeast = CLLocationCoordinate2D ()
        var southwest = CLLocationCoordinate2D ()
        
        if departureLong < arrivalLong {
            if departureLat < arrivalLat {
                // departure = southwest
                // arrival = northeast
                southwest.latitude = departureLat - 0.3
                southwest.longitude = departureLong - 0.3
                
                northeast.latitude = arrivalLat + 0.3
                northeast.longitude = arrivalLong + 0.3
            }
            if departureLat > arrivalLat {
                // departure = southwest
                // arrival = northeast
                southwest.latitude = (departureLat - (departureLat - arrivalLat)) - 0.3
                southwest.longitude = departureLong - 0.3
                
                northeast.latitude = (arrivalLat + (departureLat - arrivalLat)) + 0.3
                northeast.longitude = arrivalLong + 0.3
            }
        }
        if departureLong > arrivalLong {
            if departureLat > arrivalLat {
                // departure = northwest
                // arrival = southwest
                northeast.latitude = departureLat + 0.3
                northeast.longitude = departureLong + 0.3
                
                southwest.latitude = arrivalLat - 0.3
                southwest.longitude = arrivalLong - 0.3
            }
            if departureLat < arrivalLat {
                // departure = northwest
                // arrival = southwest
                northeast.latitude = (departureLat + (arrivalLat - departureLat)) + 0.3
                northeast.longitude = departureLong + 0.3
                
                southwest.latitude = (arrivalLat - (arrivalLat - departureLat)) - 0.3
                southwest.longitude = arrivalLong - 0.3
            }
        }
        return (northeast, southwest)
    }
 
}
