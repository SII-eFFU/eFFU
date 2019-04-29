//
//  Cartographie.swift
//  eFFUNOV5
//
//  Created by Thierry Danthez on 02/12/2018.
//  Copyright © 2018 admin. All rights reserved.
//
import UIKit
import Mapbox
import MapKit
import CoreLocation

extension ViewController: MGLMapViewDelegate {
    
    /* Begin Of Function ******************************************************
     *    Chargement Cartographie                   *
     ************************************************/

    func mapBox(styleMapboxView: String, layerMapbox: Int, tagger: String) {
        
        print ("Couche Cartographique \(tagger) \(layerMapbox)")
    
        let viewWithTag = self.view.viewWithTag(layerMapbox)
        viewWithTag?.removeFromSuperview()
        
        mapView = MGLMapView(frame: view.bounds)
        //mapView.tag = layerMapbox
        mapView.tag = layerMapbox
        mapView.styleURL = URL(string: styleMapboxView )!
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.setCenter(localisationCenterMap, zoomLevel: zoomLevelMap, direction : directionMap, animated: false)
        mapView.compassView.isHidden=true
        mapView.logoView.isHidden=true
        mapView.attributionButton.alpha=0
        mapView.isUserInteractionEnabled = false
        mapView.showsUserHeadingIndicator = false
        //mapView.alpha = 1
        mapView.isZoomEnabled = false
        mapView.isScrollEnabled = false
        mapView.showsUserLocation = false
        mapView.allowsZooming = false
        mapView.allowsScrolling = false
        
        mapView.delegate = self
        if layerMapbox == 50 {
        
//        //gesture recognisers
//        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture:)))
//        swipeLeft.direction = .left
//        mapView.addGestureRecognizer(swipeLeft)
//
//        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture:)))
//        swipeRight.direction = .right
//        mapView.addGestureRecognizer(swipeRight)
//
//        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture:)))
//        swipeUp.direction = .up
//        mapView.addGestureRecognizer(swipeUp)
//
//        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture:)))
//        swipeDown.direction = .down
//        mapView.addGestureRecognizer(swipeDown)
        
        let tapRec = UITapGestureRecognizer()
        tapRec.addTarget(self, action: #selector(tapAction(sender:)))
        tapRec.numberOfTouchesRequired = 1
        tapRec.numberOfTapsRequired = 1
        mapView.addGestureRecognizer(tapRec)
            

            
//        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
//        edgePan.edges = .left
//        mapView.addGestureRecognizer(edgePan)
            
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchAction(gestureRecognizer:)))
        mapView.addGestureRecognizer(pinchGesture)
            
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(dragged(gestureRecognizer:)))
        mapView.addGestureRecognizer(panGesture)

        mapView.isUserInteractionEnabled = true
        
            //mapView.delegate = self
        //mapView.userTrackingMode = .followWithHeading
        mapView.showsUserHeadingIndicator = true
        //mapView.alpha = 1
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsUserLocation = true
        mapView.allowsZooming = true
        mapView.allowsScrolling = true
            

