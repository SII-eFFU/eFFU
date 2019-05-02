//
//  ViewController.swift
//  locatapp
//
//  Created by Thierry DANTHEZ on 12/11/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import CoreLocation
import EventKit
import MapKit
import Mapbox
import SQLite3

var applicationParametres = ApplicationParametres()
var imageLigne: String = ""
var nameImage: String = ""

// Permet de tester si deja existant
var departureOn: Bool = false
var arrivalOn: Bool = false

// Creer points de depart et d'arrivee
var departure = MGLPointAnnotation()
var arrival = MGLPointAnnotation()

var flight_Plan = FlightPlan()

class ViewController: UIViewController, UIGestureRecognizerDelegate, MKMapViewDelegate, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var tableView = UITableView()
    var selectedSectionIndex = -1
    var selectedRowIndex = -1
  
    var tableData = ["A", "B", "C", "D"]
    // Permet de stocker un element de la liste
    var data = [["0,0", "0,1", "0,2"], ["1,0", "1,1", "1,2"]]
    var headerTitles = ["A", "B"]
    // Permet de stocker l'icone d'un element de la liste
    var iconesData = ["A", "B", "C", "D"]
    var dataTableView = [["A", "B"], ["D", "E"]]
    
    
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        return tableData.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "my", for: indexPath)
//        cell.textLabel?.text = "\(tableData[indexPath.row])"
//
//        return cell
//
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
//        showDialog(text: (currentCell.textLabel?.text)!)
//    }
//
//    func showDialog(text : String) {
//        let alert = UIAlertController(title: "Alert", message: text, preferredStyle: UIAlertController.Style.alert)
//        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
//    }
//
    
    //*** Multi Choice
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return tableData.count
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
   
    func numberOfSections(in tableView: UITableView) -> Int {
        //print ("data count est à \(data.count)")
        return data.count
    }
    
    // Agrandir la ligne pour afficher les fonctions
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        // On test si il y a qu'un seul element dans la liste
        if indexPath.section == 0 && selectedSectionIndex == -1 && data.count == 1 {
            return 130
        }

        if indexPath.section == selectedSectionIndex{
            return 130 //Expanded
        }
        return 65 //Not expanded
        
    }
    
    // Gere l'affichage de la liste dans la Pop-up
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print("selectedSectionIndex est a \(selectedSectionIndex)")
        
        if selectedSectionIndex == indexPath.section {
            
            let indexPath = IndexPath(item: selectedRowIndex, section: selectedSectionIndex)
            selectedSectionIndex = -1
            selectedRowIndex = -1
            tableView.reloadRows(at: [indexPath], with: .automatic)
            
        
        } else {
            
            //print("selectedRowIndex est a \(selectedRowIndex)")
            
            
            
            if selectedRowIndex != -1{
                
                let indexPath = IndexPath(item: selectedRowIndex, section: selectedSectionIndex)
                
                selectedSectionIndex = -1
                selectedRowIndex = -1
                
                tableView.reloadRows(at: [indexPath], with: .automatic)
            

                

            }
            
            // Afficher la ligne qu'on selectionne
            selectedSectionIndex = indexPath.section
            selectedRowIndex = indexPath.row
            tableView.reloadRows(at: [indexPath], with: .automatic)
            
            
        }
        


    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
