//
//  Database.swift
//  eFFUNOV5
//
//  Created by admin on 20/12/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import UIKit
import Mapbox
import MapKit
import CoreLocation
import SQLite3

public struct airports {
    
    var pkUid: Int32
    var aiIcao: String
    var aiName: String
    var aiType: String
    
    var aiMagVar: Double
    var aiArpPosition: String
    
    var swLatitude: Double
    var swLongitude: Double
    
    var aiAlt: Double
    var aiGund: Double
    
    var aiTwrFreq: Double
    var swNbrPhoto: Int
    
    var osmId: Int32
    var aiRwy: String
    var aiDimensions: String
    var aiQfu: Int32
    var aiSurface: String
    var aiThrGeoPosition: String
    var aiThrAlt: Int32
    var aiDthrGeoPosition: String
    var aiDthrAlt: Int32
    var aiStrength: String
    var aiToda: Int32
    var aiAsda: Int32
    var aiLda: Int32
    var aiLightingAids: String
    var aiOppositeRwy: String
    var swCoordinates: String
    
    var iconesAirports: String
    var visibleAirports: Bool
 
    
}

public struct villes {
    
    var pkUid: Int32
    var idGeofla: Int32
    var codeComm: Int32
    var inseeCom: Int32
    var nomComm: String
    var statut: String
    var xChfLieu: Int32
    var yChfLieu: Int32
    var xCentroid: Int32
    var yCentroid: Int32
    var zMoyen: Int32
    var superficie: Double
    var population: Double
    var codeCant: Int32
    var codeArr: Int32
    var codeDept: Int32
    var codeReg: Int32
    var nomRegion: String
    var swLatitude: Double
    var swLongitude: Double
    var swNbPhoto: Int32
    var tgNomComm: String
    
    var iconesCity: String
    var visibleCity: Bool
    
}

public struct reperesVisuels {
    
    var pkUid: Int32
    var ident: String
    var swLongName: String
    var swShortName: String
    var swLatitude: Double
    var swLongitude: Double
    var swKind:String
    var swVerified: String
    var swNbPhoto: Int32
    var swDepatement: Int32
    var swComments: String
    
    var iconeReperesVisuel: String
    var visibleReperesVisuel: Bool
}

public struct navwarning {
    
    var pkUid: Int32
    var aiType: String
    var aiSourceId: Int32
    var aiLongName: String
    var aiSubtype: String
    var aiMultiple: Int32
    var aiCoords: String
    var swLatitude: Double
    var swLongitude: Double
    var aiAlt: Int32
    var aiHeight: Int32
    var aiLighting: String
    var aiRemarks: String
    var swLocalityNbr: Int32
    var swLocalityName: String
    var swReginalNbr: Int32
    var wRegionalName: String
    var wCountryName: String
    
    var iconeNavwarning: String
    var visibleNavwarning: Bool
    
}

public struct navaids {
    
    var pkUid: Int32
    var aiStation: String
    var aiService: String
    var aiId: String
    var aiType: String
    var aiPosition: String
    var swLatitude: Double
    var swLongitude: Double
    var aiFreq: String
    var aiHor: String
    var aiPortee: String
    var aiAlt: String
    var aiSituation: String
    
    var iconesNavaids: String
    var visibleNavaids: Bool
    
}


extension ViewController {
    