        mapView.delegate = self

            
        }
        
        view.insertSubview(mapView, at: layerMapbox)

    }

    /* End Of Function ******************************************************/
    
    /* Begin Of Function ******************************************************
     *    Chargement des couches cartographies + afficher Map1 +option 1 2 3 4 *
     **************************************************************************/
    
    @objc func affichageFondCartesMapbox() {
        print("reload Cartographie")
        //let containerMapView = UIView()
        print ("Localisation Coordonates Map \(localisationCenterMap) ")
        print ("Zoom Level Map \(zoomLevelMap) ")
        print ("Direction Map \(directionMap) ")
        
        //Cartes
        if applicationParametres.buttonOptionMapView[15] {
            let viewWithTag2 = self.view.viewWithTag(2)
            viewWithTag2?.removeFromSuperview()
            let viewWithTag3 = self.view.viewWithTag(3)
            viewWithTag3?.removeFromSuperview()
            let viewWithTag4 = self.view.viewWithTag(4)
            viewWithTag4?.removeFromSuperview()
            let viewWithTag5 = self.view.viewWithTag(5)
            viewWithTag5?.removeFromSuperview()
            mapBox(styleMapboxView: "mapbox://styles/mapbox/bright-v9", layerMapbox: 1, tagger: "Cartes1")
        }
        if applicationParametres.buttonOptionMapView[16] {
            let viewWithTag1 = self.view.viewWithTag(1)
            viewWithTag1?.removeFromSuperview()
            let viewWithTag3 = self.view.viewWithTag(3)
            viewWithTag3?.removeFromSuperview()
            let viewWithTag4 = self.view.viewWithTag(4)
            viewWithTag4?.removeFromSuperview()
            let viewWithTag5 = self.view.viewWithTag(5)
            viewWithTag5?.removeFromSuperview()
            mapBox(styleMapboxView: "mapbox://styles/mapbox/outdoors-v9", layerMapbox: 2, tagger: "Cartes2")
        }
        if applicationParametres.buttonOptionMapView[17] {
            let viewWithTag1 = self.view.viewWithTag(1)
            viewWithTag1?.removeFromSuperview()
            let viewWithTag2 = self.view.viewWithTag(2)
            viewWithTag2?.removeFromSuperview()
            let viewWithTag4 = self.view.viewWithTag(4)
            viewWithTag4?.removeFromSuperview()
            let viewWithTag5 = self.view.viewWithTag(5)
            viewWithTag5?.removeFromSuperview()
        mapBox(styleMapboxView: "mapbox://styles/mapbox/dark-v9", layerMapbox: 3, tagger: "Cartes3")
        }
        if applicationParametres.buttonOptionMapView[18] {
            let viewWithTag1 = self.view.viewWithTag(1)
            viewWithTag1?.removeFromSuperview()
            let viewWithTag2 = self.view.viewWithTag(2)
            viewWithTag2?.removeFromSuperview()
            let viewWithTag3 = self.view.viewWithTag(3)
            viewWithTag3?.removeFromSuperview()
            let viewWithTag5 = self.view.viewWithTag(5)
            viewWithTag5?.removeFromSuperview()
        mapBox(styleMapboxView: "mapbox://styles/mapbox/satellite-v9", layerMapbox: 4, tagger: "Cartes4")
        }
        if applicationParametres.buttonOptionMapView[19] {
            let viewWithTag1 = self.view.viewWithTag(1)
            viewWithTag1?.removeFromSuperview()
            let viewWithTag2 = self.view.viewWithTag(2)
            viewWithTag2?.removeFromSuperview()
            let viewWithTag3 = self.view.viewWithTag(3)
            viewWithTag3?.removeFromSuperview()
            let viewWithTag4 = self.view.viewWithTag(4)
            viewWithTag4?.removeFromSuperview()
        mapBox(styleMapboxView: "mapbox://styles/mapbox/satellite-streets-v9", layerMapbox: 5, tagger: "Cartes5")
        }
        
        carteFIR()
        drawPolyLineShape()
        drawRoutePlane()
        carteReperesVisuels()
        carteReperesVisuelsMontagne()
        carteReperesVisuelsLac()
        carteReperesVisuelsForet()
        carteWarningInterdictions()
        carteAirports()
        carteVilles()
        carteNavaidsTerminal()
        carteNavaidsEnRoute()
        carteZoneAeriennes()
        
        
        //Gesture
        mapBox(styleMapboxView: "mapbox://styles/effumaps/cjpx6n3z101lc2smpdn9zrzvf", layerMapbox: 50, tagger: "Gesture")
        
        ReloadMapboxViewOption()
        
    }
    
    func carteFIR() {
    
        //FIR
        mapBox(styleMapboxView: "mapbox://styles/effumaps/cj3vq623u0cth2skh4wdurufv", layerMapbox: 10, tagger: "FIR")
        
    }
    func carteZoneAeriennes() {
        if applicationParametres.buttonOptionMapView[6] {
            //Terminal
            mapBox(styleMapboxView: "mapbox://styles/effumaps/cj446al708rsp2spbbkkjh8at", layerMapbox: 11, tagger: "Terminal")
        } else {
            let viewWithTag11 = self.view.viewWithTag(11) // Zones Aeriennes
            viewWithTag11?.removeFromSuperview()
        }
    }
    
    func carteReperesVisuels() {
    
        if applicationParametres.buttonOptionMapView[10] {

        //Landmarks
        mapBox(styleMapboxView: "mapbox://styles/effumaps/cjpx6n3z101lc2smpdn9zrzvf", layerMapbox: 12, tagger: "Landmarks")
        
        var annotationNumber: Int = 0
        for i in 0...reperesVisuelsDatabase.count-1 {
            
            if reperesVisuelsDatabase[i]!.swKind != "Montagne" && reperesVisuelsDatabase[i]!.swKind != "Forêt" && reperesVisuelsDatabase[i]!.swKind != "Lac" &&
                (reperesVisuelsDatabase[i]!.swDepatement == 33  || reperesVisuelsDatabase[i]!.swDepatement == 64  ||  reperesVisuelsDatabase[i]!.swDepatement == 47  ||  reperesVisuelsDatabase[i]!.swDepatement == 40  ||  reperesVisuelsDatabase[i]!.swDepatement == 24  ||  reperesVisuelsDatabase[i]!.swDepatement == 09  ||  reperesVisuelsDatabase[i]!.swDepatement == 12  ||  reperesVisuelsDatabase[i]!.swDepatement == 31  ||  reperesVisuelsDatabase[i]!.swDepatement == 46  ||  reperesVisuelsDatabase[i]!.swDepatement == 65  ||  reperesVisuelsDatabase[i]!.swDepatement == 81  ||  reperesVisuelsDatabase[i]!.swDepatement == 82) {
                
                    let point1 = mapView.convert(CLLocationCoordinate2D(latitude: reperesVisuelsDatabase[i]!.swLatitude, longitude: reperesVisuelsDatabase[i]!.swLongitude), toPointTo:mapView)
                    reperesVisuelsDatabase[i]!.visibleReperesVisuel = false
                    if (point1.x > 0.0 && point1.y > 0.0 &&
                        point1.x < self.mapView.frame.size.width &&
                        point1.y < self.mapView.frame.size.height) {
                        annotationNumber = annotationNumber + 1
                        print("Coordinate: \(point1.x), \(point1.y) - > \(annotationNumber)")
                
                //print (reperesVisuelsDatabase[i]!.swKind)
                        
                let point = CustomPointAnnotation(coordinate: CLLocationCoordinate2DMake(reperesVisuelsDatabase[i]!.swLatitude, reperesVisuelsDatabase[i]!.swLongitude),
                                                  title: "", //title: reperesVisuelsDatabase[i]!.swShortName,
                                                  subtitle: "" //subtitle: reperesVisuelsDatabase[i]!.swLongName
            )
            
            point.reuseIdentifier = reperesVisuelsDatabase[i]!.swKind
                        
            if reperesVisuelsDatabase[i]!.swKind == "Volcan" {
                nameImage = "MAP-INF-VOLC"
            } else if reperesVisuelsDatabase[i]!.swKind == "Espace vert" {
                nameImage = "MAP-INF-VERT"
            } else if reperesVisuelsDatabase[i]!.swKind == "Cimetière" {
                nameImage = "MAP-INF-CIMT"
            } else if reperesVisuelsDatabase[i]!.swKind == "Barrage" {
                nameImage = "MAP-INF-BARR"
            } else if reperesVisuelsDatabase[i]!.swKind == "Commerces" {
                nameImage = "MAP-INF-COMM"
            } else if reperesVisuelsDatabase[i]!.swKind == "Château d'eau" {
                nameImage = "MAP-INF-CH_O"
            } else if reperesVisuelsDatabase[i]!.swKind == "Château Renaissance" {
                nameImage = "MAP-INF-CH_R"
            } else if reperesVisuelsDatabase[i]!.swKind == "Circuit" {
                nameImage = "MAP-INF-CIRC"
            } else if reperesVisuelsDatabase[i]!.swKind == "Terrain de golf" {
                nameImage = "MAP-INF-GOLF"
            } else if reperesVisuelsDatabase[i]!.swKind == "Hippodrome" {
                nameImage = "MAP-INF-HIPO"
            } else if reperesVisuelsDatabase[i]!.swKind == "Pont" {
                nameImage = "MAP-INF-PONT"
            } else if reperesVisuelsDatabase[i]!.swKind == "Edifice religieux" {
                nameImage = "MAP-INF-RELG"
            } else if reperesVisuelsDatabase[i]!.swKind == "Stade" {
                nameImage = "MAP-INF-STAD"
            } else if reperesVisuelsDatabase[i]!.swKind == "Château fort" {
                nameImage = "MAP-INF-CH_F"
            } else if reperesVisuelsDatabase[i]!.swKind == "Usine" {
                nameImage = "MAP-INF-USIN"
            } else if reperesVisuelsDatabase[i]!.swKind == "Gare de péage" {
                nameImage = "MAP-INF-PEAJ"
            } else if reperesVisuelsDatabase[i]!.swKind == "Salle de spectacle" {
                nameImage = "MAP-INF-SALL"
            } else if reperesVisuelsDatabase[i]!.swKind == "Station essence" {
                nameImage = "MAP-INF-ESSC"
            } else if reperesVisuelsDatabase[i]!.swKind == "Péage" {
                nameImage = "MAP-INF-PEAJ"
            } else if reperesVisuelsDatabase[i]!.swKind == "Dune" {
                nameImage = "MAP-INF-DUNE"
            } else if reperesVisuelsDatabase[i]!.swKind == "Terrain de tennis" {
                nameImage = "MAP-INF-TENN"
            } else if reperesVisuelsDatabase[i]!.swKind == "Armée" {
                nameImage = "MAP-INF-MILI"
            } else if reperesVisuelsDatabase[i]!.swKind == "Hôpital" {
                nameImage = "MAP-INF-HOPT"
            } else if reperesVisuelsDatabase[i]!.swKind == "Port" {
                nameImage = "MAP-INF-PORT"
            } else if reperesVisuelsDatabase[i]!.swKind == "Parc d'attractions" {
                nameImage = "MAP-INF-PARC"
            } else if reperesVisuelsDatabase[i]!.swKind == "Gare ferroviaire" {
                nameImage = "MAP-INF-GARE"
            } else if reperesVisuelsDatabase[i]!.swKind == "Ruines" {
                nameImage = "MAP-INF-RUIN"
            } else if reperesVisuelsDatabase[i]!.swKind == "Donjon" {
                nameImage = "MAP-INF-DNJN"
            } else if reperesVisuelsDatabase[i]!.swKind == "Ile" {
                nameImage = "MAP-INF-ILE_"
            } else if reperesVisuelsDatabase[i]!.swKind == "Ferme solaire" {
                nameImage = "MAP-INF-FSOL"
            } else if reperesVisuelsDatabase[i]!.swKind == "Mine et Carrière" {
                nameImage = "MAP-INF-MINE"
            } else if reperesVisuelsDatabase[i]!.swKind == "Confluence" {
                nameImage = "MAP-INF-XRIV"
            } else if reperesVisuelsDatabase[i]!.swKind == "Parc naturel" {
                nameImage = "MAP-INF-NATU"
            } else if reperesVisuelsDatabase[i]!.swKind == "Gare de triage" {
                nameImage = "MAP-INF-TRIA"
            } else if reperesVisuelsDatabase[i]!.swKind == "Espace aquatique" {
                nameImage = "MAP-INF-PISC"
            } else if reperesVisuelsDatabase[i]!.swKind == "Croisement routier" {
                nameImage = "MAP-INF-XAUT"
            } else {
             print ("Annotation Inconnue \(reperesVisuelsDatabase[i]!.swKind)")
            }
            reperesVisuelsDatabase[i]!.iconeReperesVisuel = nameImage
            reperesVisuelsDatabase[i]!.visibleReperesVisuel = true
            point.image = UIImage(named: nameImage)
            mapView.addAnnotation(point)
                
                }
            }
        }
            
        } else {
            let viewWithTag12 = self.view.viewWithTag(12) // Reperes Visuels Autres
            viewWithTag12?.removeFromSuperview()

        }
    }
        func carteReperesVisuelsMontagne() {
            if applicationParametres.buttonOptionMapView[12] {

        //Montagne
        mapBox(styleMapboxView: "mapbox://styles/effumaps/cjpx6n3z101lc2smpdn9zrzvf", layerMapbox: 19, tagger: "Montagne")
        
        var annotationNumber: Int = 0
        for i in 0...reperesVisuelsDatabase.count-1 {
            
            if (reperesVisuelsDatabase[i]!.swKind == "Montagne" || reperesVisuelsDatabase[i]!.swKind == "Volcan") &&
                (reperesVisuelsDatabase[i]!.swDepatement == 33  || reperesVisuelsDatabase[i]!.swDepatement == 64  ||  reperesVisuelsDatabase[i]!.swDepatement == 47  ||  reperesVisuelsDatabase[i]!.swDepatement == 40  ||  reperesVisuelsDatabase[i]!.swDepatement == 24  ||  reperesVisuelsDatabase[i]!.swDepatement == 09  ||  reperesVisuelsDatabase[i]!.swDepatement == 12  ||  reperesVisuelsDatabase[i]!.swDepatement == 31  ||  reperesVisuelsDatabase[i]!.swDepatement == 46  ||  reperesVisuelsDatabase[i]!.swDepatement == 65  ||  reperesVisuelsDatabase[i]!.swDepatement == 81  ||  reperesVisuelsDatabase[i]!.swDepatement == 82  ||  reperesVisuelsDatabase[i]!.swDepatement == 0) {
                
                let point1 = mapView.convert(CLLocationCoordinate2D(latitude: reperesVisuelsDatabase[i]!.swLatitude, longitude: reperesVisuelsDatabase[i]!.swLongitude), toPointTo:mapView)
                reperesVisuelsDatabase[i]!.visibleReperesVisuel = false
                if (point1.x > 0.0 && point1.y > 0.0 &&
                    point1.x < self.mapView.frame.size.width &&
                    point1.y < self.mapView.frame.size.height) {
                    annotationNumber = annotationNumber + 1
                    print("Coordinate: \(point1.x), \(point1.y) - > \(annotationNumber)")
                //print (reperesVisuelsDatabase[i]!.swKind)
                
                let point = CustomPointAnnotation(coordinate: CLLocationCoordinate2DMake(reperesVisuelsDatabase[i]!.swLatitude, reperesVisuelsDatabase[i]!.swLongitude),
                                                  title: "",  //title: reperesVisuelsDatabase[i]!.swShortName,
                                                  subtitle:"" //subtitle: reperesVisuelsDatabase[i]!.swLongName
                )
                
                point.reuseIdentifier = reperesVisuelsDatabase[i]!.swKind
                nameImage = "Triangle_32"
                reperesVisuelsDatabase[i]!.iconeReperesVisuel = nameImage
                reperesVisuelsDatabase[i]!.visibleReperesVisuel = true
                point.image = UIImage(named: nameImage)

                mapView.addAnnotation(point)
                
            }
            }
            
        }
                
            } else {
                let viewWithTag19 = self.view.viewWithTag(19) // Montagnes
                viewWithTag19?.removeFromSuperview()

            }
        }
        func carteReperesVisuelsForet() {
            if applicationParametres.buttonOptionMapView[13] {

        //Foret
        mapBox(styleMapboxView: "mapbox://styles/effumaps/cjpx6n3z101lc2smpdn9zrzvf", layerMapbox: 20, tagger: "Forêt")
        
        var annotationNumber: Int = 0
        for i in 0...reperesVisuelsDatabase.count-1 {
            
            if reperesVisuelsDatabase[i]!.swKind == "Forêt" &&
            (reperesVisuelsDatabase[i]!.swDepatement == 33  || reperesVisuelsDatabase[i]!.swDepatement == 64  ||  reperesVisuelsDatabase[i]!.swDepatement == 47  ||  reperesVisuelsDatabase[i]!.swDepatement == 40  ||  reperesVisuelsDatabase[i]!.swDepatement == 24  ||  reperesVisuelsDatabase[i]!.swDepatement == 09  ||  reperesVisuelsDatabase[i]!.swDepatement == 12  ||  reperesVisuelsDatabase[i]!.swDepatement == 31  ||  reperesVisuelsDatabase[i]!.swDepatement == 46  ||  reperesVisuelsDatabase[i]!.swDepatement == 65  ||  reperesVisuelsDatabase[i]!.swDepatement == 81  ||  reperesVisuelsDatabase[i]!.swDepatement == 82 )  {
                
                let point1 = mapView.convert(CLLocationCoordinate2D(latitude: reperesVisuelsDatabase[i]!.swLatitude, longitude: reperesVisuelsDatabase[i]!.swLongitude), toPointTo:mapView)
                reperesVisuelsDatabase[i]!.visibleReperesVisuel = false
                if (point1.x > 0.0 && point1.y > 0.0 &&
                    point1.x < self.mapView.frame.size.width &&
                    point1.y < self.mapView.frame.size.height) {
                    annotationNumber = annotationNumber + 1
                    print("Coordinate: \(point1.x), \(point1.y) - > \(annotationNumber)")
                    
                //print (reperesVisuelsDatabase[i]!.swKind)
                
                let point = CustomPointAnnotation(coordinate: CLLocationCoordinate2DMake(reperesVisuelsDatabase[i]!.swLatitude, reperesVisuelsDatabase[i]!.swLongitude),
                                                  title: "",  //title: reperesVisuelsDatabase[i]!.swShortName,
                                                  subtitle:"" //subtitle: reperesVisuelsDatabase[i]!.swLongName
                )
                
                point.reuseIdentifier = reperesVisuelsDatabase[i]!.swKind
      
                    nameImage = "Tree_32"
                    reperesVisuelsDatabase[i]!.iconeReperesVisuel = nameImage
                    reperesVisuelsDatabase[i]!.visibleReperesVisuel = true
                    point.image = UIImage(named: nameImage)
                
                mapView.addAnnotation(point)
                
            }
            
        }
            
                }
        
                
            }  else {
                let viewWithTag20 = self.view.viewWithTag(20) // Foret
                viewWithTag20?.removeFromSuperview()

            }
        }
        func carteReperesVisuelsLac() {
            if applicationParametres.buttonOptionMapView[14] {
        //Lac
        mapBox(styleMapboxView: "mapbox://styles/effumaps/cjpx6n3z101lc2smpdn9zrzvf", layerMapbox: 21, tagger: "Lac")
        
        var annotationNumber: Int = 0
        for i in 0...reperesVisuelsDatabase.count-1 {
            
            if reperesVisuelsDatabase[i]!.swKind == "Lac" &&
                (reperesVisuelsDatabase[i]!.swDepatement == 33  || reperesVisuelsDatabase[i]!.swDepatement == 64  ||  reperesVisuelsDatabase[i]!.swDepatement == 47  ||  reperesVisuelsDatabase[i]!.swDepatement == 40  ||  reperesVisuelsDatabase[i]!.swDepatement == 24  ||  reperesVisuelsDatabase[i]!.swDepatement == 09  ||  reperesVisuelsDatabase[i]!.swDepatement == 12  ||  reperesVisuelsDatabase[i]!.swDepatement == 31  ||  reperesVisuelsDatabase[i]!.swDepatement == 46  ||  reperesVisuelsDatabase[i]!.swDepatement == 65  ||  reperesVisuelsDatabase[i]!.swDepatement == 81  ||  reperesVisuelsDatabase[i]!.swDepatement == 82) {
                
                let point1 = mapView.convert(CLLocationCoordinate2D(latitude: reperesVisuelsDatabase[i]!.swLatitude, longitude: reperesVisuelsDatabase[i]!.swLongitude), toPointTo:mapView)
                reperesVisuelsDatabase[i]!.visibleReperesVisuel = false
                if (point1.x > 0.0 && point1.y > 0.0 &&
                    point1.x < self.mapView.frame.size.width &&
                    point1.y < self.mapView.frame.size.height) {
                    annotationNumber = annotationNumber + 1
                    print("Coordinate: \(point1.x), \(point1.y) - > \(annotationNumber)")
                
                //print (reperesVisuelsDatabase[i]!.swKind)
                
                let point = CustomPointAnnotation(coordinate: CLLocationCoordinate2DMake(reperesVisuelsDatabase[i]!.swLatitude, reperesVisuelsDatabase[i]!.swLongitude),
                                                  title: "",  //title: reperesVisuelsDatabase[i]!.swShortName,
                                                  subtitle:"" //subtitle: reperesVisuelsDatabase[i]!.swLongName
                )
                
                point.reuseIdentifier = reperesVisuelsDatabase[i]!.swKind

                    nameImage = "Lac_32"
                    reperesVisuelsDatabase[i]!.iconeReperesVisuel = nameImage
                    reperesVisuelsDatabase[i]!.visibleReperesVisuel = true
                    point.image = UIImage(named: nameImage)
                
                mapView.addAnnotation(point)
                
            }
            }
        }
            
            }  else {
                let viewWithTag21 = self.view.viewWithTag(21) // Lac
                viewWithTag21?.removeFromSuperview()

            }
        }
        
    func carteWarningInterdictions() {
        if applicationParametres.buttonOptionMapView[5] {
        //Warning
        //mapBox(styleMapboxView: "mapbox://styles/effumaps/cj7q7uqzjckwx2sr00ii3fjy8", layerMapbox: 13, tagger: "warning")
            mapBox(styleMapboxView: "mapbox://styles/effumaps/cjpx6n3z101lc2smpdn9zrzvf", layerMapbox: 13, tagger: "Warning Interdictions")
            var annotationNumber = 0
            for i in 0...navWarningDatabase.count-1 {
                
                    let point1 = mapView.convert(CLLocationCoordinate2D(latitude: navWarningDatabase[i]!.swLatitude, longitude: navWarningDatabase[i]!.swLongitude), toPointTo:mapView)
                    navWarningDatabase[i]!.visibleNavwarning = false
                    if (point1.x > 0.0 && point1.y > 0.0 &&
                        point1.x < self.mapView.frame.size.width &&
                        point1.y < self.mapView.frame.size.height) {
                        annotationNumber = annotationNumber + 1
                        
                        print("Coordinate: \(navWarningDatabase[i]!.aiSubtype) \(point1.x), \(point1.y) - > \(annotationNumber)")
                        
                        let point = CustomPointAnnotation(coordinate: CLLocationCoordinate2DMake(navWarningDatabase[i]!.swLatitude, navWarningDatabase[i]!.swLongitude),
                                                          title: navWarningDatabase[i]!.aiLongName,
                                                          subtitle: navWarningDatabase[i]!.aiSubtype
                        )
                        
                        point.reuseIdentifier = navWarningDatabase[i]!.aiSubtype
                         
                        if navWarningDatabase[i]!.aiType == "SURVOL INTERDIT" {
                            
                            nameImage = "MAP-INT-GNRL"
                            
                        } else if navWarningDatabase[i]!.aiType == "OBSTACLE" {
                            
                            if navWarningDatabase[i]!.aiSubtype == "Antenne" {
                                nameImage = "MAP-DGR-ANTN"
                            } else if navWarningDatabase[i]!.aiSubtype == "Pylône" {
                                nameImage = "MAP-DGR-PYLN"
                            } else if navWarningDatabase[i]!.aiSubtype == "Tour" {
                                nameImage = "MAP-DGR-TOUR"
                            } else if navWarningDatabase[i]!.aiSubtype == "Château d'eau" {
                                nameImage = "MAP-DGR-CH_O"
                            } else if navWarningDatabase[i]!.aiSubtype == "Bâtiment" {
                                nameImage = "MAP-DGR-BATI"
                            } else if navWarningDatabase[i]!.aiSubtype == "Mât" {
                                nameImage = "MAP-DGR-MAT_"
                            } else if navWarningDatabase[i]!.aiSubtype == "Cheminée" {
                                nameImage = "MAP-DGR-CH_E"
                            } else if navWarningDatabase[i]!.aiSubtype == "Centrale thermique" {
                                nameImage = "MAP-DGR-C_TH"
                            } else if navWarningDatabase[i]!.aiSubtype == "Eolienne(s)" {
                                nameImage = "MAP-DGR-EOL_"
                            } else if navWarningDatabase[i]!.aiSubtype == "Grue" {
                                nameImage = "MAP-DGR-GRUE"
                            } else if navWarningDatabase[i]!.aiSubtype == "Phare marin" {
                                nameImage = "MAP-DGR-FARE"
                            } else if navWarningDatabase[i]!.aiSubtype == "Pile de pont" {
                                nameImage = "MAP-DGR-PILE"
                            } else if navWarningDatabase[i]!.aiSubtype == "Eglise" {
                                nameImage = "MAP-DGR-RELG"
                            } else if navWarningDatabase[i]!.aiSubtype == "Derrick" {
                                nameImage = "MAP-DGR-DRIK"
                            } else if navWarningDatabase[i]!.aiSubtype == "Câble" {
                                nameImage = "MAP-DGR-CABL"
                            } else if navWarningDatabase[i]!.aiSubtype == "Portique" {
                                nameImage = "MAP-DGR-PTIQ"
                            } else if navWarningDatabase[i]!.aiSubtype == "Silo" {
                                nameImage = "MAP-DGR-SILO"
                            } else if navWarningDatabase[i]!.aiSubtype == "Terril" {
                                nameImage = "MAP-DGR-TERL"
                            } else if navWarningDatabase[i]!.aiSubtype == "Torchère" {
                                nameImage = "MAP-DGR-TRCH"
                            } else if navWarningDatabase[i]!.aiSubtype == "Treillis métallique" {
                                nameImage = "MAP-DGR-TREI"
                            } else {
                                print ("Annotation Inconnue \(navaidsDatabase[i]!.aiType)")
                            }
                            
                        } else if navWarningDatabase[i]!.aiType == "ACTIVITE" {
                            
                            if navWarningDatabase[i]!.aiSubtype == "aéromodélisme" {
                                nameImage = "MAP-ATT-MODL"
                            } else  if navWarningDatabase[i]!.aiSubtype == "voltige" {
                                nameImage = "MAP-ATT-VOLT"
                            } else if navWarningDatabase[i]!.aiSubtype == "treuillage" {
                                nameImage = "MAP-ATT-TREU"
                            } else if navWarningDatabase[i]!.aiSubtype == "parachutage" {
                                nameImage = "MAP-ATT-PARA"
                            } else if navWarningDatabase[i]!.aiSubtype == "ballon captif" {
                                nameImage = "MAP-ATT-BALL"
                            } else if navWarningDatabase[i]!.aiSubtype == "Voltige" {
                                nameImage = "MAP-ATT-VOLT"
                            } else {
                                print ("Annotation Inconnue \(navaidsDatabase[i]!.aiType)")
                            }
                           
                        }
                        
                        point.image = UIImage(named: nameImage)
                        navWarningDatabase[i]!.iconeNavwarning = nameImage
                        navWarningDatabase[i]!.visibleNavwarning = true
                        
                        mapView.addAnnotation(point)
                        
                    }
                
            }
            
        }  else {
            let viewWithTag13 = self.view.viewWithTag(13) // Montagnes
            viewWithTag13?.removeFromSuperview()

        }
    }
    func carteAirports() {
        if applicationParametres.buttonOptionMapView[1] {
        //Airports
        mapBox(styleMapboxView: "mapbox://styles/effumaps/cjpx6n3z101lc2smpdn9zrzvf", layerMapbox: 14, tagger: "Airports")
        
        var name: [String] = Array()
        for i in 0...airportsDatabase.count-1 { name.append(airportsDatabase[i]!.aiName) }
            
            let dict = name.reduce(into: [:]) { counts, number in
            counts[number, default: 0] += 1
        }
        
        var pisteSurface: String = ""
        var pisteDimension: Int = 0
        var pisteName: String = ""
        var pisteQfu: Int32 = 0
        var pisteNumero:Int = 0
        var nombrePiste: Int = 0
        var pisteIndex: Int = 0
        var annotationNumber: Int = 0
        for i in 0...airportsDatabase.count-1 {
            //print("\(i) \(airportsDatabase[i]!.aiName)")
            let point1 = mapView.convert(CLLocationCoordinate2D(latitude: airportsDatabase[i]!.swLatitude, longitude: airportsDatabase[i]!.swLongitude), toPointTo:mapView)
            airportsDatabase[i]!.visibleAirports = false
            if (point1.x > 0.0 && point1.y > 0.0 &&
                point1.x < self.mapView.frame.size.width &&
                point1.y < self.mapView.frame.size.height) {
                //                annotationNumber = annotationNumber + 1
                //                print("Coordinate: \(point1.x), \(point1.y) - > \(annotationNumber)")
           
            let longueurP:String = "\(airportsDatabase[i]!.aiDimensions.components(separatedBy: "x")[0])"
            let longueurPiste = (longueurP as NSString).integerValue
            
  
            if pisteNumero == 0 {
                print ("Piste Choix Initialise *** \(i) \(airportsDatabase[i]!.aiName) ***")
                pisteName = airportsDatabase[i]!.aiName
                pisteDimension = longueurPiste
                pisteSurface = airportsDatabase[i]!.aiSurface
                pisteQfu = airportsDatabase[i]!.aiQfu
                pisteNumero = 1
                pisteIndex = i
                nombrePiste = ("\(dict[airportsDatabase[i]!.aiName]!)" as NSString).integerValue
                
            }
            
            //print ("\(airportsDatabase[i]!.aiName) = \(pisteName) ")
            if nombrePiste > 1  && airportsDatabase[i]!.aiName == pisteName && pisteNumero <= dict[airportsDatabase[i]!.aiName]! {

                //print (longueurP)
                //print(longueurPiste)

                print ("Choix Piste \(pisteNumero) / \(nombrePiste) \(pisteName)")
                if airportsDatabase[i]!.aiName == pisteName {
                    pisteNumero = pisteNumero + 1
                }
                // choix Piste Priorité Pavée
   
                if airportsDatabase[i]!.aiSurface == "paved" {
                    print (" \(airportsDatabase[i]!.aiSurface) -> \(longueurPiste)")
                    
                    if (longueurPiste > pisteDimension) {
                        print ("Piste Paved trouve \(longueurPiste) \(pisteDimension) ")
                        pisteName = airportsDatabase[i]!.aiName
                        pisteDimension =  longueurPiste
                        pisteSurface = airportsDatabase[i]!.aiSurface
                        pisteQfu = airportsDatabase[i]!.aiQfu
                        pisteIndex = i
                        
                    }
                }
                
                if airportsDatabase[i]!.aiSurface == "non paved" && pisteSurface != "paved" {
                    print (" \(airportsDatabase[i]!.aiSurface) -> \(longueurPiste)")
                    
                    if (longueurPiste > pisteDimension) {
                        print ("Piste Non Paved trouve \(longueurPiste) \(pisteDimension) ")
                        pisteName = airportsDatabase[i]!.aiName
                        pisteDimension = longueurPiste
                        pisteSurface = airportsDatabase[i]!.aiSurface
                        pisteQfu = airportsDatabase[i]!.aiQfu
                        pisteIndex = i
                    }
                }
                
                if pisteNumero > nombrePiste {
                annotationNumber = annotationNumber + 1
                print ("Coordinate: \(point1.x), \(point1.y) - > \(annotationNumber)")
                print ("Retenu Name \(pisteName) Index \(pisteIndex) ")
                print ("Retenu Type \(airportsDatabase[i]!.aiType)")
                print ("Retenu Longueur \(pisteDimension)")
                print ("Retenu Revetement \(pisteSurface)")
                print ("Retenu QFU \(pisteQfu)")
                    
                    mapView.addAnnotation(airportAnnotation(indexP: pisteIndex))
                    
                pisteSurface = ""
                pisteDimension = 0
                pisteName = ""
                pisteIndex = 0
                pisteQfu = 0
                pisteNumero = 0
                nombrePiste = 0
                
                }
                
            } else {
                
                print ("Piste Seule")
                
                airportAnnotation(indexP: i)
                
            }
        
        }
            
        }
            
        } else {
            var viewWithTag14 = self.view.viewWithTag(14) // Airports
            viewWithTag14?.removeFromSuperview()
            viewWithTag14 = nil

        }
    }
    func carteVilles() {
        if applicationParametres.buttonOptionMapView[11] {
        //Capitales
        mapBox(styleMapboxView: "mapbox://styles/effumaps/cjpx6n3z101lc2smpdn9zrzvf", layerMapbox: 15, tagger: "Capitales")
        var annotationNumber: Int = 0
        
        for i in 0...villesDatabase.count-1 {
            
            if villesDatabase[i]!.statut == "Capitale d'état",
                villesDatabase[i]!.nomRegion == "AQUITAINE" || villesDatabase[i]!.nomRegion == "MIDI-PYRENEES" {
                
                let point1 = mapView.convert(CLLocationCoordinate2D(latitude: villesDatabase[i]!.swLatitude, longitude: villesDatabase[i]!.swLongitude), toPointTo:mapView)
                villesDatabase[i]!.visibleCity =  false
                if (point1.x > 0.0 && point1.y > 0.0 &&
                    point1.x < self.mapView.frame.size.width &&
                    point1.y < self.mapView.frame.size.height) {
                    annotationNumber = annotationNumber + 1
                    print("Coordinate: \(villesDatabase[i]!.nomComm) \(point1.x), \(point1.y) - > \(annotationNumber)")
            
            let point = CustomPointAnnotation(coordinate: CLLocationCoordinate2DMake(villesDatabase[i]!.swLatitude, villesDatabase[i]!.swLongitude),
                                              title: "", //title: villesDatabase[i]!.nomComm,
                                              subtitle: "" //subtitle: villesDatabase[i]!.nomRegion
            )
            
          
            villesDatabase[i]!.iconesCity = "00-VILLE-GENERIQUE"
            villesDatabase[i]!.visibleCity = true
            point.image = UIImage(named: "00-VILLE-GENERIQUE")
            point.reuseIdentifier = "Capitale d'état"
            
            mapView.addAnnotation(point)
            
            }
            }
            
        }
        
        //Sous-préfecture / Préfecture / Préfecture de région / Canton
        mapBox(styleMapboxView: "mapbox://styles/effumaps/cjpx6n3z101lc2smpdn9zrzvf", layerMapbox: 16, tagger: "Sous-prefectures")
        annotationNumber = 0
        for i in 0...villesDatabase.count-1 {
            
            if villesDatabase[i]!.statut == "Sous-préfecture"  || villesDatabase[i]!.statut == "Préfecture" || villesDatabase[i]!.statut == "Préfecture de région"  ||  villesDatabase[i]!.statut == "Chef-lieu canton",
                villesDatabase[i]!.nomRegion == "AQUITAINE" || villesDatabase[i]!.nomRegion == "MIDI-PYRENEES" {
            
            let point1 = mapView.convert(CLLocationCoordinate2D(latitude: villesDatabase[i]!.swLatitude, longitude: villesDatabase[i]!.swLongitude), toPointTo:mapView)
                
                villesDatabase[i]!.visibleCity = false
                if (point1.x > 0.0 && point1.y > 0.0 &&
                    point1.x < self.mapView.frame.size.width &&
                    point1.y < self.mapView.frame.size.height) {
                    annotationNumber = annotationNumber + 1
                    print("Coordinate: \(villesDatabase[i]!.nomComm) \(point1.x), \(point1.y) - > \(annotationNumber)")
                
                let point = CustomPointAnnotation(coordinate: CLLocationCoordinate2DMake(villesDatabase[i]!.swLatitude, villesDatabase[i]!.swLongitude),
                                                  title: "", //title: villesDatabase[i]!.nomComm,
                                                    subtitle: "" //subtitle: villesDatabase[i]!.nomRegion
                )
                
                villesDatabase[i]!.iconesCity = "00-VILLE-GENERIQUE"
                villesDatabase[i]!.visibleCity = true
                point.image = UIImage(named: "00-VILLE-GENERIQUE")
                point.reuseIdentifier = villesDatabase[i]!.statut
                
                mapView.addAnnotation(point)
                
            }
            
        }
        }
        
        //Commune simple
        mapBox(styleMapboxView: "mapbox://styles/effumaps/cjpx6n3z101lc2smpdn9zrzvf", layerMapbox: 17, tagger: "Commune-Simple")
        annotationNumber = 0
        for i in 0...villesDatabase.count-1 {

            if villesDatabase[i]!.statut == "Commune simple",
                villesDatabase[i]!.nomRegion == "AQUITAINE" || villesDatabase[i]!.nomRegion == "MIDI-PYRENEES" {
            
                let point1 = mapView.convert(CLLocationCoordinate2D(latitude: villesDatabase[i]!.swLatitude, longitude: villesDatabase[i]!.swLongitude), toPointTo:mapView)
                
                villesDatabase[i]!.visibleCity = false
                if (point1.x > 0.0 && point1.y > 0.0 &&
                    point1.x < self.mapView.frame.size.width &&
                    point1.y < self.mapView.frame.size.height) {
                    annotationNumber = annotationNumber + 1
                    print("Coordinate: \(villesDatabase[i]!.nomComm) \(point1.x), \(point1.y) - > \(annotationNumber)")
                
                let point = CustomPointAnnotation(coordinate: CLLocationCoordinate2DMake(villesDatabase[i]!.swLatitude, villesDatabase[i]!.swLongitude),
                                                title: "", //title: villesDatabase[i]!.nomComm,
                                                subtitle: "" //subtitle: villesDatabase[i]!.nomRegion
                )
                villesDatabase[i]!.iconesCity = "commune"
                villesDatabase[i]!.visibleCity = true
                point.image = UIImage(named: "commune")
                point.reuseIdentifier = "Commune simple"
               
                mapView.addAnnotation(point)
                
            }
            }
        }
            
        } else {
            var viewWithTag15 = self.view.viewWithTag(15) // Villes
            viewWithTag15?.removeFromSuperview()
            viewWithTag15 = nil
            var viewWithTag16 = self.view.viewWithTag(16) // Villes
            viewWithTag16?.removeFromSuperview()
            viewWithTag16 = nil
            var viewWithTag17 = self.view.viewWithTag(17) // Villes
            viewWithTag17?.removeFromSuperview()
            viewWithTag17 = nil

        }
    }
    func carteNavaidsTerminal() {
        if applicationParametres.buttonOptionMapView[4] {
        //Terminal Navaids
        mapBox(styleMapboxView: "mapbox://styles/effumaps/cjpx6n3z101lc2smpdn9zrzvf", layerMapbox: 22, tagger: "Terminal")
        
        var annotationNumber: Int = 0
        for i in 0...navaidsDatabase.count-1 {
            
            if navaidsDatabase[i]!.aiType == "TERMINAL" {
                
                let point1 = mapView.convert(CLLocationCoordinate2D(latitude: navaidsDatabase[i]!.swLatitude, longitude: navaidsDatabase[i]!.swLongitude), toPointTo:mapView)
                navaidsDatabase[i]!.visibleNavaids = false
                if (point1.x > 0.0 && point1.y > 0.0 &&
                    point1.x < self.mapView.frame.size.width &&
                    point1.y < self.mapView.frame.size.height) {
                    annotationNumber = annotationNumber + 1
                    print("Coordinate: \(point1.x), \(point1.y) - > \(annotationNumber)")
                
                //print (navaidsDatabase[i]!.aiService)
                
                let point = CustomPointAnnotation(coordinate: CLLocationCoordinate2DMake(navaidsDatabase[i]!.swLatitude, navaidsDatabase[i]!.swLongitude),
                                                    title:"", //title: navaidsDatabase[i]!.aiStation,
                                                    subtitle:"" //subtitle: navaidsDatabase[i]!.aiService
                )
                
                point.reuseIdentifier = navaidsDatabase[i]!.aiService
                if navaidsDatabase[i]!.aiService == "VOR-DME" {
                    nameImage = "VOR-DME_map"
                } else if navaidsDatabase[i]!.aiService == "LOC" {
                    nameImage = "NDB_map"
                } else if navaidsDatabase[i]!.aiService == "GP" {
                    nameImage = "NDB_map"
                } else if navaidsDatabase[i]!.aiService == "VOR" {
                    nameImage = "VOR_map"
                } else if navaidsDatabase[i]!.aiService == "NDB" {
                    nameImage = "NDB_map"
                } else if navaidsDatabase[i]!.aiService == "DME" {
                    nameImage = "DME_map"
                } else if navaidsDatabase[i]!.aiService == "VORTAC" {
                    nameImage = "VORTAC_map"
                } else if navaidsDatabase[i]!.aiService == "TACAN" {
                    nameImage = "TACAN_map"
                } else if navaidsDatabase[i]!.aiService == "MM" {
                    nameImage = "NDB_map"
                } else if navaidsDatabase[i]!.aiService == "OM" {
                    nameImage = "NDB_map"
                } else if navaidsDatabase[i]!.aiService == "IM" {
                    nameImage = "NDB_map"
                } else if navaidsDatabase[i]!.aiService == "L" {
                    nameImage = "NDB_map"
                } else {
                    print ("Annotation Inconnue \(navaidsDatabase[i]!.aiType)")
                }
                
                navaidsDatabase[i]!.iconesNavaids = nameImage
                navaidsDatabase[i]!.visibleNavaids = true
                point.image = UIImage(named: nameImage)
                mapView.addAnnotation(point)
                
            }
            }
        }
            
        }  else {
            var viewWithTag22 = self.view.viewWithTag(22)
            viewWithTag22?.removeFromSuperview()
            viewWithTag22 = nil

        }
    }
    func carteNavaidsEnRoute() {
        if applicationParametres.buttonOptionMapView[3] {
        //En Route Navaids
        mapBox(styleMapboxView: "mapbox://styles/effumaps/cjpx6n3z101lc2smpdn9zrzvf", layerMapbox: 23, tagger: "En Route")
        
        var annotationNumber: Int = 0
        for i in 0...navaidsDatabase.count-1 {

            if navaidsDatabase[i]!.aiType == "ENROUTE" {
                
                let point1 = mapView.convert(CLLocationCoordinate2D(latitude: navaidsDatabase[i]!.swLatitude, longitude: navaidsDatabase[i]!.swLongitude), toPointTo:mapView)
                navaidsDatabase[i]!.visibleNavaids = false
                if (point1.x > 0.0 && point1.y > 0.0 &&
                    point1.x < self.mapView.frame.size.width &&
                    point1.y < self.mapView.frame.size.height) {
                    annotationNumber = annotationNumber + 1
                    print("Coordinate: \(point1.x), \(point1.y) - > \(annotationNumber)")

                //print (navaidsDatabase[i]!.aiService)

                let point = CustomPointAnnotation(coordinate: CLLocationCoordinate2DMake(navaidsDatabase[i]!.swLatitude, navaidsDatabase[i]!.swLongitude),
                                                  title: "", //title: navaidsDatabase[i]!.aiStation,
                                                  subtitle: "" //subtitle: navaidsDatabase[i]!.aiService
                )
                
                point.reuseIdentifier = navaidsDatabase[i]!.aiService
                    if navaidsDatabase[i]!.aiService == "VOR-DME" {
                        nameImage = "VOR-DME_map"
                    } else if navaidsDatabase[i]!.aiService == "LOC" {
                        nameImage = "NDB_map"
                    } else if navaidsDatabase[i]!.aiService == "GP" {
                        nameImage = "NDB_map"
                    } else if navaidsDatabase[i]!.aiService == "VOR" {
                        nameImage = "VOR_map"
                    } else if navaidsDatabase[i]!.aiService == "NDB" {
                        nameImage = "NDB_map"
                    } else if navaidsDatabase[i]!.aiService == "DME" {
                        nameImage = "DME_map"
                    } else if navaidsDatabase[i]!.aiService == "VORTAC" {
                        nameImage = "VORTAC_map"
                    } else if navaidsDatabase[i]!.aiService == "TACAN" {
                        nameImage = "TACAN_map"
                    } else if navaidsDatabase[i]!.aiService == "MM" {
                        nameImage = "NDB_map"
                    } else if navaidsDatabase[i]!.aiService == "OM" {
                        nameImage = "NDB_map"
                    } else if navaidsDatabase[i]!.aiService == "IM" {
                        nameImage = "NDB_map"
                    } else if navaidsDatabase[i]!.aiService == "L" {
                        nameImage = "NDB_map"
                    } else {
                        print ("Annotation Inconnue \(navaidsDatabase[i]!.aiType)")
                    }
                    
                navaidsDatabase[i]!.iconesNavaids = nameImage
                navaidsDatabase[i]!.visibleNavaids = true
                point.image = UIImage(named: nameImage)
                mapView.addAnnotation(point)

            }
            }
        }
            
        } else {
            var viewWithTag23 = self.view.viewWithTag(23) // Navaids En route
            viewWithTag23?.removeFromSuperview()
            viewWithTag23 = nil

        }
    }
    
    func airportAnnotation(indexP: Int) -> CustomPointAnnotation {
        
        let point = CustomPointAnnotation(coordinate: CLLocationCoordinate2DMake(airportsDatabase[indexP]!.swLatitude, airportsDatabase[indexP]!.swLongitude),
                                        title: "", //title: airportsDatabase[indexP]!.aiName,
                                        subtitle: "" //subtitle: airportsDatabase[indexP]!.aiIcao
            
        )
        
        point.reuseIdentifier = airportsDatabase[indexP]!.aiIcao
        
        let longueurP:String = "\(airportsDatabase[indexP]!.aiDimensions.components(separatedBy: "x")[0])"
        let longueurPiste = (longueurP as NSString).integerValue
        let orientationPiste: Int32 = airportsDatabase[indexP]!.aiQfu
        
        if airportsDatabase[indexP]!.aiType == "public" {
            
            if airportsDatabase[indexP]!.aiSurface == "paved" {
                
                if longueurPiste > 1000 {
                    print("Annotation Public > 1000 m")
                    
                    if (orientationPiste >= 345 && 15 <= orientationPiste) || (orientationPiste >= 165 && 195 <= orientationPiste) {
                        nameImage = "public_airport_02b"
                    } else if (orientationPiste >= 15 && 30 <= orientationPiste) || (orientationPiste >= 195 && 225 <= orientationPiste) {
                        nameImage = "public_airport_02c"
                    } else if (orientationPiste >= 30 && 45 <= orientationPiste) || (orientationPiste >= 225 && 255 <= orientationPiste) {
                        nameImage = "public_airport_02d"
                    } else if (orientationPiste >= 45 && 75 <= orientationPiste) || (orientationPiste >= 255 && 285 <= orientationPiste) {
                        nameImage = "public_airport_02e"
                    } else if (orientationPiste >= 75 && 105 <= orientationPiste) || (orientationPiste >= 285 && 315 <= orientationPiste) {
                        nameImage = "public_airport_02f"
                    } else if (orientationPiste >= 105 && 135 <= orientationPiste) || (orientationPiste >= 315 && 345 <= orientationPiste) {
                        nameImage = "public_airport_02g"
                    } else {
                        nameImage = "public_airport_02a"
                    }
                    
                } else {
                    print("Annotation Public piste < 1000 m")
                    
                    if (orientationPiste >= 345 && 15 <= orientationPiste) || (orientationPiste >= 165 && 195 <= orientationPiste) {
                        nameImage = "public_airport_03b"
                    } else if (orientationPiste >= 15 && 30 <= orientationPiste) || (orientationPiste >= 195 && 225 <= orientationPiste) {
                        nameImage = "public_airport_03c"
                    } else if (orientationPiste >= 30 && 45 <= orientationPiste) || (orientationPiste >= 225 && 255 <= orientationPiste) {
                        nameImage = "public_airport_03d"
                    } else if (orientationPiste >= 45 && 75 <= orientationPiste) || (orientationPiste >= 255 && 285 <= orientationPiste) {
                        nameImage = "public_airport_03e"
                    } else if (orientationPiste >= 75 && 105 <= orientationPiste) || (orientationPiste >= 285 && 315 <= orientationPiste) {
                        nameImage = "public_airport_03f"
                    } else if (orientationPiste >= 105 && 135 <= orientationPiste) || (orientationPiste >= 315 && 345 <= orientationPiste) {
                        nameImage = "public_airport_03g"
                    } else {
                        nameImage = "public_airport_02a"
                    }
                    
                }
                
            } else {
                
                //Pas de piste pavée
                nameImage = "public_airport_04a"
                
            }
            
        }
        if airportsDatabase[indexP]!.aiType == "restricted" {
            
            if airportsDatabase[indexP]!.aiSurface == "paved" {
                
                if longueurPiste > 1000 {
                    print("Annotation Restrited piste > 1000 m")
                    nameImage = "restricted_airport_02b"

                    if (orientationPiste >= 345 && 15 <= orientationPiste) || (orientationPiste >= 165 && 195 <= orientationPiste) {
                        nameImage = "restricted_airport_02b"
                    } else if (orientationPiste >= 15 && 30 <= orientationPiste) || (orientationPiste >= 195 && 225 <= orientationPiste) {
                        nameImage = "restricted_airport_02c"
                    } else if (orientationPiste >= 30 && 45 <= orientationPiste) || (orientationPiste >= 225 && 255 <= orientationPiste) {
                        nameImage = "restricted_airport_02d"
                    } else if (orientationPiste >= 45 && 75 <= orientationPiste) || (orientationPiste >= 255 && 285 <= orientationPiste) {
                        nameImage = "restricted_airport_02e"
                    } else if (orientationPiste >= 75 && 105 <= orientationPiste) || (orientationPiste >= 285 && 315 <= orientationPiste) {
                        nameImage = "restricted_airport_02f"
                    } else if (orientationPiste >= 105 && 135 <= orientationPiste) || (orientationPiste >= 315 && 345 <= orientationPiste) {
                        nameImage = "restricted_airport_02g"
                    } else {
                        nameImage = "restricted_airport_02a"
                    }
                    
                } else {
                    print("Annotation Restricted piste < 1000 m")
                    
                    if (orientationPiste >= 345 && 15 <= orientationPiste) || (orientationPiste >= 165 && 195 <= orientationPiste) {
                        nameImage = "restricted_airport_03b"
                    } else if (orientationPiste >= 15 && 30 <= orientationPiste) || (orientationPiste >= 195 && 225 <= orientationPiste) {
                        nameImage = "restricted_airport_03c"
                    } else if (orientationPiste >= 30 && 45 <= orientationPiste) || (orientationPiste >= 225 && 255 <= orientationPiste) {
                        nameImage = "restricted_airport_03d"
                    } else if (orientationPiste >= 45 && 75 <= orientationPiste) || (orientationPiste >= 255 && 285 <= orientationPiste) {
                        nameImage = "restricted_airport_03e"
                    } else if (orientationPiste >= 75 && 105 <= orientationPiste) || (orientationPiste >= 285 && 315 <= orientationPiste) {
                        nameImage = "restricted_airport_03f"
                    } else if (orientationPiste >= 105 && 135 <= orientationPiste) || (orientationPiste >= 315 && 345 <= orientationPiste) {
                        nameImage = "restricted_airport_03g"
                    } else {
                        nameImage = "restricted_airport_02a"
                    }
                    
                }
                
            } else {
                nameImage = "restricted_airport_04a"
            }
        }
        if airportsDatabase[indexP]!.aiType == "military" {
            
            if airportsDatabase[indexP]!.aiSurface == "paved" {
                
                if longueurPiste > 1000 {
                    print("Annotation Military piste > 1000 m")
                    
                    if (orientationPiste >= 0 && 90 <= orientationPiste) || (orientationPiste >= 180 && 270 <= orientationPiste) {
                        nameImage = "military_airport_02d"
                    } else if (orientationPiste >= 90 && 180 <= orientationPiste) || (orientationPiste >= 270 && 360 <= orientationPiste) {
                        nameImage = "military_airport_02f"
                    } else {
                        nameImage = "military_airport_02a"
                    }
                    
                } else {
                    print("Annotation Military piste < 1000 m")
                    
                }
                
                
            } else {
                nameImage = "military_airport_04a"
            }
        }
        
        airportsDatabase[indexP]!.iconesAirports = nameImage
        airportsDatabase[indexP]!.visibleAirports = true
        point.image = UIImage(named: nameImage)
        
        return point
    }
    
    func drawPolyLineShape() {
    if applicationParametres.buttonOptionMapView[2] {
    mapBox(styleMapboxView: "mapbox://styles/effumaps/cjpx6n3z101lc2smpdn9zrzvf", layerMapbox: 9, tagger: "PolyLine")
    for i in 0...airportsDatabase.count-1 {
        var coordinatesShape: [CLLocationCoordinate2D] = []
        var someString = airportsDatabase[i]!.swCoordinates
        someString = someString.replacingOccurrences(of: "[()]", with: "", options: [.regularExpression, .caseInsensitive])
        let result = someString.split(separator: ",")
        if result.isEmpty {
            //
        } else {
        for j in 0...result.count-1 {
            let result1 = result[j].split(separator: " ")
            let destination = CLLocationCoordinate2DMake(Double(result1[1])!, Double(result1[0])!)
            coordinatesShape.append(destination)
        }
            //print (airportsDatabase[i]?.aiName)
            //print(coordinatesShape)
            let shape = MGLPolygon(coordinates: coordinatesShape, count: UInt(coordinatesShape.count))
            shape.title = airportsDatabase[i]?.aiName
            shape.subtitle = airportsDatabase[i]?.aiSurface
            mapView.add(shape)
        }
        
    }
    
    } else {
        var viewWithTag9 = self.view.viewWithTag(9)
        viewWithTag9?.removeFromSuperview()
        viewWithTag9 = nil
    }
  }
    
    
    func drawRoutePlane() {
        if applicationParametres.buttonOptionMapView[0]{
            if !flight_Plan.arrival_Airfield_isEmpty() && !flight_Plan.departure_Airfield_isEmpty() {
                mapBox(styleMapboxView: "mapbox://styles/effumaps/cjpx6n3z101lc2smpdn9zrzvf", layerMapbox: 25, tagger: "Route")
                
                let departure_Airfield_Latitude = flight_Plan.get_Departure_Airfield_Latitude()
                let departure_Airfield_Longitude = flight_Plan.get_Departure_Airfield_Longitude()
                
                let arrival_Airfield_Latitude = flight_Plan.get_Arrival_Airfield_Latitude()
                let arrival_Airfield_Longitude = flight_Plan.get_Arrival_Airfield_Longitude()
                
                // Create array of lat,lon points.
                /**
                 var coordinatesDepartureProc = [
                    CLLocationCoordinate2D(latitude: departure_Airfield_Latitude, longitude: departure_Airfield_Longitude)
                 ];
                 **/
                var coordinatesEnroute = [
                    CLLocationCoordinate2D(latitude: departure_Airfield_Latitude, longitude: departure_Airfield_Longitude),
                    CLLocationCoordinate2D(latitude: arrival_Airfield_Latitude, longitude: arrival_Airfield_Longitude)
                ];
                /**
                 var coordinatesArrivalProc = [
                    CLLocationCoordinate2D(latitude: arrival_Airfield_Latitude, longitude: arrival_Airfield_Longitude)
                 ];
                 **/
                
                //let shape1 = MGLPolyline(coordinates: &coordinatesDepartureProc, count: UInt(coordinatesDepartureProc.count))
                //shape1.subtitle = "Departure"
                //mapView.add(shape1)
                
                let shape2 = MGLPolyline(coordinates: &coordinatesEnroute, count: UInt(coordinatesEnroute.count))
                shape2.subtitle = "enRoute"
                mapView.add(shape2)
                
                //let shape3 = MGLPolyline(coordinates: &coordinatesArrivalProc, count: UInt(coordinatesArrivalProc.count))
                //shape3.subtitle = "Arrival"
                //mapView.add(shape3)
            } else if !flight_Plan.departure_Airfield_isEmpty() && flight_Plan.arrival_Airfield_isEmpty(){
                
                let latitude = flight_Plan.get_Departure_Airfield_Latitude()
                let longitude = flight_Plan.get_Departure_Airfield_Longitude()
                let departure = MGLPointAnnotation()
                departure.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                mapView.addAnnotation(departure)
                
            } else if flight_Plan.departure_Airfield_isEmpty() && !flight_Plan.arrival_Airfield_isEmpty(){
                
                let latitude = flight_Plan.get_Arrival_Airfield_Latitude()
                let longitude = flight_Plan.get_Arrival_Airfield_Longitude()
                let arrival = MGLPointAnnotation()
                arrival.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                mapView.addAnnotation(arrival)
                
            } else {
                applicationParametres.buttonOptionMapView[0] = false
                alertnoAirportsAssigned()
            }
        } else {
            var viewWithTag25 = self.view.viewWithTag(25)
            viewWithTag25?.removeFromSuperview()
            viewWithTag25 = nil
        }
    }
    
    
    func mapView(_ mapView: MGLMapView, alphaForShapeAnnotation annotation: MGLShape) -> CGFloat {
        return 1.0
    }
    
    // Taille du trait
    func mapView(_ : MGLMapView, lineWidthForPolylineAnnotation annotation: MGLPolyline) -> CGFloat {
        // Set the line width for polyline annotations
        return 7.0
    }
    
    // Couleur du trait
    func mapView(_ mapView: MGLMapView, strokeColorForShapeAnnotation annotation: MGLShape) -> UIColor {
        var couleurMGLPolygon: UIColor = .yellow
        if  annotation.subtitle == "Departure" {
            couleurMGLPolygon = UIColor(red: 255/255, green: 0/255, blue: 255/255, alpha: 1.0)
        }
        if  annotation.subtitle == "enRoute" {
            couleurMGLPolygon = UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 1.0)
        }
        if  annotation.subtitle == "Arrival" {
            couleurMGLPolygon = UIColor(red: 255/255, green: 0/255, blue: 255/255, alpha: 1.0)
        }
        
        
        if  annotation.subtitle == "paved" {
            couleurMGLPolygon = UIColor(red: 191/255, green: 191/255, blue: 191/255, alpha: 1.0)
        }
        if annotation.subtitle == "non paved" || annotation.title == "unpaved" {
            couleurMGLPolygon = UIColor(red: 51/255, green: 204/255, blue: 51/255, alpha: 1.0)
        }
        return couleurMGLPolygon
    }
    
    func mapView(_ mapView: MGLMapView, fillColorForPolygonAnnotation annotation: MGLPolygon) -> UIColor {
        var couleurMGLPolygon: UIColor = .yellow
        if  annotation.subtitle == "paved" {
        couleurMGLPolygon = UIColor(red: 191/255, green: 191/255, blue: 191/255, alpha: 1.0)
        }
        if annotation.subtitle == "non paved" || annotation.title == "unpaved" {
        couleurMGLPolygon = UIColor(red: 51/255, green: 204/255, blue: 51/255, alpha: 1.0)
        }
        return couleurMGLPolygon

    }
    
    func degreesToRadians(degrees: Double) -> Double { return degrees * .pi / 180.0 }
    func radiansToDegrees(radians: Double) -> Double { return radians * 180.0 / .pi }
    
    func getBearingBetweenTwoPoints1(point1 : CLLocation, point2 : CLLocation) -> Double {
        
        let distance = point1.distance(from: point2)
        return Double(distance)
    }
    
    /* Begin Of Function ******************************************************
     *    Gesture    Cartographie                   *
     ************************************************/
    
    @objc func pinchAction(gestureRecognizer:UIPinchGestureRecognizer){
        
        if gestureRecognizer.state == .began {

            let zoomCenter = CGPoint(x: gestureRecognizer.location(in: view).x,
                                     y: gestureRecognizer.location(in: view).y)
            
            print ("Position \(zoomCenter)")
            let tapCoordinate: CLLocationCoordinate2D = mapView.convert(zoomCenter, toCoordinateFrom: nil)
            localisationCenterMap = tapCoordinate
        }
            
            if gestureRecognizer.state == .changed {
            
            menuOptionMapView(visible: false)
            //let currentScale = Float(self.view.frame.size.width / self.view.bounds.size.width)

            let currentScale = gestureRecognizer.view!.frame.size.width / gestureRecognizer.view!.bounds.size.width
            let velocity = gestureRecognizer.velocity
            
            let newScale = Double(currentScale*gestureRecognizer.scale)
            let magnitude = sqrt(velocity * velocity)
            print (zoomLevelMap)
            print (newScale)
            print (magnitude)
            if newScale < 1 {
                if zoomLevelMap > 4 {
                    zoomLevelMap = zoomLevelMap - Double((0.03 * magnitude))
                } else {
                    zoomLevelMap = 4
                }
            } else {
                if zoomLevelMap < 20 {
                    zoomLevelMap = zoomLevelMap + Double((0.03 * magnitude))
                    
                } else {
                    zoomLevelMap = 20
                }
            }
           
            gestureRecognizer.scale = 1
        }
        
        if gestureRecognizer.state == .ended {
        
            print("Pinch Sortie")
            print (zoomLevelMap)
            affichageFondCartesMapbox()
        }
        
    }
    
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            print("Screen edge swiped!")
        }
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            print("Swipe Right")
            
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.left {
            print("Swipe Left")
           
            
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.up {
            print("Swipe Up")
            
            
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.down {
            print("Swipe Down")
          
            
        }
    }
    
    
    @objc func actionGestureHandler(){

//        view.transform = view.transform.rotated(by: recognizer.rotation)
//        recognizer.rotation = 0

        localisationCenterMap = mapView.centerCoordinate
        zoomLevelMap = mapView.zoomLevel
        directionMap = mapView.direction

        print ("Gesture")
        print ("Localisation Coordonates Update \(localisationCenterMap) ")
        print ("Zoom Level Update \(zoomLevelMap) ")
        print ("Direction Update \(directionMap) ")
        
        affichageFondCartesMapbox()
 
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer){
        print("doubletapped")
    }
    
    @objc func tapAction(sender:UITapGestureRecognizer){
        
        let tailleRayon: Int = 35
        var affichagePopupList: Bool = false

        for layer: CALayer in self.view.layer.sublayers! {
            if layer.name == "Touch Zone" {
                     layer.removeFromSuperlayer()
            }

        }
        
        let viewWithTag221 = self.view.viewWithTag(221)
        viewWithTag221?.removeFromSuperview()
        
        let tapPoint: CGPoint = sender.location(in: mapView)
        let tapCoordinate: CLLocationCoordinate2D = mapView.convert(tapPoint, toCoordinateFrom: nil)
        
        let myLocation = CLLocation(latitude: tapCoordinate.latitude, longitude: tapCoordinate.longitude)
        let zoneTouchCoordinates: CLLocationCoordinate2D = mapView.convert(CGPoint(x: tapPoint.x+CGFloat(tailleRayon), y: tapPoint.y), toCoordinateFrom: nil)
        let zoneToucheExternal = CLLocation(latitude: zoneTouchCoordinates.latitude, longitude: zoneTouchCoordinates.longitude)
        let distanceMax = getBearingBetweenTwoPoints1(point1 : myLocation, point2 : zoneToucheExternal )
        
        // Coordones de l'appui
        print("You tapped at: \(tapCoordinate.latitude), \(tapCoordinate.longitude) TapPoint y \(tapPoint.x), x \(tapPoint.y) Zoom \(zoomLevelMap) Distance \(distanceMax) ")
        
        
        // Recherche des points aux alentours
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: tapPoint.x,y: tapPoint.y), radius: CGFloat(tailleRayon), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
    
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        //change the fill color
        shapeLayer.fillColor = UIColor(red: 102/255, green: 255/255, blue: 51/255, alpha: 0.5).cgColor
        //shapeLayer.opacity = 0.5
        //you can change the stroke color
        shapeLayer.strokeColor = UIColor(red: 102/255, green: 255/255, blue: 51/255, alpha: 1.0).cgColor
        //you can change the line width
        shapeLayer.lineWidth = 3.0
        shapeLayer.name = "Touch Zone"
        self.view.layer.addSublayer(shapeLayer)
        
        //Calcul distance
        //tableData = []
        headerTitles = []
        data = []
        iconesData = []
        dataTableView = []
        
        var ancienName: String = ""
        var ancienName1: String = ""
        
        //Aeroports
        if applicationParametres.buttonOptionMapView[1] {
        for i in 0...airportsDatabase.count-1 {
        let secondLocation = CLLocation(latitude: airportsDatabase[i]!.swLatitude, longitude: airportsDatabase[i]!.swLongitude)
            let distance = getBearingBetweenTwoPoints1(point1 : myLocation, point2 : secondLocation)
            if distance < distanceMax {
                if ancienName != "Airports" {
                    print ("Airports Possibility : \(airportsDatabase[i]!.aiIcao) \(airportsDatabase[i]!.aiName) -> \(distance)")
                    headerTitles.append("Aérodromes")
                    ancienName = "Airports"
                    affichagePopupList = true
                }
                if ancienName1 != airportsDatabase[i]!.aiIcao && airportsDatabase[i]!.visibleAirports {
                    
                    // Ajouter a la variable "data" l'ID et le nom de l'aerodrome
                    data.append(["\(airportsDatabase[i]!.aiIcao) (\(airportsDatabase[i]!.aiName))"])
                    // Ajouter a la variable "iconesData l'icone de l'aerodrome
                    iconesData.append(airportsDatabase[i]!.iconesAirports)
                    dataTableView.append(["Airports", "\(i)"])
                    ancienName1 = airportsDatabase[i]!.aiIcao
                }
                
            }
        }
        }
        
        //navaids En route
        if applicationParametres.buttonOptionMapView[3] {
            for i in 0...navaidsDatabase.count-1 {
                let secondLocation = CLLocation(latitude: navaidsDatabase[i]!.swLatitude, longitude: navaidsDatabase[i]!.swLongitude)
                let distance = getBearingBetweenTwoPoints1(point1 : myLocation, point2 : secondLocation)
                if distance < distanceMax {
                    if ancienName != "Navaids En Route" && navaidsDatabase[i]!.aiType == "ENROUTE" {
                        print ("Navaids Possibility : \(navaidsDatabase[i]!.aiService) \(navaidsDatabase[i]!.aiStation) -> \(distance)")
                        headerTitles.append("Navaids En Route")
                        ancienName = "Navaids En Route"
                        affichagePopupList = true
                    }
                    if ancienName1 != navaidsDatabase[i]!.aiStation && navaidsDatabase[i]!.visibleNavaids {
                        
                        data.append(["\(navaidsDatabase[i]!.aiStation)"])
                        iconesData.append(navaidsDatabase[i]!.iconesNavaids)
                        dataTableView.append(["Navaids En Route", "\(i)"])
                        ancienName1 = navaidsDatabase[i]!.aiStation
                    }
                    
                }
            }
        }
        
        //navaids Terminal
        if applicationParametres.buttonOptionMapView[4] {
            for i in 0...navaidsDatabase.count-1 {
                let secondLocation = CLLocation(latitude: navaidsDatabase[i]!.swLatitude, longitude: navaidsDatabase[i]!.swLongitude)
                let distance = getBearingBetweenTwoPoints1(point1 : myLocation, point2 : secondLocation)
                if distance < distanceMax {
                    if ancienName != "Navaids Terminal" && navaidsDatabase[i]!.aiType == "TERMINAL" {
                        print ("Navaids Possibility : \(navaidsDatabase[i]!.aiService) \(navaidsDatabase[i]!.aiStation) -> \(distance)")
                        headerTitles.append("Navaids Terminal")
                        ancienName = "Navaids Terminal"
                        affichagePopupList = true
                    }
                    if ancienName1 != navaidsDatabase[i]!.aiStation && navaidsDatabase[i]!.visibleNavaids {
                        
                        data.append(["\(navaidsDatabase[i]!.aiStation)"])
                        iconesData.append(navaidsDatabase[i]!.iconesNavaids)
                        dataTableView.append(["Navaids Terminal", "\(i)"])
                        ancienName1 = navaidsDatabase[i]!.aiStation
                    }
                    
                }
            }
        }

        //WarningInterdictions
        if applicationParametres.buttonOptionMapView[5] {
            for i in 0...navWarningDatabase.count-1 {
                let secondLocation = CLLocation(latitude: navWarningDatabase[i]!.swLatitude, longitude: navWarningDatabase[i]!.swLongitude)
                let distance = getBearingBetweenTwoPoints1(point1 : myLocation, point2 : secondLocation)
                if distance < distanceMax {
                    if ancienName != "Warning Interdictions" {
                        print ("Warning Interdictions Possibility Divers : \(navWarningDatabase[i]!.aiSubtype) \(navWarningDatabase[i]!.aiLongName) -> \(distance)")
                        headerTitles.append("Warning Interdictions")
                        ancienName = "Warning Interdictions"
                        affichagePopupList = true
                    }
                    if ancienName1 != navWarningDatabase[i]!.aiLongName && navWarningDatabase[i]!.visibleNavwarning {
                        if navWarningDatabase[i]!.aiType == "SURVOL INTERDIT" {
                        data.append(["Survol Interdit - \(navWarningDatabase[i]!.aiLongName)"])
                        iconesData.append(navWarningDatabase[i]!.iconeNavwarning)
                        dataTableView.append(["Warning Terminal", "\(i)"])
                        } else {
                        data.append(["\(navWarningDatabase[i]!.aiLongName)"])
                        iconesData.append(navWarningDatabase[i]!.iconeNavwarning)
                        dataTableView.append(["Warning Terminal", "\(i)"])
                        }
                        ancienName1 = navWarningDatabase[i]!.aiLongName
                    
                    }
                }
            }
        }
        
        //Reperes Visuels
        if applicationParametres.buttonOptionMapView[10] {
            for i in 0...reperesVisuelsDatabase.count-1 {
            if reperesVisuelsDatabase[i]!.swKind != "Montagne" && reperesVisuelsDatabase[i]!.swKind != "Forêt" && reperesVisuelsDatabase[i]!.swKind != "Lac" {
            
                let secondLocation = CLLocation(latitude: reperesVisuelsDatabase[i]!.swLatitude, longitude: reperesVisuelsDatabase[i]!.swLongitude)
                let distance = getBearingBetweenTwoPoints1(point1 : myLocation, point2 : secondLocation)
                if distance < distanceMax {
                    if ancienName != "Repéres Visuels" {
                        headerTitles.append("Repéres Visuels")
                        ancienName = "Repéres Visuels"
                        affichagePopupList = true
                    }
                    if ancienName1 != reperesVisuelsDatabase[i]!.swLongName && reperesVisuelsDatabase[i]!.visibleReperesVisuel {

                        print ("Warning Interdictions Possibility Montagne : \(reperesVisuelsDatabase[i]!.swShortName) \(reperesVisuelsDatabase[i]!.swLongName) \(reperesVisuelsDatabase[i]!.swKind) \(imageLigne) -> \(distance)")
                        data.append(["\(reperesVisuelsDatabase[i]!.swLongName)"])
                        iconesData.append(reperesVisuelsDatabase[i]!.iconeReperesVisuel)
                        dataTableView.append(["Repéres Visuels", "\(i)"])
                        ancienName1 = reperesVisuelsDatabase[i]!.swLongName
                    }
                }
            }
        }
        }
        
        
        //Villes
        if applicationParametres.buttonOptionMapView[11] {
            for i in 0...villesDatabase.count-1 {
                let secondLocation = CLLocation(latitude: villesDatabase[i]!.swLatitude, longitude: villesDatabase[i]!.swLongitude)
                let distance = getBearingBetweenTwoPoints1(point1 : myLocation, point2 : secondLocation)
                if distance < distanceMax {
                    if ancienName != "Villes" {
                        print ("Warning Interdictions Possibility : \(villesDatabase[i]!.nomComm) \(villesDatabase[i]!.statut) -> \(distance)")
                        headerTitles.append("Villes")
                        ancienName = "Villes"
                        affichagePopupList = true
                    }
                    if ancienName1 != villesDatabase[i]!.nomComm && villesDatabase[i]!.visibleCity {
                        data.append(["\(villesDatabase[i]!.nomComm)"])
                        iconesData.append("00-VILLE-GENERIQUE")
                        dataTableView.append(["Ville", "\(i)"])
                        ancienName1 = villesDatabase[i]!.nomComm
                    
                    }
                }
            }
        }
        
        //Reperes Visuels Montagne
        if applicationParametres.buttonOptionMapView[12] {
            for i in 0...reperesVisuelsDatabase.count-1 {
                let secondLocation = CLLocation(latitude: reperesVisuelsDatabase[i]!.swLatitude, longitude: reperesVisuelsDatabase[i]!.swLongitude)
                let distance = getBearingBetweenTwoPoints1(point1 : myLocation, point2 : secondLocation)
                if distance < distanceMax {
                    if ancienName != "Montagne" && reperesVisuelsDatabase[i]!.swKind == "Montagne" {
                        print ("Warning Interdictions Possibility Montagne : \(reperesVisuelsDatabase[i]!.swShortName) \(reperesVisuelsDatabase[i]!.swLongName) -> \(distance)")
                        headerTitles.append("Montagne")
                        ancienName = "Montagne"
                        affichagePopupList = true
                    }
                    if ancienName1 != reperesVisuelsDatabase[i]!.swLongName && reperesVisuelsDatabase[i]!.visibleReperesVisuel && reperesVisuelsDatabase[i]!.swKind == "Montagne" {
                        data.append(["\(reperesVisuelsDatabase[i]!.swLongName)"])
                        iconesData.append("MAP-INF-MONT")
                        dataTableView.append(["Montagne", "\(i)"])
                        ancienName1 = reperesVisuelsDatabase[i]!.swLongName
                    }
                   
                }
            }
        }
        
        //Reperes Visuels Volcan
        if applicationParametres.buttonOptionMapView[12] {
            for i in 0...reperesVisuelsDatabase.count-1 {
                let secondLocation = CLLocation(latitude: reperesVisuelsDatabase[i]!.swLatitude, longitude: reperesVisuelsDatabase[i]!.swLongitude)
                let distance = getBearingBetweenTwoPoints1(point1 : myLocation, point2 : secondLocation)
                if distance < distanceMax {
                    if ancienName != "Volcan" && reperesVisuelsDatabase[i]!.swKind == "Volcan" {
                        print ("Warning Interdictions Possibility Volcan : \(reperesVisuelsDatabase[i]!.swShortName) \(reperesVisuelsDatabase[i]!.swLongName) -> \(distance)")
                        //headerTitles.append("Volcan")
                        ancienName = "Volcan"
                        affichagePopupList = true
                        }
                        
                        if ancienName1 != reperesVisuelsDatabase[i]!.swLongName && reperesVisuelsDatabase[i]!.visibleReperesVisuel &&  reperesVisuelsDatabase[i]!.swKind == "Volcan" {
                            data.append(["\(reperesVisuelsDatabase[i]!.swLongName)"])
                            iconesData.append("MAP-INF-VOLC")
                            dataTableView.append(["Volcan", "\(i)"])
                            ancienName1 = reperesVisuelsDatabase[i]!.swLongName
                        }
                    
                }
            }
        }
        
        //Reperes Visuels Fôret
        if applicationParametres.buttonOptionMapView[13] {
            for i in 0...reperesVisuelsDatabase.count-1 {
                let secondLocation = CLLocation(latitude: reperesVisuelsDatabase[i]!.swLatitude, longitude: reperesVisuelsDatabase[i]!.swLongitude)
                let distance = getBearingBetweenTwoPoints1(point1 : myLocation, point2 : secondLocation)
                if distance < distanceMax {
                    if ancienName != "Forêt" && reperesVisuelsDatabase[i]!.swKind == "Forêt" {
                        print ("Warning Interdictions Possibility Foret : \(reperesVisuelsDatabase[i]!.swShortName) \(reperesVisuelsDatabase[i]!.swLongName) -> \(distance)")
                        headerTitles.append("Forêt")
                        ancienName = "Forêt"
                        affichagePopupList = true
                    }
                    if ancienName1 != reperesVisuelsDatabase[i]!.swLongName && reperesVisuelsDatabase[i]!.visibleReperesVisuel && reperesVisuelsDatabase[i]!.swKind == "Forêt" {
                        data.append(["\(reperesVisuelsDatabase[i]!.swLongName)"])
                        iconesData.append("MAP-INF-FORT")
                        dataTableView.append(["Forêt", "\(i)"])
                        ancienName1 = reperesVisuelsDatabase[i]!.swLongName
                    }
                }

            }
        }
        
        //Reperes Visuels Lac
        if applicationParametres.buttonOptionMapView[14] {
             for i in 0...reperesVisuelsDatabase.count-1 {
                let secondLocation = CLLocation(latitude: reperesVisuelsDatabase[i]!.swLatitude, longitude: reperesVisuelsDatabase[i]!.swLongitude)
                let distance = getBearingBetweenTwoPoints1(point1 : myLocation, point2 : secondLocation)
                if distance < distanceMax {
                    if ancienName != "Lac" && reperesVisuelsDatabase[i]!.swKind == "Lac" {
                        //print ("Warning Interdictions Possibility Lac : \(reperesVisuelsDatabase[i]!.swShortName) \(reperesVisuelsDatabase[i]!.swLongName) -> \(distance)")
                        headerTitles.append("Lac")
                        ancienName = "Lac"
                        affichagePopupList = true
                    }
                    if ancienName1 != reperesVisuelsDatabase[i]!.swLongName && reperesVisuelsDatabase[i]!.visibleReperesVisuel && reperesVisuelsDatabase[i]!.swKind == "Lac" {
                        data.append(["\(reperesVisuelsDatabase[i]!.swLongName)"])
                        print ("Warning Interdictions Possibility Lac : \(reperesVisuelsDatabase[i]!.swShortName) - \(reperesVisuelsDatabase[i]!.swLongName) -> \(distance)")
                        iconesData.append("MAP-INF-LAC_")
                        dataTableView.append(["Lac", "\(i)"])
                        ancienName1 = reperesVisuelsDatabase[i]!.swLongName
                    }
                }

            }
        }

        if affichagePopupList {
            
            let taillePopupWidth: CGFloat = 538
            let taillePopupHeight: CGFloat = 345
            var positionX: Int = 0
            var positionY: Int = 0
            //calcul position popup
            if Int(tapPoint.x - taillePopupWidth) > 5 && Int(tapPoint.x + taillePopupWidth) < Int(UIScreen.main.bounds.size.width) {
                print (UIScreen.main.bounds.size.width)
                positionX = Int(tapPoint.x-(taillePopupWidth/2))
            } else {
                if Int(tapPoint.x - taillePopupWidth - 40 ) > 5 {
                    positionX = Int(tapPoint.x - taillePopupWidth - 40 )
                } else if Int(tapPoint.x + taillePopupWidth) < Int(UIScreen.main.bounds.size.width) {
                    positionX = Int(tapPoint.x + 40)
                } else {
                    positionX = 5
                }
            }
            if Int(tapPoint.y - taillePopupHeight) > 64 && Int(tapPoint.y + 40 + taillePopupHeight + 5 ) < Int(UIScreen.main.bounds.size.height) {
                    positionY = Int(tapPoint.y + 40)
            } else {
                if Int(tapPoint.y + taillePopupHeight + 5 ) < Int(UIScreen.main.bounds.size.height) {
                    positionY = Int(tapPoint.y + 5)
                    
                } else {
                    positionY = Int(UIScreen.main.bounds.size.height - taillePopupHeight - 5)
                    
                }
            
                if Int(tapPoint.x + taillePopupWidth + 40 ) < Int(UIScreen.main.bounds.size.width) {
                    positionX = Int(tapPoint.x + 40)
                } else if Int(tapPoint.x - taillePopupWidth - 40 ) > 5 {
                    positionX = Int(tapPoint.x - 40 - taillePopupWidth)
                } else {
                    positionX = Int(tapPoint.x - taillePopupWidth/2)
                    positionY = Int(tapPoint.y + 40)
                    
                }
            
            }
            selectedSectionIndex = -1
            selectedRowIndex = -1
            let popup = UIView()
            popup.frame = CGRect(x: CGFloat(positionX), y: CGFloat(positionY), width: taillePopupWidth, height: taillePopupHeight)
            popup.backgroundColor = UIColor.white
            popup.layer.cornerRadius = 10
            popup.tag = 221
                        
            tableView.reloadData()
            tableView = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
            tableView.dataSource = self
            tableView.delegate = self
            tableView.backgroundColor = UIColor.white
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 85
            
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "my")
            
            tableView.contentInset.top = 5
            tableView.frame = CGRect(x: 10, y: 10, width: taillePopupWidth - 20, height: 335)
            tableView.backgroundColor = UIColor.white
            let contentSize = self.tableView.contentSize
            let footer = UIView(frame: CGRect(x: self.tableView.frame.origin.x,
                                              y: self.tableView.frame.origin.y + contentSize.height,
                                              width: self.tableView.frame.size.width,
                                              height: self.tableView.frame.height - self.tableView.contentSize.height))
            
            self.tableView.tableFooterView = footer
            
            
            popup.addSubview(tableView)
            self.view.addSubview(popup)
            
        } else {
            
            for layer: CALayer in self.view.layer.sublayers! {
                if layer.name == "Touch Zone" {
                    layer.removeFromSuperlayer()
                }
                
            }
            
            let viewWithTag221 = self.view.viewWithTag(221)
            viewWithTag221?.removeFromSuperview()
            
        }
        
        
    }

    
    @objc func rotateAction(sender:UIRotationGestureRecognizer){
        
        
        localisationCenterMap = mapView.centerCoordinate
        zoomLevelMap = mapView.zoomLevel
        directionMap = mapView.direction
        
        print ("Rotation")
        print ("Localisation Coordonates Update \(localisationCenterMap) ")
        print ("Zoom Level Update \(zoomLevelMap) ")
        print ("Direction Update \(directionMap) ")
        
        var originalRotation = CGFloat()
        if sender.state == .began {
            
            sender.rotation = lastRotation
            originalRotation = sender.rotation
            print("Rotate Began")
            
        }
        if sender.state == .changed{
            //print(String(format:"rotation: %2.3f",sender.rotation))
            let newRotation = sender.rotation + originalRotation
            //sender.view?.transform = CGAffineTransform(rotationAngle: newRotation).rotated(by: 45.0 / 180.0 * .pi)
            print (newRotation)
            
        }
        if sender.state == .ended{
            print("Rotate Ended")
            // Save the last rotation
            lastRotation = sender.rotation

            //affichageFondCartesMapbox()
            
        }
    }
    
    @objc func dragged(gestureRecognizer: UIPanGestureRecognizer) {
        
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
           
            let centerScreenPoint: CGPoint = mapView.convert(mapView.centerCoordinate, toPointTo: nil)
            print("Screen center mapView : \(centerScreenPoint) = \(mapView.center.x) \(mapView.center.y)")
            let offsetx = (centerScreenPoint.x - mapView.center.x) * 2
            let offsety = (centerScreenPoint.y - mapView.center.y - 4.95) * 2
            let translation = gestureRecognizer.translation(in: self.view)
            gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x - translation.x, y: gestureRecognizer.view!.center.y - translation.y)
            gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
           
            let touchCoordinate = mapView.convert(CGPoint(x: gestureRecognizer.view!.center.x + offsetx + translation.x, y: gestureRecognizer.view!.center.y+offsety + translation.y), toCoordinateFrom: self.mapView)
            
            print (" Center \(gestureRecognizer.view!.center.x) \(gestureRecognizer.view!.center.y) \(mapView.center.x) \(mapView.center.y) ")
            print (" Offset \(offsetx) \(offsety) ")
            localisationCenterMap = touchCoordinate
            zoomLevelMap = mapView.zoomLevel
            directionMap = mapView.direction

            print ("Localisation Coordonates Update \(localisationCenterMap) ")
            print ("Zoom Level Update \(zoomLevelMap) ")
            print ("Direction Update \(directionMap) ")
        }
        
        if gestureRecognizer.state == .ended {
            
            affichageFondCartesMapbox()
        }
    
    }
    
    /* End Of Function ******************************************************/
    
}
