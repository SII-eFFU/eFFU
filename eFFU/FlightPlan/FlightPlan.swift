//
//  FlightPlan.swift
//  eFFU
//
//  Created by admin on 26/04/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

class FlightPlan {
    
    // Creation des variables permettant de configurer l'aerodrome de depart et d'arrivee
    /**
    var nameDeparture: String
    var aiIcaoDeparture : String
    var latitudeDeparture : Double
    var longitudeDeparture: Double
    
    var nameArrival  : String
    var aiIcaoArrival   : String
    var latitudeArrival : Double
    var longitudeArrival: Double
    **/
    
     var departure_Airfield = [[(name: String, aiIcao: String, latitude: Double, longitude: Double)]]()
     var arrival_Airfield = [[(name: String, aiIcao: String, latitude: Double, longitude: Double)]]()
    
    //var departure_Airfield : [[(name: String, aiIcao: String, latitude: Double, longitude: Double)]]
    //name_Departure_Airfield = departure_Airfield[0][1].name
    
    // Initialisation des variables
    /**
    init(){
        self.nameDeparture = ""
        self.aiIcaoDeparture = ""
        self.latitudeDeparture = 0.0
        self.longitudeDeparture = 0.0
        
        self.nameArrival = ""
        self.aiIcaoArrival = ""
        self.latitudeArrival = 0.0
        self.longitudeArrival = 0.0
    }
    **/
    
    // Permet de set l'aerodrome de depart
    func set_Departure_Airfield(aiIcao: String, name: String, latitude: Double, longitude: Double){
        /**
        self.aiIcaoDeparture = aiIcao
        self.nameDeparture = name
        self.latitudeDeparture = latitude
        self.longitudeDeparture = longitude
        
        self.departure_Airfield.append([(name: self.nameDeparture, aiIcao: self.aiIcaoDeparture, latitude: self.latitudeDeparture, longitude: self.longitudeDeparture)])
        **/
        self.departure_Airfield.append([(name: name, aiIcao: aiIcao, latitude: latitude, longitude: longitude)])
    }
    
    // Permet de set l'aerodrome d'arrivee
    func set_Arrival_Airfield(aiIcao: String, name: String, latitude: Double, longitude: Double){
        /**
        self.aiIcaoArrival = aiIcao
        self.nameArrival = name
        self.latitudeArrival = latitude
        self.longitudeArrival = longitude
        
        self.arrival_Airfield.append([(name: self.nameArrival, aiIcao: self.aiIcaoArrival, latitude: self.latitudeArrival, longitude: self.longitudeArrival)])
        **/
        self.arrival_Airfield.append([(name: name, aiIcao: aiIcao, latitude: latitude, longitude: longitude)])
    }
    
    func unset_Departure_Airfield(){
        if (!self.departure_Airfield.isEmpty){
            self.departure_Airfield.removeLast()
        }
    }
    
    func unset_Arrival_Airfield(){
        if (!self.arrival_Airfield.isEmpty){
            self.arrival_Airfield.removeLast()
        }
    }
    
    public var airport_Departure: String {return "Aerodrome de depart =  nom : \(departure_Airfield[0][0].name), aiIcao : \(departure_Airfield[0][0].aiIcao),latitude : \(departure_Airfield[0][0].latitude) et longitude : \(departure_Airfield[0][0].longitude)"}
    
     public var airport_Arrival: String {return "Aerodrome d'arrivee = nom : \(arrival_Airfield[0][0].name), aiIcao : \(arrival_Airfield[0][0].aiIcao),latitude : \(arrival_Airfield[0][0].latitude) et longitude : \(arrival_Airfield[0][0].longitude)"}
    
}