//        showDialog(text: (currentCell.textLabel?.text)!)
//    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        //let cell = UITableViewCell(style: .default, reuseIdentifier: imageLigne)
        //print (iconesData[indexPath.section])
        let popup1 = UIView()
        popup1.frame = CGRect(x: 0, y: 0, width: 503, height: 105)
        popup1.backgroundColor = UIColor(red: 186/255, green: 212/255, blue: 235/255, alpha: 1.0)
        
        
        let popup2 = UIView()
        popup2.frame = CGRect(x: 0, y: 32, width: 503, height: 60)
        popup2.backgroundColor = UIColor(red: 186/255, green: 212/255, blue: 235/255, alpha: 1.0)
        popup1.addSubview(popup2)

        let popup3 = UIView()
        popup3.frame = CGRect(x: 0, y: 0, width: 503, height: 35)
        popup3.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)

        let popup4 = UIView()
        popup4.frame = CGRect(x: 0, y: 0, width: 503, height: 35)
        popup4.backgroundColor = UIColor.clear

        
       
        // Verifier contenu de data
        //print("data est egal a \(data[indexPath.section][indexPath.row])")
        
        //print("indexPath section est a \(indexPath.section)")
        
        // On ajoute l'icone de l'element de la liste
        let IconeName = iconesData[indexPath.section]
        let iconeElement = UIImage(named: IconeName)
        let imageView = UIImageView(image: iconeElement!)
        imageView.frame = CGRect(x: 20, y: 2, width: 30, height: 30)
        
        popup3.addSubview(imageView)
        
        // parametrer nom de l'element dans la liste
        let titrePopup = UIButton(type: .custom)
        titrePopup.frame = CGRect(x:65, y:2, width:420, height:30)
        titrePopup.setTitleColor(UIColor.black, for: .normal)
        titrePopup.titleLabel?.font = titrePopup.titleLabel?.font.withSize(20)
        titrePopup.contentHorizontalAlignment = .left
        
        //creer nom de l'element dans la liste
        titrePopup.setTitle("\(data[indexPath.section][indexPath.row])", for: .normal)
        
        // Afficher le nom de l'element de la liste
        popup3.addSubview(titrePopup)
        
        // Creer icone de l'element de la liste quand clic
        let imageNameClic = iconesData[indexPath.section]
        let iconeElementClic = UIImage(named: imageNameClic)
        let imageViewClic = UIImageView(image: iconeElementClic!)
        imageViewClic.frame = CGRect(x: 20, y: 2, width: 30, height: 30)
        popup1.addSubview(imageViewClic)
        
        // parametrer nom de l'element dans la liste quand clic
        let titrepopupClic = UIButton(type: .custom)
        titrepopupClic.frame = CGRect(x: 65, y: 2, width: 420 , height: 30)
        titrepopupClic.setTitleColor(UIColor.black, for: .normal)
        titrepopupClic.titleLabel?.font = titrepopupClic.titleLabel?.font.withSize(20)
        titrepopupClic.contentHorizontalAlignment = .left
        
        //creer nom de l'element dans la liste quand clic
        titrepopupClic.setTitle("\(data[indexPath.section][indexPath.row])", for: .normal)
        
        // Afficher le nom de l'element de la liste quand clic
        popup1.addSubview(titrepopupClic)
        
        popup1.addSubview(popup4)
        
        
        let popup5 = UIView()
        popup5.frame = CGRect(x: 0, y: 0, width: 503, height: 35)
        popup5.backgroundColor = UIColor.clear
        popup3.addSubview(popup5)
 

        let buttonPopup1  = UIButton(type: .custom)
        buttonPopup1.setImage(UIImage(named: "Zoom_45x45"), for: .normal)
        buttonPopup1.frame = CGRect(x: 13, y: 8, width: 45, height: 45)
        buttonPopup1.tag = indexPath.section
        buttonPopup1.addTarget(self, action: #selector(zoomPopup(_:)), for: .touchUpInside)
        buttonPopup1.alpha = 1.0
        popup2.addSubview(buttonPopup1)

        let buttonPopup2  = UIButton(type: .custom)
        buttonPopup2.setImage(UIImage(named: "Departure_45x45"), for: .normal)
        buttonPopup2.frame = CGRect(x: 61, y: 8, width: 45, height: 45)
        buttonPopup2.tag = indexPath.section
        buttonPopup2.addTarget(self, action: #selector(departurePopup(_:)), for: .touchUpInside)
        //buttonPopup2.tag = 2102
        buttonPopup2.alpha = 1.0
        popup2.addSubview(buttonPopup2)

        let buttonPopup3  = UIButton(type: .custom)
        buttonPopup3.setImage(UIImage(named: "Arrival_45x45"), for: .normal)
        buttonPopup3.frame = CGRect(x: 109, y: 8, width: 45, height: 45)
        buttonPopup3.tag = indexPath.section
        buttonPopup3.addTarget(self, action: #selector(arrivalPopup(_:)), for: .touchUpInside)
        //buttonPopup3.tag = 2103
        buttonPopup3.alpha = 1.0
        popup2.addSubview(buttonPopup3)

        let buttonPopup4  = UIButton(type: .custom)
        buttonPopup4.setImage(UIImage(named: "Alternate_45x45"), for: .normal)
        buttonPopup4.frame = CGRect(x: 157, y: 8, width: 45, height: 45)
        buttonPopup4.addTarget(self, action: #selector(alertPopup), for: .touchUpInside)
        buttonPopup4.tag = 2104
        buttonPopup4.alpha = 1.0
        popup2.addSubview(buttonPopup4)

        let buttonPopup5  = UIButton(type: .custom)
        buttonPopup5.setImage(UIImage(named: "Waypoint_45x45"), for: .normal)
        buttonPopup5.frame = CGRect(x: 205, y: 8, width: 45, height: 45)
        buttonPopup5.addTarget(self, action: #selector(alertPopup), for: .touchUpInside)
        buttonPopup5.tag = 2105
        buttonPopup5.alpha = 1.0
        popup2.addSubview(buttonPopup5)

        let buttonPopup6  = UIButton(type: .custom)
        buttonPopup6.setImage(UIImage(named: "Landmark_45x45"), for: .normal)
        buttonPopup6.frame = CGRect(x: 253, y: 8, width: 45, height: 45)
        buttonPopup6.addTarget(self, action: #selector(alertPopup), for: .touchUpInside)
        buttonPopup6.tag = 2106
        buttonPopup6.alpha = 1.0
        popup2.addSubview(buttonPopup6)

        let buttonPopup7  = UIButton(type: .custom)
        buttonPopup7.setImage(UIImage(named: "Pictures_45x45"), for: .normal)
        buttonPopup7.frame = CGRect(x: 301, y: 8, width: 45, height: 45)
        buttonPopup7.addTarget(self, action: #selector(alertPopup), for: .touchUpInside)
        buttonPopup7.tag = 2107
        buttonPopup7.alpha = 1.0
        popup2.addSubview(buttonPopup7)

        let buttonPopup8  = UIButton(type: .custom)
        buttonPopup8.setImage(UIImage(named: "Information_45x45"), for: .normal)
        buttonPopup8.frame = CGRect(x: 349, y: 8, width: 45, height: 45)
        buttonPopup8.addTarget(self, action: #selector(alertPopup), for: .touchUpInside)
        buttonPopup8.tag = 2108
        buttonPopup8.alpha = 1.0
        popup2.addSubview(buttonPopup8)

        let buttonPopup9  = UIButton(type: .custom)
        buttonPopup9.setImage(UIImage(named: "Zoom_45x45"), for: .normal)
        buttonPopup9.frame = CGRect(x: 397, y: 8, width: 45, height: 45)
        buttonPopup9.addTarget(self, action: #selector(alertPopup), for: .touchUpInside)
        buttonPopup9.tag = 2109
        buttonPopup9.alpha = 1.0
        popup2.addSubview(buttonPopup9)

        let buttonPopup10  = UIButton(type: .custom)
        buttonPopup10.setImage(UIImage(named: "Zoom_45x45"), for: .normal)
        buttonPopup10.frame = CGRect(x: 445, y: 8, width: 45, height: 45)
        buttonPopup10.addTarget(self, action: #selector(alertPopup), for: .touchUpInside)
        buttonPopup10.tag = 2109
        buttonPopup10.alpha = 1.0
        popup2.addSubview(buttonPopup10)

        let buttonPopup11  = UIButton(type: .custom)
        buttonPopup11.setImage(UIImage(named: "Zoom_45x45"), for: .normal)
        buttonPopup11.frame = CGRect(x: 445, y: 8, width: 45, height: 45)
        buttonPopup11.addTarget(self, action: #selector(alertPopup), for: .touchUpInside)
        buttonPopup11.tag = 2109
        buttonPopup11.alpha = 1.0
        popup2.addSubview(buttonPopup11)
        
        // Premier if -> On test si il y a qu'un seul element dans la liste
        if indexPath.section == 0 && data.count == 1 {
            // On affiche les fonctions
            cell.accessoryView = popup1
            // On ne peut pas les retirer
        } else {
            
            if indexPath.section == selectedSectionIndex && indexPath.section != -1 {
                
                cell.accessoryView =  popup1
                
            } else {
                
                cell.accessoryView =  popup3
                
            }
        }
        
        //indexPath.section == 0 && selectedSectionIndex > 0
        /**
        switch indexPath.section {
        case _ where indexPath.section == 0:
            
            if selectedSectionIndex == -1{
                cell.accessoryView = popup1
                //print("Afficher fonction 1er element")
            } else if selectedSectionIndex == 0{
                cell.accessoryView = popup3
                //print("Fermeture fonction 1er element")
            }
            
        case _ where indexPath.section > 0:
            
            if indexPath.section == selectedSectionIndex{
                cell.accessoryView = popup1
                //print("Afficher fonction d'un element diff du 1er")
            } else {
                cell.accessoryView = popup3
                //print("Fermeture fonction d'un element diff du 1er")
            }
            
        default:
            print("erreur")
        }
        
        **/
        //print ("\(data[indexPath.section].count)")
        //print("\(indexPath.section)")
        
        //print ("\(indexPath.index(after: indexPath.section))")
        //print ("\(indexPath.endIndex)")

        
        return cell
    }
    
    @objc func zoomPopup(_ sender:UIButton) {
        //print(dataTableView[sender.tag][0])
        // Permet de tester quel type d'element on a pour la selection dans la base de donnees
        print("C'est un/une \(dataTableView[sender.tag][0])")
        if dataTableView[sender.tag][0] == "Airports" {
            localisationCenterMap = CLLocationCoordinate2D(latitude: airportsDatabase[Int(dataTableView[sender.tag][1])!]!.swLatitude, longitude: airportsDatabase[Int(dataTableView[sender.tag][1])!]!.swLongitude)
            zoomLevelMap = 14.5
            directionMap = 0
            affichageFondCartesMapbox()
            
        }

        if dataTableView[sender.tag][0] == "Ville" {
            localisationCenterMap = CLLocationCoordinate2D(latitude: villesDatabase[Int(dataTableView[sender.tag][1])!]!.swLatitude, longitude: villesDatabase[Int(dataTableView[sender.tag][1])!]!.swLongitude)
            zoomLevelMap = 14.5
            directionMap = 0
            affichageFondCartesMapbox()
            
        }
        
        if dataTableView[sender.tag][0] == "Repéres Visuels" || dataTableView[sender.tag][0] == "Lac" || dataTableView[sender.tag][0] == "Forêt" || dataTableView[sender.tag][0] == "Montagne" || dataTableView[sender.tag][0] == "Volcan" {
            localisationCenterMap = CLLocationCoordinate2D(latitude: reperesVisuelsDatabase[Int(dataTableView[sender.tag][1])!]!.swLatitude, longitude: reperesVisuelsDatabase[Int(dataTableView[sender.tag][1])!]!.swLongitude)
            zoomLevelMap = 14.5
            directionMap = 0
            affichageFondCartesMapbox()
            
        }
        
        if dataTableView[sender.tag][0] == "Warning Terminal" {
            localisationCenterMap = CLLocationCoordinate2D(latitude: navWarningDatabase[Int(dataTableView[sender.tag][1])!]!.swLatitude, longitude: navWarningDatabase[Int(dataTableView[sender.tag][1])!]!.swLongitude)
            zoomLevelMap = 14.5
            directionMap = 0
            affichageFondCartesMapbox()
            
        }
        
        if dataTableView[sender.tag][0] == "Navaids Terminal" || dataTableView[sender.tag][0] == "Navaids En Route" {
            localisationCenterMap = CLLocationCoordinate2D(latitude: villesDatabase[Int(dataTableView[sender.tag][1])!]!.swLatitude, longitude: villesDatabase[Int(dataTableView[sender.tag][1])!]!.swLongitude)
            zoomLevelMap = 14.5
            directionMap = 0
            affichageFondCartesMapbox()
            
        }
     
    }
    
    @objc func alertPopup() {
        let alert = UIAlertController(title: "Alert", message: "Not Implemented", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func alertPopupNotAirports() {
        let alert = UIAlertController(title: "Alert", message: "Ce n'est pas un aerodrome", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }

    @objc func alertPopupSuppPointDeparture() {
        let alert = UIAlertController(title: "Alert", message: "Voulez-vous supprimer le point de depart ?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Oui", style: UIAlertAction.Style.default, handler: { action in self.suppPointDeparture() } ))
        alert.addAction(UIAlertAction(title: "Non", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func alertPopupSuppPointArrival() {
        let alert = UIAlertController(title: "Alert", message: "Voulez-vous supprimer le point d'arrivee ?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Oui", style: UIAlertAction.Style.default, handler: { action in self.suppPointArrival() } ))
        alert.addAction(UIAlertAction(title: "Non", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func alertnoAirportsAssigned(){
        let alert = UIAlertController(title: "Alert", message: "Aucun aerodrome", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
    // Permet de supprimer les annotations de la view
    func suppMarkers(){
        
        //let allAnnotations = self.mapView.annotations
        //self.mapView.removeAnnotations(allAnnotations!)
        
        suppRoutePlane()
        
        departureOn = false
        arrivalOn = false
        
        flight_Plan.unset_Departure_Airfield()
        flight_Plan.unset_Arrival_Airfield()
    }
    **/
    
    @objc func departurePopup(_ sender:UIButton){
        // on on effectue le traitement que si airports
        print("C'est un/une \(dataTableView[sender.tag][0])")
        if dataTableView[sender.tag][0] == "Airports" && departureOn == false {
            
            let aiIcaoAirport = airportsDatabase[Int(dataTableView[sender.tag][1])!]!.aiIcao
            print ("L'Icao est \(aiIcaoAirport)")
            let nomAirport = airportsDatabase[Int(dataTableView[sender.tag][1])!]!.aiName
            print("c'est l'\(nomAirport)")
            
            // Creer un point depart sur les coordonnees de l'aerodrome
            // recuperer latitude et longitude de l'element
            let latitude = airportsDatabase[Int(dataTableView[sender.tag][1])!]!.swLatitude
            let longitude = airportsDatabase[Int(dataTableView[sender.tag][1])!]!.swLongitude
            
            print("la latitude est de \(latitude) et la longitude de \(longitude)")
            
            flight_Plan.set_Departure_Airfield(aiIcao: aiIcaoAirport, name: nomAirport, latitude: latitude, longitude: longitude)
            
            print(flight_Plan.airport_Departure)
            
            displayPointDeparture()
            displayRoutePlane()
            
            //mapView.delegate = self
            //let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            // Creer le point depart
            //let departure = MGLPointAnnotation()
            //departure.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            // Ajouter le point a la map
            //mapView.addAnnotation(departure)
            //departureOn = true
            
        } else if departureOn == true {
            alertPopupSuppPointDeparture()
        } else {
            alertPopupNotAirports()
        }
        
    }
    
    @objc func arrivalPopup(_ sender:UIButton){
        // on on effectue le traitement que si airports
        print("C'est un/une \(dataTableView[sender.tag][0])")
        if dataTableView[sender.tag][0] == "Airports" && arrivalOn == false{
            // Creer un point depart sur les coordonnees de l'aerodrome
            let aiIcaoAirport = airportsDatabase[Int(dataTableView[sender.tag][1])!]!.aiIcao
            print ("L'Icao est \(aiIcaoAirport)")
            let nomAirport = airportsDatabase[Int(dataTableView[sender.tag][1])!]!.aiName
            print("c'est l'\(nomAirport)")
            // recuperer latitude et longitude de l'element
            let latitude = airportsDatabase[Int(dataTableView[sender.tag][1])!]!.swLatitude
            let longitude = airportsDatabase[Int(dataTableView[sender.tag][1])!]!.swLongitude
            print("la latitude est de \(latitude) et la longitude de \(longitude)")
            
            flight_Plan.set_Arrival_Airfield(aiIcao: aiIcaoAirport, name: nomAirport, latitude: latitude, longitude: longitude)
            
            print(flight_Plan.airport_Arrival)
            
            displayPointArrival()
            displayRoutePlane()
            
            //mapView.delegate = self
            //let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            // Creer le point arrivee
            //let arrival = MGLPointAnnotation()
            //arrival.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            // Ajouter le point a la map
            //mapView.addAnnotation(arrival)
            //arrivalOn = true
            
        } else if arrivalOn == true{
            alertPopupSuppPointArrival()
        } else {
            alertPopupNotAirports()
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < headerTitles.count {
            return headerTitles[section]
        }
        
        return nil
    }
    

    
    @objc func showDialog(text : String)
    {
        let alert = UIAlertController(title: "Alert", message: text, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    var dataArray : [[Any]] = []
    
    var airportsDatabase = [ Int: airports ]()
    var villesDatabase  = [ Int: villes ]()
    var reperesVisuelsDatabase = [ Int: reperesVisuels ]()
    var navaidsDatabase = [ Int: navaids ]()
    var navWarningDatabase = [ Int: navwarning ]()
    
    var db: OpaquePointer?

    var locationManager:CLLocationManager!

    var lastRotation: CGFloat = 0
    var mapView:MGLMapView!
    var contoursLayer: MGLStyleLayer?
    var startLocation: CLLocation!
    
    //Toulouse
    //public var localisationCenterMap = CLLocationCoordinate2D(latitude: 43.587778, longitude: 1.498611)
    //public var zoomLevelMap: Double = 7.8
    //Route
    public var localisationCenterMap = CLLocationCoordinate2D(latitude: 44.21473676101306, longitude: 0.1891793550011016)
    public var zoomLevelMap: Double = 8

    public var directionMap: Double = 0
    
    /************************************************
     *    Used to Start getting the users location  *
     ************************************************/
    
    //Status bar white color
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    /************************************************/
    
    
        override func viewDidLoad() {
            super.viewDidLoad()

        }
 
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            // Create and Add MapView to our main view

           self.createDemarrageAppli()
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            determineCurrentLocation()
        }
    
        override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()

        }
    
    
   
    
    func createDemarrageAppli() {

    /************************************************
     *    Initialisation des Array Menus            *
     ************************************************/
        //D_avec_décimales = X + Y/60 + Z/3600
        
        //Lecture Airports + Villes Database
        readAirportsDatabase()
        readVillesDatabase()
        readReperesVisuelsDatabase()
        readNavaidsDatabase()
        readWarningDatabase()
        
            
        // Menu Principal
        arrayMenuOptions.append(["title":"Plans de vol", "icon":"FlightPlans", "target":"plansDeVol"])
        arrayMenuOptions.append(["title":"Cartes VAC", "icon":"_ionicons_svg_ios-map.png", "target":"cartesVAC"])
        arrayMenuOptions.append(["title":"e-Bibliothèque", "icon":"_ionicons_svg_ios-book.png", "target":"eBibliotheque"])
        arrayMenuOptions.append(["title":"Aéronefs", "icon":"_ionicons_svg_ios-paper-plane.png", "target":"aeronefs"])
        arrayMenuOptions.append(["title":"Utilisateurs", "icon":"_ionicons_svg_ios-people.png", "target":"utilisateurs"])
        arrayMenuOptions.append(["title":"Checklists", "icon":"_ionicons_svg_ios-list.png", "target":"checklists"])
        arrayMenuOptions.append(["title":"Menu Principal", "icon":"_ionicons_svg_ios-log-out.png", "target":"menuPrincipal"])
        
        // Icone Map View Options
        arrayMapViewOptions.append(["title":"mapMenuIconFlightPlan", "iconOff":"mapMenuIconFlightPlan", "iconOn":"mapMenuIconFlightPlanActive", "target":"mapMenuIconFligthPlan"])
        arrayMapViewOptions.append(["title":"mapMenuIconAirfield", "iconOff":"mapMenuIconAirfield", "iconOn":"mapMenuIconAirfieldActive", "target":"mapMenuIconAirfield"])
        arrayMapViewOptions.append(["title":"mapMenuIconAirfield2", "iconOff":"mapMenuIconRunway", "iconOn":"mapMenuIconRunwayActive", "target":"mapMenuIconAirfield2"])
        arrayMapViewOptions.append(["title":"mapMenuIconRadionave", "iconOff":"mapMenuIconEnrouteNavaids", "iconOn":"mapMenuIconEnrouteNavaidsActive", "target":"mapMenuIconRadionave"])
        arrayMapViewOptions.append(["title":"mapMenuIconRadionavt", "iconOff":"mapMenuIconTerminalNavaids", "iconOn":"mapMenuIconTerminalNavaidsActive", "target":"mapMenuIconRadionavt"])

        arrayMapViewOptions.append(["title":"mapMenuIconWarningInterdiction", "iconOff":"mapMenuIconWarningInterdiction", "iconOn":"mapMenuIconWarningInterdictionActive", "target":"mapMenuIconWarningInterdiction"])
        arrayMapViewOptions.append(["title":"mapMenuIconAirspaceLow", "iconOff":"mapMenuIconSFCtoFL065", "iconOn":"mapMenuIconSFCtoFL065Active", "target":"mapMenuIconAirspaceLow"])
        arrayMapViewOptions.append(["title":"mapMenuIconAirspaceHigh", "iconOff":"mapMenuIconFL065toFL115", "iconOn":"mapMenuIconFL065toFL115Active", "target":"mapMenuIconAirspaceHigh"])
        arrayMapViewOptions.append(["title":"mapMenuIconAirspaceHigh1", "iconOff":"mapMenuIconFL115toFL145", "iconOn":"mapMenuIconFL115toFL145Active", "target":"mapMenuIconAirspaceHigh1"])
        arrayMapViewOptions.append(["title":"mapMenuIconAirspaceHigh2", "iconOff":"mapMenuIconFL145toFL195", "iconOn":"mapMenuIconFL145toFL195Active", "target":"mapMenuIconAirspaceHigh2"])
            
        arrayMapViewOptions.append(["title":"mapMenuIconLandmark", "iconOff":"mapMenuIconLandmark", "iconOn":"mapMenuIconLandmarkActive", "target":"mapMenuIconLandmark"])
        arrayMapViewOptions.append(["title":"mapMenuIconCity", "iconOff":"mapMenuIconCity", "iconOn":"mapMenuIconCityActive", "target":"mapMenuIconCity"])
        arrayMapViewOptions.append(["title":"mapMenuIconPeak", "iconOff":"mapMenuIconPeak", "iconOn":"mapMenuIconPeakActive", "target":"mapMenuIconPeak"])
        arrayMapViewOptions.append(["title":"mapMenuIconForest", "iconOff":"mapMenuIconForest", "iconOn":"mapMenuIconForestActive", "target":"mapMenuIconForest"])
        arrayMapViewOptions.append(["title":"mapMenuIconLake", "iconOff":"mapMenuIconLake", "iconOn":"mapMenuIconLakeActive", "target":"mapMenuIconLake"])
            
        arrayMapViewOptions.append(["title":"menuMapOtionsViewMap1", "iconOff":"mapMenuIconMap1", "iconOn":"mapMenuIconMap1active", "target":"menuMapOtionsViewMap1"])
        arrayMapViewOptions.append(["title":"menuMapOtionsViewMap2", "iconOff":"mapMenuIconMap2", "iconOn":"mapMenuIconMap2active", "target":"menuMapOtionsViewMap2"])
        arrayMapViewOptions.append(["title":"menuMapOtionsViewMap3", "iconOff":"mapMenuIconMap3", "iconOn":"mapMenuIconMap3active", "target":"menuMapOtionsViewMap3"])
        arrayMapViewOptions.append(["title":"menuMapOtionsViewMap4", "iconOff":"mapMenuIconMap4", "iconOn":"mapMenuIconMap4active", "target":"menuMapOtionsViewMap4"])
        arrayMapViewOptions.append(["title":"menuMapOtionsViewMap5", "iconOff":"mapMenuIconMap5", "iconOn":"mapMenuIconMap5active", "target":"menuMapOtionsViewMap5"])

        /************************************************
         *    Initialisation des couches view           *
         ************************************************/
        
        for indexLayout in 1...250 {

            let smallFrame = CGRect(x: 1, y: 1, width: 1, height: 0)
            let layoutAdding = UIView(frame: smallFrame)

            layoutAdding.backgroundColor = UIColor.clear
            layoutAdding.tag = indexLayout
            layoutAdding.isOpaque = false

            self.view.insertSubview(layoutAdding, at: indexLayout)

        }
        
        /************************************************
         *    Chargement des couches view au demarrage  *
         ************************************************/
        
        self.splashScreen(visible: true)
        self.affichageFondCartesMapbox()
        self.menuAccueil(visible: true)
                
        /*************************************************
         * Initialisation Authorisation Geolocatlisation *
         *************************************************/
        
        // For use when the app is open & in the background
    //    locationManager.requestAlwaysAuthorization()
        
        // For use when the app is open
        //locationManager.requestWhenInUseAuthorization()
        
        // If location services is enabled get the users location
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyBest // You can change the locaiton accuary here.
//            locationManager.startUpdatingLocation()
//        }

    }
    
    /* Begin Of Function ******************************************************
     *    Function de Transition Rotation           *
     ************************************************/
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        print("Pivotement Tablette !!!")
        if (size.width != self.view.frame.size.width) {

            DispatchQueue.main.async {
                print (applicationParametres.screenActive as Any)
                
                /************************************************
                 *    Rechargement page active                 *
                 ************************************************/
                
                if applicationParametres.screenActive == "accueilScreen" {
                    
                    self.menuAccueil(visible: true)
                    
                }
                if applicationParametres.screenActive == "splashScreen" {
                    
                    self.splashScreen(visible: true)
                    self.menuAccueil(visible: true)
                }
                if applicationParametres.screenActive == "mapScreen" {
                    
                    
                   self.reLoadLayerStatusBar()
//                    self.navigationBarMenu(visible: true)
//                    self.addMenuPrincipal(visible: applicationParametres.visibleMenuPrincipal)
//                    self.menuOptionMapView(visible: applicationParametres.visibleMenuOptionMapView)
//                    self.clipBoardPanel(visible: applicationParametres.visibleClipBoardMapView)
                   
                    
                }
                
                    
             }
        }
        
    }
    
    /* End Of Function ******************************************************/
    
    /* Begin Of Function ******************************************************
     *    Function de Geolocalisation               *
     ************************************************/
    
//    // Print out the location to the console
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.first {
//            print(location.coordinate)
//
//        }
//    }
//
//    // If we have been deined access give the user the option to change it
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        if(status == CLAuthorizationStatus.denied) {
//            showLocationDisabledPopUp()
//        }
//    }
//
//    // Show the popup to the user if we have been deined access
//    func showLocationDisabledPopUp() {
//        let alertController = UIAlertController(title: "Background Location Access Disabled",
//                                                message: "In order to localize we need your location",
//                                                preferredStyle: .alert)
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        alertController.addAction(cancelAction)
//
//        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
//            if let url = URL(string: UIApplication.openSettingsURLString) {
//                UIApplication.shared.open(url, options: [:], completionHandler: nil)
//            }
//        }
//        alertController.addAction(openAction)
//
//        self.present(alertController, animated: true, completion: nil)
//    }
    
    /* End Of Function ******************************************************/
    
    
    func determineCurrentLocation()
    {
        print ("Coucou Current Location ")
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
               
        // user activated automatic authorization info mode
        let status = CLLocationManager.authorizationStatus()
        if status == .notDetermined || status == .denied || status == .authorizedWhenInUse {
            
            // present an alert indicating location authorization required
            // and offer to take the user to Settings for the app via
            // UIApplication -openUrl: and UIApplicationOpenSettingsURLString
        
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        
        }
        
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
                if let location = locations.first {
                   print("Map-User latitude = \(location.coordinate)")
        
                }
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        //manager.stopUpdatingLocation()
        print ("coucou localisation User")
        //let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        // let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        print("user latitude = \(userLocation.coordinate.latitude) longitude = \(userLocation.coordinate.longitude)")
        
        //mapView.setRegion(region, animated: true)
        
        // Drop a pin at user's Current Location
//        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
//        myAnnotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
//        myAnnotation.title = "Current location"
//        mapView.addAnnotation(myAnnotation)
    }
    
    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print("Error \(error)")
    }
    
//    func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
//        // Try to reuse the existing ‘pisa’ annotation image, if it exists.
//
//        let reuseId = "\(annotation.coordinate.longitude)"
//        var annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: reuseId)
//
//        if annotationImage == nil {
//            // Leaning Tower of Pisa by Stefan Spieler from the Noun Project.
//            var image = UIImage(named: "military_airport_02f")!
//
//
//
//            // The anchor point of an annotation is currently always the center. To
//            // shift the anchor point to the bottom of the annotation, the image
//            // asset includes transparent bottom padding equal to the original image
//            // height.
//            //
//            // To make this padding non-interactive, we create another image object
//            // with a custom alignment rect that excludes the padding.
//            image = image.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: image.size.height/2, right: 0))
//
//            // Initialize the ‘pisa’ annotation image with the UIImage we just loaded.
//            annotationImage = MGLAnnotationImage(image: image, reuseIdentifier: reuseId)
//        }
//
//
//
//        return annotationImage
//    }
    
//    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
//        // Always allow callouts to popup when annotations are tapped.
//        print ("coucou allow callouts")
//        return true
//    }
    
    func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
        
        if let point = annotation as? CustomPointAnnotation,
            let image = point.image,
            let reuseIdentifier = point.reuseIdentifier {

            if let annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: reuseIdentifier) {
                // The annotatation image has already been cached, just reuse it.
                return annotationImage
            } else {
                // Create a new annotation image.
                return MGLAnnotationImage(image: image, reuseIdentifier: reuseIdentifier)
            }
        }
        
        if let departures = annotation as? CustomPointAnnotation,
            let image = departures.image,
            let reuseIdentifier = departures.reuseIdentifier {
            
            if let annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: reuseIdentifier) {
                return annotationImage
            } else {
                
                return MGLAnnotationImage(image: image, reuseIdentifier: reuseIdentifier)
            }
        }
        
        if let arrivals = annotation as? CustomPointAnnotation,
            let image = arrivals.image,
            let reuseIdentifier = arrivals.reuseIdentifier {
            
            if let annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: reuseIdentifier) {
                return annotationImage
            } else {
                
                return MGLAnnotationImage(image: image, reuseIdentifier: reuseIdentifier)
            }
        }
        /**
        if departureOn == false {
            var annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: "departure")
            
            if annotationImage == nil {
                var image = UIImage(named: "departures_map")
                image = image?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: image!.size.height/2, right: 0))
                annotationImage = MGLAnnotationImage(image: image!, reuseIdentifier: "departure")
            }
            departureOn = true
            return annotationImage
        }
        
        if arrivalOn == false {
            var annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: "arrival")
            
            if annotationImage == nil {
                var image = UIImage(named: "arrivals_map")
                image = image?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: image!.size.height/2, right: 0))
                annotationImage = MGLAnnotationImage(image: image!, reuseIdentifier: "arrival")
            }
            arrivalOn = true
            return annotationImage
        }
        **/
        
        // Fallback to the default marker image.
        return nil
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 85;
        
    }
//     func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
//        print ("annotations operations")
//        // get the custom reuse identifier for this annotation
//        let reuseIdentifier = reuseIdentifierForAnnotation(annotation: annotation)
//        // try to reuse an existing annotation image, if it exists
//        var annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: reuseIdentifier)
//
//        // if the annotation image hasn‘t been used yet, initialize it here with the reuse identifier
//        if annotationImage == nil {
//            print ("passe")
//            // lookup the image for this annotation
//            let image = imageForAnnotation(annotation: annotation)
//            annotationImage = MGLAnnotationImage(image: image, reuseIdentifier: reuseIdentifier)
//        } else {
//
//            print ("coucou")
//
//        }
//
//        return annotationImage
//    }
//
//    // create a reuse identifier string by concatenating the annotation coordinate, title, subtitle
//    func reuseIdentifierForAnnotation(annotation: MGLAnnotation) -> String {
//        var reuseIdentifier = "\(annotation.coordinate.latitude),\(annotation.coordinate.longitude)"
//        if let title = annotation.title, title != nil {
//            reuseIdentifier += title!
//        }
//        if let subtitle = annotation.subtitle, subtitle != nil {
//            reuseIdentifier += subtitle!
//        }
//        return reuseIdentifier
//    }
//
//    // lookup the image to load by switching on the annotation title string
//    func imageForAnnotation(annotation: MGLAnnotation) -> UIImage {
//        var imageName = ""
//        if let title = annotation.title, title != nil {
//            switch title! {
//            case "blah":
//                imageName = "blahImage"
//            default:
//                 imageName = "defaultImage"
//            }
//
//        }
//
//        return UIImage(named: imageName)!
//    }
    
    
}

// MGLAnnotation protocol reimplementation
class CustomPointAnnotation : NSObject, MGLAnnotation {
    // As a reimplementation of the MGLAnnotation protocol, we have to add mutable coordinate and (sub)title properties ourselves.
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    // Custom properties that we will use to customize the annotation's image.
    var image: UIImage?
    var reuseIdentifier: String?
    var classification: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}

//    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
//        // Always allow callouts to popup when annotations are tapped.
//        return true
//    }
//    @nonobjc func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        print ("Annotation Delegate")
//
////        if !(annotation is CustomPointAnnotation) {
////            return nil
////        }
//
//        let reuseId = "\(annotation.coordinate.longitude)"
//
//        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
//
//        if anView == nil {
//            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
//            anView?.bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
//            anView?.canShowCallout = true
//        }
//        else {
//            anView?.annotation = annotation
//        }
//
//
//        let cpa = annotation as! CustomPointAnnotation
//        anView?.image = UIImage(named:cpa.imageName)
//        anView!.bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
//        return anView
//
//
//    }
    
//}

//class CustomPointAnnotation: MKPointAnnotation {
//    var imageName: String!
//}