    func readAirportsDatabase() {
        
        let part1DbPath = Bundle.main.path(forResource: "eFFU_Ligth_BDD", ofType: "sqlite")
        
        var db: OpaquePointer? = nil
        if sqlite3_open(part1DbPath, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(part1DbPath!)")
            
            var queryStatementString = "SELECT AERODROME_v1.PK_UID, AERODROME_v1.AI_ICAO, AI_NAME, AI_TYPE, AI_MAG_VAR, AI_ARP_POSITION, SW_LAT, SW_LONG,"
            queryStatementString += "AI_ALT, AI_GUND, AI_TWR_FREQ, SW_NB_PHOTO, ifnull(osm_id, 0), ifnull(AI_RWY,''), ifnull(AI_DIMENSIONS,' 0 x 0'), ifnull(AI_QFU,0)"
            queryStatementString += ", ifnull(AI_SURFACE,''), ifnull(AI_THR_GEO_POSITION,''), ifnull(AI_THR_ALT,0), ifnull(AI_DTHR_GEO_POSITION,''), ifnull(AI_DTHR_ALT,0)"
            queryStatementString += ", ifnull(AI_STRENGTH,''), ifnull(AI_TODA,0), ifnull(AI_ASDA,0), ifnull(AI_LDA,0), ifnull(AI_LIGHTING_AIDS,''), ifnull(AI_OPPOSITE_RWY,''),"
            queryStatementString += "ifnull(SW_COORDINATES,'') FROM AERODROME_v1 INNER JOIN RUNWAY3 ON AERODROME_v1.AI_ICAO = RUNWAY3.AI_ICAO;"
            
            var queryStatement: OpaquePointer? = nil
            
            var indexCount = 0
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                
                
                while (sqlite3_step(queryStatement) == SQLITE_ROW) {
                    
                    airportsDatabase[indexCount] = airports (
                        
                        pkUid: sqlite3_column_int(queryStatement, 0),
                        aiIcao: String(cString: sqlite3_column_text(queryStatement, 1)),
                        aiName: String(cString: sqlite3_column_text(queryStatement, 2)),
                        aiType: String(cString: sqlite3_column_text(queryStatement, 3)),
                        
                        aiMagVar: sqlite3_column_double(queryStatement, 4),
                        aiArpPosition: String(cString: sqlite3_column_text(queryStatement, 5)),
                        
                        swLatitude: sqlite3_column_double(queryStatement, 6),
                        swLongitude: sqlite3_column_double(queryStatement, 7),
                        
                        aiAlt: sqlite3_column_double(queryStatement, 8),
                        aiGund: sqlite3_column_double(queryStatement, 9),
                        
                        aiTwrFreq: sqlite3_column_double(queryStatement, 10),
                        swNbrPhoto: Int(sqlite3_column_int(queryStatement, 11)),
                        
                        
                        osmId: sqlite3_column_int(queryStatement, 12),
                        aiRwy: String(cString: sqlite3_column_text(queryStatement, 13)),
                        aiDimensions: String(cString: sqlite3_column_text(queryStatement, 14)),
                        aiQfu: sqlite3_column_int(queryStatement, 15),
                        aiSurface: String(cString: sqlite3_column_text(queryStatement, 16)),
                        aiThrGeoPosition: String(cString: sqlite3_column_text(queryStatement, 17)),
                        aiThrAlt: sqlite3_column_int(queryStatement, 18),
                        aiDthrGeoPosition: String(cString: sqlite3_column_text(queryStatement, 19)),
                        aiDthrAlt: sqlite3_column_int(queryStatement, 20),
                        aiStrength: String(cString: sqlite3_column_text(queryStatement, 21)),
                        aiToda: sqlite3_column_int(queryStatement, 22),
                        aiAsda: sqlite3_column_int(queryStatement, 23),
                        aiLda: sqlite3_column_int(queryStatement, 24),
                        aiLightingAids: String(cString: sqlite3_column_text(queryStatement, 25)),
                        aiOppositeRwy: String(cString: sqlite3_column_text(queryStatement, 26)),
                        swCoordinates: String(cString: sqlite3_column_text(queryStatement, 27)),
                        
                        iconesAirports: "",
                        visibleAirports: false
                    
                        
                        
                    )
                    
                    indexCount = indexCount + 1
                    
                }
                
                print (airportsDatabase[6]!.aiName)
                print (indexCount)
                
                
            } else {
                print("SELECT statement could not be prepared")
            }
            
            sqlite3_finalize(queryStatement)
            
        } else {
            print("Unable to open database. Verify that you created the directory described " +
                "in the Getting Started section.")
            
        }
        
