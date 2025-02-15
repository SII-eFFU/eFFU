//
//  FlightPlan.swift
//  eFFU
//
//  Created by admin on 26/04/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

class FlightPlan {
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////// Departures & Arrivals /////////////////////////////////////////////////////////////////////////////////////////////
    
    // Creation des variables permettant de configurer l'aerodrome de depart et d'arrivee
    
     var departure_Airfield = [[(name: String, aiIcao: String, latitude: Double, longitude: Double)]]()
     var arrival_Airfield = [[(name: String, aiIcao: String, latitude: Double, longitude: Double)]]()
    
    // Permet de set l'aerodrome de depart
    func set_Departure_Airfield(aiIcao: String, name: String, latitude: Double, longitude: Double){
       
        self.departure_Airfield.append([(name: name, aiIcao: aiIcao, latitude: latitude, longitude: longitude)])
    }
    
    // Permet de set l'aerodrome d'arrivee
    func set_Arrival_Airfield(aiIcao: String, name: String, latitude: Double, longitude: Double){
       
        self.arrival_Airfield.append([(name: name, aiIcao: aiIcao, latitude: latitude, longitude: longitude)])
    }
    
    func departure_Airfield_isEmpty() -> Bool {
        return self.departure_Airfield.isEmpty
    }
    
    func arrival_Airfield_isEmpty() -> Bool {
        return self.arrival_Airfield.isEmpty
    }
    
    func unset_Departure_Airfield(){
        // supprimer seulement si pas vide
        if (!departure_Airfield_isEmpty()){
            self.departure_Airfield.removeLast()
        }
    }
    
    func unset_Arrival_Airfield(){
        // supprimer seulement si pas vide
        if (!arrival_Airfield_isEmpty()){
            self.arrival_Airfield.removeLast()
        }
    }
    
    //Fonctions permettant de "Get" les donnees "latitude" et "longitude"
    func get_Departure_Airfield_Latitude() -> Double {
        return self.departure_Airfield[0][0].latitude
    }
    func get_Departure_Airfield_Longitude() -> Double {
        return self.departure_Airfield[0][0].longitude
    }
    func get_Arrival_Airfield_Latitude() -> Double {
        return self.arrival_Airfield[0][0].latitude
    }
    func get_Arrival_Airfield_Longitude() -> Double {
        return self.arrival_Airfield[0][0].longitude
    }
    
    func get_Departure_Airfield_aiIcao() -> String {
        return self.departure_Airfield[0][0].aiIcao
    }
    
    func get_Departure_Airfield_Name() -> String {
        return self.departure_Airfield[0][0].name
    }
    
    func get_Arrival_Airfield_aiIcao() -> String {
        return self.arrival_Airfield[0][0].aiIcao
    }
    
    func get_Arrival_Airfield_Name() -> String {
        return self.arrival_Airfield[0][0].name
    }
    
    // Test des variables   //
    public var airport_Departure: String {return "Aerodrome de depart =  nom : \(self.departure_Airfield[0][0].name), aiIcao : \(self.departure_Airfield[0][0].aiIcao), latitude : \(self.departure_Airfield[0][0].latitude) et longitude : \(self.departure_Airfield[0][0].longitude)"}
    
    public var airport_Arrival: String {return "Aerodrome d'arrivee = nom : \(self.arrival_Airfield[0][0].name), aiIcao : \(self.arrival_Airfield[0][0].aiIcao), latitude : \(self.arrival_Airfield[0][0].latitude) et longitude : \(self.arrival_Airfield[0][0].longitude)"}
    //                      //
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////// WayPoint //////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    // Creer une liste de point
    /**
    var wayPoint = [[(icon: String, latitude: Double, longitude: Double, name: String)]]()
    
    
    func set_WayPoint(icon: String, latitude: Double, longitude: Double, name: String){
        self.wayPoint.append([(icon: icon, latitude: latitude, longitude: longitude, name: name)])
    }
    
    func wayPoint_isEmpty() -> Bool {
        return self.wayPoint.isEmpty
    }
    
    func unset_WayPoint(){
        // supprimer seulement si pas vide
        if (!wayPoint_isEmpty()){
            self.wayPoint.removeAll()
        }
    }
    
    func get_WayPoint_icon() -> String {
        return self.wayPoint[0][0].icon
    }
    
    func get_WayPoint_Latitude() -> Double {
        return self.wayPoint[0][0].latitude
    }
    
    func get_WayPoint_Longitude() -> Double {
        return self.wayPoint[0][0].longitude
    }
    
    func get_WayPoint_Name() -> String {
        return self.wayPoint[0][0].name
    }
    
    public var wayPoint_String: String {return "WayPoint =  nom : \(self.wayPoint[0][0].name), icon : \(self.wayPoint[0][0].icon), latitude : \(self.wayPoint[0][0].latitude) et longitude : \(self.wayPoint[0][0].longitude)"}
    **/
}

struct wayPoint {
    var swLatitude: Double
    var swLongitude: Double
    var aiName: String
    
    var icon: String
}