        sqlite3_close(db)
        
    }
    
    func readVillesDatabase() {
        
        let part1DbPath = Bundle.main.path(forResource: "eFFU_Ligth_BDD", ofType: "sqlite")
        
        var db: OpaquePointer? = nil
        if sqlite3_open(part1DbPath, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(part1DbPath!)")
            
            let queryStatementString = "SELECT * FROM COMMUNES;"
            
            //var villesDatabase = [ Int: villes ]()
            
            var queryStatement: OpaquePointer? = nil
            
            var indexCount = 0
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                
                
                while (sqlite3_step(queryStatement) == SQLITE_ROW) {
                    
                    villesDatabase[indexCount] = villes (
                        
                        pkUid: sqlite3_column_int(queryStatement, 0),
                        idGeofla: sqlite3_column_int(queryStatement, 1),
                        codeComm: sqlite3_column_int(queryStatement, 2),
                        inseeCom: sqlite3_column_int(queryStatement, 3),
                        nomComm: String(cString: sqlite3_column_text(queryStatement, 4)),
                        statut: String(cString: sqlite3_column_text(queryStatement, 5)),
                        xChfLieu: sqlite3_column_int(queryStatement, 6),
                        yChfLieu: sqlite3_column_int(queryStatement, 7),
                        xCentroid: sqlite3_column_int(queryStatement, 8),
                        yCentroid: sqlite3_column_int(queryStatement, 9),
                        zMoyen: sqlite3_column_int(queryStatement, 10),
                        superficie: sqlite3_column_double(queryStatement, 11),
                        population: sqlite3_column_double(queryStatement, 12),
                        codeCant: sqlite3_column_int(queryStatement, 13),
                        codeArr: sqlite3_column_int(queryStatement, 14),
                        codeDept: sqlite3_column_int(queryStatement, 15),
                        codeReg: sqlite3_column_int(queryStatement, 17),
                        nomRegion: String(cString: sqlite3_column_text(queryStatement, 18)),
                        swLatitude: sqlite3_column_double(queryStatement, 20),
                        swLongitude: sqlite3_column_double(queryStatement, 21),
                        swNbPhoto: sqlite3_column_int(queryStatement, 22),
                        tgNomComm: String(cString: sqlite3_column_text(queryStatement, 23)),
                        
                        iconesCity: "",
                        visibleCity: false
                        
                    )
                    
                    indexCount = indexCount + 1
                    
                }
                
                print (villesDatabase[30]!.nomComm)
                print (indexCount)
                
                
            } else {
                print("SELECT statement could not be prepared")
            }
            
            sqlite3_finalize(queryStatement)
            
        } else {
            print("Unable to open database. Verify that you created the directory described " +
                "in the Getting Started section.")
            
        }
        
        sqlite3_close(db)
        
    }
    
    func readWarningDatabase() {
        
        let part1DbPath = Bundle.main.path(forResource: "eFFU_Ligth_BDD", ofType: "sqlite")
        
        var db: OpaquePointer? = nil
        if sqlite3_open(part1DbPath, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(part1DbPath!)")
            
            let queryStatementString = "SELECT PK_UID, AI_TYPE, AI_SOURCE_ID, ifnull(AI_LONG_NAME, ''), ifnull(AI_SUBTYPE, ''), ifnull(AI_MULTIPLE,''), AI_COORDS, SW_LAT, SW_LONG,  ifnull(AI_ALT,''), ifnull(AI_HEIGHT,''), ifnull(AI_LIGHTING, ''), ifnull(AI_REMARKS, ''), ifnull(SW_LOCALITY_NBR, ''), ifnull(SW_LOCALITY_NAME, ''), ifnull(SW_REGIONAL_NBR,0), ifnull(SW_REGIONAL_NAME, ''), ifnull(SW_COUNTRY_NAME,'') FROM MISC_NAV_WARNINGS;"
            
            
            var queryStatement: OpaquePointer? = nil
            
            var indexCount = 0
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                
                
                while (sqlite3_step(queryStatement) == SQLITE_ROW) {
                    
                    navWarningDatabase[indexCount] = navwarning (
                        
                     pkUid: sqlite3_column_int(queryStatement, 0),
                     aiType: String(cString: sqlite3_column_text(queryStatement, 1)),
                     aiSourceId: sqlite3_column_int(queryStatement, 2),
                     aiLongName: String(cString: sqlite3_column_text(queryStatement, 3)),
                     aiSubtype: String(cString: sqlite3_column_text(queryStatement, 4)),
                     aiMultiple: sqlite3_column_int(queryStatement, 5),
                     aiCoords: String(cString: sqlite3_column_text(queryStatement, 6)),
                     swLatitude: sqlite3_column_double(queryStatement, 7),
                     swLongitude: sqlite3_column_double(queryStatement, 8),
                     aiAlt: sqlite3_column_int(queryStatement, 9),
                     aiHeight: sqlite3_column_int(queryStatement, 10),
                     aiLighting: String(cString: sqlite3_column_text(queryStatement, 11)),
                     aiRemarks: String(cString: sqlite3_column_text(queryStatement, 12)),
                     swLocalityNbr: sqlite3_column_int(queryStatement, 13),
                     swLocalityName: String(cString: sqlite3_column_text(queryStatement, 14)),
                     swReginalNbr: sqlite3_column_int(queryStatement, 15),
                     wRegionalName: String(cString: sqlite3_column_text(queryStatement, 16)),
                     wCountryName: String(cString: sqlite3_column_text(queryStatement, 17)),
                     
                    iconeNavwarning: "",
                    visibleNavwarning: false
                    
                    )
                    
                    indexCount = indexCount + 1
                    
                }
                
                print (navWarningDatabase[5]!)
                print (indexCount)
                
                
            } else {
                print("SELECT statement could not be prepared")
            }
            
            sqlite3_finalize(queryStatement)
            
        } else {
            print("Unable to open database. Verify that you created the directory described " +
                "in the Getting Started section.")
            
        }
        
        sqlite3_close(db)
        
    }
    
    func readReperesVisuelsDatabase() {
        
        let part1DbPath = Bundle.main.path(forResource: "eFFU_Ligth_BDD", ofType: "sqlite")
        
        var db: OpaquePointer? = nil
        if sqlite3_open(part1DbPath, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(part1DbPath!)")
            
            let queryStatementString = "SELECT * FROM REPERES_VISUELS;"
            
            //var reperesVisuelsDatabase = [ Int: reperesVisuels ]()
            
            var queryStatement: OpaquePointer? = nil
            
            var indexCount = 0
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                
                
                while (sqlite3_step(queryStatement) == SQLITE_ROW) {
                    
                    reperesVisuelsDatabase[indexCount] = reperesVisuels (
                        
                        pkUid: sqlite3_column_int(queryStatement, 0),
                        ident: String(cString: sqlite3_column_text(queryStatement, 1)),
                        swLongName: String(cString: sqlite3_column_text(queryStatement, 2)),
                        swShortName: String(cString: sqlite3_column_text(queryStatement, 3)),
                        swLatitude: sqlite3_column_double(queryStatement, 6),
                        swLongitude: sqlite3_column_double(queryStatement, 7),
                        swKind: String(cString: sqlite3_column_text(queryStatement, 8)),
                        swVerified: String(cString: sqlite3_column_text(queryStatement, 9)),
                        swNbPhoto: sqlite3_column_int(queryStatement, 10),
                        swDepatement: sqlite3_column_int(queryStatement, 11),
                        swComments: String(cString: sqlite3_column_text(queryStatement, 12)),
                        
                        iconeReperesVisuel: "",
                        visibleReperesVisuel: false
                        
                    )
                    
                    indexCount = indexCount + 1
                    
                }
                
                print (reperesVisuelsDatabase[30]!.swLongName)
                print (indexCount)
                
                
            } else {
                print("SELECT statement could not be prepared")
            }
            
            sqlite3_finalize(queryStatement)
            
        } else {
            print("Unable to open database. Verify that you created the directory described " +
                "in the Getting Started section.")
            
        }
        
        sqlite3_close(db)
        
    }
    
    func readNavaidsDatabase() {
        
        let part1DbPath = Bundle.main.path(forResource: "eFFU_Ligth_BDD", ofType: "sqlite")
        
        var db: OpaquePointer? = nil
        if sqlite3_open(part1DbPath, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(part1DbPath!)")
            
            let queryStatementString = "SELECT PK_UID, AI_STATION, AI_SERVICE, ifnull(AI_ID,''), AI_TYPE, AI_POSITION, SW_LAT, SW_LONG, AI_FREQ,  ifnull(AI_HOR,''), ifnull(AI_PORTEE,''), ifnull(AI_ALT,''),  ifnull(AI_SITUATION,'') FROM NAVAIDS;"
            
            //var navaidsDatabase = [ Int: navaids ]()
            
            var queryStatement: OpaquePointer? = nil
            
            var indexCount = 0
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                
                
                while (sqlite3_step(queryStatement) == SQLITE_ROW) {
                    
                    navaidsDatabase[indexCount] = navaids (
                        
                        pkUid: sqlite3_column_int(queryStatement, 0),
                        aiStation: String(cString: sqlite3_column_text(queryStatement, 1)),
                        aiService: String(cString: sqlite3_column_text(queryStatement, 2)),
                        aiId: String(cString: sqlite3_column_text(queryStatement, 3)),
                        aiType: String(cString: sqlite3_column_text(queryStatement, 4)),
                        aiPosition: String(cString: sqlite3_column_text(queryStatement, 5)),
                        swLatitude: sqlite3_column_double(queryStatement, 6),
                        swLongitude: sqlite3_column_double(queryStatement, 7),
                        aiFreq: String(cString: sqlite3_column_text(queryStatement, 8)),
                        aiHor: String(cString: sqlite3_column_text(queryStatement, 9)),
                        aiPortee: String(cString: sqlite3_column_text(queryStatement, 10)),
                        aiAlt: String(cString: sqlite3_column_text(queryStatement, 11)),
                        aiSituation: String(cString: sqlite3_column_text(queryStatement, 12)),
                        
                        iconesNavaids: "",
                        visibleNavaids: false
                        
                    )
                    
                    indexCount = indexCount + 1
                    
                }
                
                print (navaidsDatabase[29]!.aiStation)
                print (indexCount)
                
                
            } else {
                print("SELECT statement could not be prepared")
            }
            
            sqlite3_finalize(queryStatement)
            
        } else {
            print("Unable to open database. Verify that you created the directory described " +
                "in the Getting Started section.")
            
        }
        
        sqlite3_close(db)
        
    }
    
}
