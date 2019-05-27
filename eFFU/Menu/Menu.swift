//
//  Menu.swift
//  eFFUNOV5
//
//  Created by Thierry Danthez on 28/11/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import MapKit
import Mapbox


extension ViewController {
    
    /* Begin Of Function ******************************************************
     *    Menu Accueil principal                    *
     ************************************************/
    
    func menuAccueil(visible: Bool) {
        
        print("Page Accueil")
        
        let viewLayer = 190
        
        let viewWithTag = self.view.viewWithTag(viewLayer)
        viewWithTag?.removeFromSuperview()
        
        if visible {
            
            let screenWidth = UIScreen.main.bounds.size.width
            let screenHeight = UIScreen.main.bounds.size.height
            
            print(screenWidth)
            print(screenHeight)
            
            let backgroundScreen = UIImageView(frame: UIScreen.main.bounds)
            
            if (screenWidth > screenHeight) {
                print("Landscape")
                backgroundScreen.image = UIImage(named: "Accueil_landscape.png")
            } else {
                print("Portrait")
                backgroundScreen.image = UIImage(named: "Accueil_portrait.png")
            }
            
            backgroundScreen.contentMode = .center
            backgroundScreen.contentMode = .scaleToFill
            backgroundScreen.clipsToBounds = false
            backgroundScreen.translatesAutoresizingMaskIntoConstraints = true
            
            backgroundScreen.tag = viewLayer
            backgroundScreen.isUserInteractionEnabled = true
            
            //let tailleIcone: CGFloat = 140 * (((screenHeight * 100) / 768) / 100 )
            let tailleIcone: CGFloat = 160
            
            // Bouton Vol
            let button1  = UIButton(type: .custom)
            button1.setImage(UIImage(named: "vol.png"), for: .normal)
            button1.frame = CGRect(x: ((screenWidth / 2) - (tailleIcone / 2)), y: ((screenHeight / 2)  - (tailleIcone / 2)), width: tailleIcone, height: tailleIcone)
            button1.addTarget(self, action: #selector(buttonVolAction), for: .touchUpInside)
            
            backgroundScreen.addSubview(button1)
            
            // Bouton Planification
            let button2  = UIButton(type: .custom)
            button2.setImage(UIImage(named: "planification.png"), for: .normal)
            button2.frame = CGRect(x: (screenWidth / 4) - (tailleIcone/2), y: (screenHeight / 2)  - (tailleIcone/2), width: tailleIcone, height: tailleIcone)
            button2.addTarget(self, action: #selector(buttonPlanificationAction), for: .touchUpInside)
            
            backgroundScreen.addSubview(button2)
            
            // Bouton Archives
            let button3  = UIButton(type: .custom)
            button3.setImage(UIImage(named: "archives.png"), for: .normal)
            button3.frame = CGRect(x: (screenWidth / 4) + (screenWidth / 2) - (tailleIcone/2), y: (screenHeight / 2)  - (tailleIcone/2), width: tailleIcone, height: tailleIcone)
            button3.addTarget(self, action: #selector(buttonArchivesAction), for: .touchUpInside)
            
            backgroundScreen.addSubview(button3)
            
            view.insertSubview(backgroundScreen, at: viewLayer)
            
        } else {
            
            print("Affichage carte")
            
            //mapBox()

            //navigationBarMenu(visible: false)

            //menuOptionMapView(visible: true)

            //addMenuPrincipal(visible: false)
            
        }
        
        
    }
    /* End Of Function ******************************************************/
    
    /* Begin Of Function ******************************************************
     *    Navigation Bar                            *
     ************************************************/
    
    func navigationBarMenu(visible: Bool) {
        
    let viewLayer = 180
        
    let viewWithTag = self.view.viewWithTag(viewLayer)
    viewWithTag?.removeFromSuperview()
        
    if visible {
        
    //Status Background
    let statusMenuBackground = UIView()
    statusMenuBackground.frame = CGRect(x: 0, y:  0, width: UIScreen.main.bounds.size.width, height: -20)
    statusMenuBackground.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        
    //Navigation Bar
    let navigationMenuBar = UIView()
    navigationMenuBar.frame = CGRect(x: 0, y:  20, width: UIScreen.main.bounds.size.width, height: 44)
    navigationMenuBar.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.8)
    navigationMenuBar.tag = viewLayer
    navigationMenuBar.isUserInteractionEnabled = true
        
    navigationMenuBar.addSubview(statusMenuBackground)
        
    // Insertion Menu
    let titre = UIButton(type: .custom)
    titre.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44)
    titre.setTitleColor(UIColor.white, for: .normal)
    titre.titleLabel?.font = UIFont(name: "SF UI Display Ultralight", size: 30)
    titre.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
    titre.setTitle("Planification", for: .normal)
    navigationMenuBar.addSubview(titre)
        
    //Menu Principal
    let iconeMenuPrincipal  = UIButton(type: .custom)
    if applicationParametres.visibleMenuPrincipal {
            iconeMenuPrincipal.setImage(UIImage(named: "navbarIconMenuActive.png"), for: .normal)
        
    } else {
            iconeMenuPrincipal.setImage(UIImage(named: "icon_hamburger_round.png"), for: .normal)
    }
    
    iconeMenuPrincipal.frame = CGRect(x: 14, y: 2, width: 40, height: 40)
    iconeMenuPrincipal.addTarget(self, action: #selector(actionOpenMenuPrincipalView), for: .touchUpInside)
    iconeMenuPrincipal.tag = 101
    navigationMenuBar.addSubview(iconeMenuPrincipal)
    
    //Menu Options Map View
    let optionMapViewPlan  = UIButton(type: .custom)
    if applicationParametres.visibleMenuOptionMapView {
            optionMapViewPlan.setImage(UIImage(named: "navbarIconMapMenuActive.png"), for: .normal)
    } else {
            optionMapViewPlan.setImage(UIImage(named: "icon_layers_round.png"), for: .normal)
    }

    optionMapViewPlan.frame = CGRect(x: UIScreen.main.bounds.size.width - 120, y: 2, width: 40, height: 40)
    optionMapViewPlan.addTarget(self, action: #selector(actionOpenMenuOptionMapView), for: .touchUpInside)
    optionMapViewPlan.tag = 102
    navigationMenuBar.addSubview(optionMapViewPlan)
        
    //Menu Vue Plan de Vol ClipBoard
    let iconePlanVol  = UIButton(type: .custom)
    if applicationParametres.visibleClipBoardMapView {
        iconePlanVol.setImage(UIImage(named: "navbarIconClipboardActive.png"), for: .normal)
    } else {
        iconePlanVol.setImage(UIImage(named: "icon_clipboard_round.png"), for: .normal)
    }
    
    iconePlanVol.frame = CGRect(x: UIScreen.main.bounds.size.width - 60, y: 2, width: 40, height: 40)
    iconePlanVol.addTarget(self, action: #selector(actionOpenMenuClipBoardView), for: .touchUpInside)
    iconePlanVol.tag = 103
    iconePlanVol.alpha = 1.0
    navigationMenuBar.addSubview(iconePlanVol)
        
    //Refresh Maps
    let iconeRefreshMaps  = UIButton(type: .custom)

    iconeRefreshMaps.setImage(UIImage(named: "emblemsynchronizing_93485"), for: .normal)
        
    iconeRefreshMaps.frame = CGRect(x: UIScreen.main.bounds.size.width - 180, y: -1, width: 45, height: 45)
    iconeRefreshMaps.addTarget(self, action: #selector(resetLocalisation), for: .touchUpInside)
    //iconeRefreshMaps.addTarget(self, action: #selector(updateMap), for: .touchUpInside)
    iconeRefreshMaps.tag = 104
    iconeRefreshMaps.alpha = 1.0
    navigationMenuBar.addSubview(iconeRefreshMaps)

    self.view.insertSubview(navigationMenuBar, at: viewLayer)
        
    }
        
        
    }
    
    @objc func resetLocalisation() {
    
    localisationCenterMap = CLLocationCoordinate2D(latitude: 43.587778, longitude: 1.498611)
    zoomLevelMap = 11
    directionMap = 0
    affichageFondCartesMapbox()
        
    }

    /* End Of Function ******************************************************/
    
    
    /* Begin Of Function ******************************************************
     *    Menu principal Right                      *
     ************************************************/
    
    func addMenuPrincipal(visible: Bool) {
        print ("Menu Principal")
        //reLoadLayerMenu()
        if visible {
           
        }
        
        let viewLayer = 170
        
        let viewWithTag = self.view.viewWithTag(viewLayer)
        viewWithTag?.removeFromSuperview()
        
        //Menu Principal
        let statusBarHeight: Int = Int(UIApplication.shared.statusBarFrame.height)
        let navigationBarHeight = 44
        
        let screenWidth = Int(UIScreen.main.bounds.size.width)
        let screenHeight = Int(UIScreen.main.bounds.size.height)
       
        var menuLandscapeWidth: Int
        var positionmenuLandscapeWidth: Int
        
        if (screenWidth > screenHeight) {
                    //print("landscape Appdelegate a")
                        menuLandscapeWidth = 250
                        positionmenuLandscapeWidth = -250
            if (!visible) {
                        positionmenuLandscapeWidth = applicationParametres.paddingBorder
                
            }
                    
        } else {
                    //print("portrait AppDelegate a")
                        menuLandscapeWidth = 60
                        positionmenuLandscapeWidth = -60
                    if (!visible) {
                        positionmenuLandscapeWidth = applicationParametres.paddingBorder
                        
            }

        }
        //print (positionmenuLandscapeWidth)
        //print(menuLandscapeWidth)
        
        let container = UIView()
        container.frame = CGRect(x: -applicationParametres.paddingBorder-menuLandscapeWidth, y: (statusBarHeight + navigationBarHeight + applicationParametres.paddingBorder), width: menuLandscapeWidth, height: Int(UIScreen.main.bounds.size.height) - statusBarHeight - navigationBarHeight - (applicationParametres.paddingBorder * 2))
        container.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0.8)
        //container.alpha = 1.0
        container.tag = viewLayer
        container.layer.cornerRadius = CGFloat(applicationParametres.borderCornerRadius)
        //container.isUserInteractionEnabled = true
        
        if visible {
        
        let textColor = UIColor.black
        let textFont = UIFont(name: "SF UI Display Ultralight", size: 30)
        var indexMenu = 60
        
        if (screenWidth > screenHeight) {
        // Insertion Menu
        let titre = UIButton(type: .custom)
        titre.frame = CGRect(x: 0, y: 0, width: menuLandscapeWidth, height: 60)
        titre.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0.6)
        titre.layer.cornerRadius = CGFloat(applicationParametres.borderCornerRadius)
        titre.setTitleColor(textColor, for: .normal)
        titre.titleLabel?.font = textFont
        titre.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
        titre.setTitle("Menu", for: .normal)
        container.addSubview(titre)
        }
        let nombreSubMenu = arrayMenuOptions.count
        
        for i in 0..<nombreSubMenu {
            
            let titreMenu = arrayMenuOptions[i]["title"]!
            let iconMenu = arrayMenuOptions[i]["icon"]!
            //let targetMenu = arrayMenuOptions[i]["target"]!
            
            /****************************
             *  Construction zones Menu *
             ****************************/
            
            //Construction view
            let choixMenu: UIButton = UIButton()
            choixMenu.frame = CGRect(x: 0, y: indexMenu, width: menuLandscapeWidth, height: 88)
            choixMenu.backgroundColor = UIColor.clear
            //Ligne separator
            let lineViewUp = UIView(frame: CGRect(x: 0, y: 0, width: menuLandscapeWidth, height: Int(1.0)))
            lineViewUp.layer.borderWidth = 1.0
            lineViewUp.layer.borderColor = UIColor.black.cgColor
            choixMenu.addSubview(lineViewUp)
            let lineViewDown = UIView(frame: CGRect(x: 0, y: 88, width: menuLandscapeWidth, height: Int(1.0)))
            lineViewDown.layer.borderWidth = 1.0
            lineViewDown.layer.borderColor = UIColor.black.cgColor
            choixMenu.addSubview(lineViewDown)
            let zoneActive = UIButton(type: .custom)
            zoneActive.frame = CGRect(x: 2, y: 2, width: menuLandscapeWidth-4, height: 84)
            zoneActive.backgroundColor = UIColor.clear
            //zoneActive.alpha = 1.0
            zoneActive.tag = 10000 + i
            choixMenu.addSubview(zoneActive)
            // Insertion Logo choix
            let menu  = UIButton(type: .custom)
            menu.setImage(UIImage(named: iconMenu), for: .normal)
            menu.frame = CGRect(x: 5, y: 24, width: 50, height: 50)
            choixMenu.addSubview(menu)
            if (screenWidth > screenHeight) {
            // Insertion Texte
            let titre = UIButton(type: .custom)
            titre.frame = CGRect(x: 55, y: 19, width: menuLandscapeWidth - 95 , height: 60)
            //titre.backgroundColor = .white
            titre.setTitleColor(textColor, for: .normal)
            titre.titleLabel?.font = textFont
            titre.titleLabel?.font = titre.titleLabel?.font.withSize(24)
            titre.contentHorizontalAlignment = .left
            titre.setTitle(titreMenu, for: .normal)
            choixMenu.addSubview(titre)
            if i < 6 {
            // Insertion > choix
            let back  = UIButton(type: .custom)
            back.setImage(UIImage(named: "_ionicons_svg_ios-arrow-forward.png"), for: .normal)
            back.frame = CGRect(x: menuLandscapeWidth - 45, y: 19, width: 50, height: 50)
            choixMenu.addSubview(back)
            }
            }
            //Zone Tactile
            let zoneTactile: UIButton = UIButton()
            zoneTactile.frame = CGRect(x: 0, y: 0, width: menuLandscapeWidth, height: 88)
            zoneTactile.backgroundColor = UIColor.clear
            zoneTactile.tag = i
            zoneTactile.addTarget(self, action: #selector(buttonMenuAction), for: .touchUpInside)
            choixMenu.addSubview(zoneTactile)
            
            container.addSubview(choixMenu)
            
            indexMenu = indexMenu + 88
            
        }
            
        self.view.insertSubview(container, at: viewLayer)
        
        UIView.animate(withDuration: 0.5) {
        container.frame = CGRect(x: applicationParametres.paddingBorder, y: (statusBarHeight + navigationBarHeight + applicationParametres.paddingBorder), width: menuLandscapeWidth, height: Int(UIScreen.main.bounds.size.height) - statusBarHeight - navigationBarHeight - (applicationParametres.paddingBorder * 2))
        
        }
            
        }
        
       reLoadLayerMenu()
        
    }
    
    /* End Of Function ******************************************************/
    
    /* Begin Of Function ******************************************************
     *    Menu Option Map View  Left                *
     ************************************************/
    
    func menuOptionMapView(visible: Bool) {
        
    let viewLayer = 160
     
    let viewWithTag = self.view.viewWithTag(viewLayer)
        
        var closeLayer: Bool = false
        if viewWithTag?.frame.height != 0.0 && viewWithTag != nil
        {
            //print ("Erase \(viewWithTag?.frame.height) ")
             closeLayer = true
        }
        
    viewWithTag?.removeFromSuperview()

    let screenWidth: Int = Int(UIScreen.main.bounds.size.width)
    let screenHeight: Int = Int(UIScreen.main.bounds.size.height)
    
        let positionmenuLandscapeWidth = screenWidth
    if (!visible) {
        let positionmenuLandscapeWidth = screenWidth - 415
        
    }
    

        if closeLayer {
            print ("Menu Ouvert")
        } else {
            print ("Menu Ferme")
        }
        
    let zoneMenuRight = UIView()
    zoneMenuRight.frame = CGRect(x: positionmenuLandscapeWidth, y: screenHeight - 335, width: 410, height: 330)
    zoneMenuRight.backgroundColor = UIColor.clear
    zoneMenuRight.tag = viewLayer
    zoneMenuRight.isUserInteractionEnabled = true
        
    if visible {
    
    var i = 0
    
    var y = 10
    
    for _ in 1..<5 {
    
    var x = 10
    
    for _ in 1..<6 {
    
    let titreMenu = arrayMapViewOptions[i]["title"]!
    let iconOn = arrayMapViewOptions[i]["iconOn"]!
    let iconOff  = arrayMapViewOptions[i]["iconOff"]!
    //let targetMenu = arrayMapViewOptions[i]["target"]!
    
    //Menu Bouton Right 1
    let zoneButton1 = UIView()
    zoneButton1.frame = CGRect(x: x, y:  y, width: 71, height: 71)
    zoneButton1.backgroundColor = UIColor.clear
    zoneButton1.layer.cornerRadius = 0.5 * zoneButton1.bounds.size.width

    //zoneButton1.backgroundColor = .red
    //zoneButton1.layer.borderWidth = 3
    zoneButton1.layer.borderColor = UIColor.clear.cgColor
    //zoneButton1.layer.cornerRadius = 10
    let button1 = UIButton(type: .custom)
    button1.frame = CGRect(x: 1, y:  1, width: 70, height: 70)
    
    if applicationParametres.buttonOptionMapView[i] {
        button1.setImage(UIImage(named: iconOn), for: .normal)
    } else {
        button1.setImage(UIImage(named: iconOff), for: .normal)
    }
    button1.backgroundColor = UIColor.clear
    //button1.layer.cornerRadius = 10
    button1.layer.cornerRadius = 0.5 * button1.bounds.size.width
    //button1.layer.borderWidth = 3
    //button1.layer.borderColor = UIColor.white.cgColor
    //button.setTitle("Hi!", for: .normal)
    zoneButton1.addSubview(button1)
    button1.tag = i
    button1.addTarget(self, action: #selector(buttonMenuMapOptionAction), for: .touchUpInside)
    zoneMenuRight.addSubview(zoneButton1)
    
    x = x + 80
    
    i = i + 1
    
    }
    y = y + 80
    }
    
    self.view.insertSubview(zoneMenuRight, at: viewLayer)
        
    if closeLayer {
        
        zoneMenuRight.frame = CGRect(x: screenWidth - 415, y: screenHeight - 335, width: 410, height: 330)
    } else {
        
        
        UIView.animate(withDuration: 0.5) {
            zoneMenuRight.frame = CGRect(x: screenWidth - 415, y: screenHeight - 335, width: 410, height: 330)
        }
        
    }
    
    }
    
}
    /* End Of Function ******************************************************/
    
    /* Begin Of Function ******************************************************
     *    Splashscreen initialisation               *
     ************************************************/
    
    func splashScreen(visible: Bool) {
        
        let viewLayer = 250
        
        print("Page splashScreen")
        
        applicationParametres.screenActive = "splashScreen"
        
        let viewWithTag = self.view.viewWithTag(viewLayer)
        viewWithTag?.removeFromSuperview()
        
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        let splashScreen = UIImageView(frame: UIScreen.main.bounds)
        
        if (screenWidth > screenHeight) {
            print("Landscape")
            splashScreen.image = UIImage(named: "SplashscreenLandscape.png")
        } else {
            print("Portrait")
            splashScreen.image = UIImage(named: "SplashscreenPortrait.png")
        }
        
        splashScreen.contentMode = .center
        splashScreen.contentMode = .scaleToFill
        splashScreen.clipsToBounds = false
        splashScreen.translatesAutoresizingMaskIntoConstraints = true
        
        splashScreen.tag = viewLayer
        
        if visible {
            
            self.view.insertSubview(splashScreen, at: viewLayer)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
                self.splashScreen(visible: false)
            })
        }
        else {
            
            UIView.transition(with: view, duration: 1.0, options: .transitionCrossDissolve, animations: {
                let viewWithTag = self.view.viewWithTag(viewLayer)
                viewWithTag?.removeFromSuperview()
            })
            
            applicationParametres.screenActive = "accueilScreen"
            
        }
        
    }
    
    /* Begin Of Function ******************************************************
     *    Clipboard Panel Plan de vol               *
     ************************************************/
    
    func clipBoardPanel(visible: Bool) {
        
        print("Panel Clipboard \(visible) ")
        
        let viewLayer = 150
        
        let viewWithTag = self.view.viewWithTag(viewLayer)
        viewWithTag?.removeFromSuperview()
        
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        let menuLandscapeWidth: Int
        if (screenWidth > screenHeight) {
            
            menuLandscapeWidth = Int(screenWidth) - 768
            
        } else {
            
            menuLandscapeWidth = applicationParametres.paddingBorder
            
        }
        //print (" Largeur menu \(menuLandscapeWidth) ")
        
        let positionmenuLandscapeWidth = Int(screenWidth)
        if (!visible) {
            let positionmenuLandscapeWidth = Int(screenWidth) - menuLandscapeWidth
            
        }
        
        print (" \(positionmenuLandscapeWidth) ")
        
        let panelContainer = UIView()
        panelContainer.frame = CGRect(x: Int(positionmenuLandscapeWidth) + applicationParametres.paddingBorder, y: 64 + applicationParametres.paddingBorder, width: 760, height: 1040)
        panelContainer.layer.cornerRadius = CGFloat(applicationParametres.borderCornerRadius)
        panelContainer.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        panelContainer.tag = viewLayer
        
        panelContainer.isUserInteractionEnabled = true
        
        if visible {
            // Liste pour afficher les données
            dataListFlightPlan = []
            iconesDataFlightPlan = []
            
            if departureOn {
                dataListFlightPlan.append(["\(flight_Plan.get_Departure_Airfield_aiIcao()) (\(flight_Plan.get_Departure_Airfield_Name()))"])
                iconesDataFlightPlan.append("departures_map")
            }
            if wayPointOn {
                var keyNoNil: Int = 0
                for _ in 1...wayPointData.count {
                    while wayPointData[keyNoNil] == nil {
                        keyNoNil = keyNoNil + 1
                    }
                    dataListFlightPlan.append(["\(wayPointData[keyNoNil]!.aiName)"])
                    iconesDataFlightPlan.append("\(wayPointData[keyNoNil]!.icon)")
                    keyNoNil = keyNoNil + 1
                }
            }
            if arrivalOn {
                dataListFlightPlan.append(["\(flight_Plan.get_Arrival_Airfield_aiIcao()) (\(flight_Plan.get_Arrival_Airfield_Name()))"])
                iconesDataFlightPlan.append("arrivals_map")
            }
            
            // Insertion Texte
            let titre = UIButton(type: .custom)
            titre.frame = CGRect(x: 0, y: 0, width: 760, height: 60)
            titre.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0.8)
            titre.layer.cornerRadius = CGFloat(applicationParametres.borderCornerRadius)
            titre.setTitleColor(UIColor.black, for: .normal)
            titre.titleLabel?.font = UIFont(name: "SF UI Display Ultralight", size: 30)
            titre.titleLabel?.font = titre.titleLabel?.font.withSize(24)
            titre.contentHorizontalAlignment = .center
            titre.setTitle("Plan de Vol", for: .normal)
            
            panelContainer.addSubview(titre)
            
            //Ligne separator
            let lineViewUp = UIView(frame: CGRect(x: 0, y: 60, width: 760, height: Int(1.0)))
            lineViewUp.layer.borderWidth = 1.0
            lineViewUp.layer.borderColor = UIColor.black.cgColor
            panelContainer.addSubview(lineViewUp)
            
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            
            tableViewFlightPlan.reloadData()
            tableViewFlightPlan = UITableView(frame: panelContainer.frame, style: UITableView.Style.plain)
            tableViewFlightPlan.dataSource = self
            tableViewFlightPlan.delegate = self
            tableViewFlightPlan.backgroundColor = UIColor.white
            tableViewFlightPlan.rowHeight = UITableView.automaticDimension
            tableViewFlightPlan.estimatedRowHeight = 150
            
            tableViewFlightPlan.register(UITableViewCell.self, forCellReuseIdentifier: "my")
            
            //tableViewFlightPlan.contentInset.top = 5
            
            tableViewFlightPlan.frame = CGRect(x: 0, y: 61, width: 760, height: 980)
            
            tableViewFlightPlan.backgroundColor = UIColor.white
            let contentSize = self.tableViewFlightPlan.contentSize
            let footer = UIView(frame: CGRect(x: self.tableViewFlightPlan.frame.origin.x,
                                              y: self.tableViewFlightPlan.frame.origin.y + contentSize.height,
                                              width: self.tableViewFlightPlan.frame.size.width,
                                              height: self.tableViewFlightPlan.frame.height - self.tableViewFlightPlan.contentSize.height))
            
            self.tableViewFlightPlan.tableFooterView = footer
            
            
            panelContainer.addSubview(tableViewFlightPlan)
            
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            
            self.view.insertSubview(panelContainer, at: viewLayer)
            
            UIView.animate(withDuration: 0.5) {
                panelContainer.frame = CGRect(x: menuLandscapeWidth, y: 64 + applicationParametres.paddingBorder, width: 760, height: 1040)
            }
            
        }
        
    }
    
    /* End Of Function ******************************************************/
    
    /* Begin Of Function ******************************************************
     *     Plan de vol                              *
     ************************************************/
    
    func processPlanDeVol(visible: Bool) {
        
        print("Panel Clipboard \(visible) ")
        
        let viewLayer = 140
        
        let screenWidth = Int(UIScreen.main.bounds.size.width)
        let screenHeight = Int(UIScreen.main.bounds.size.height)
        
        var menuLandscapeWidth: Int
        var positionmenuLandscapeWidth: Int

        let viewWithTag = self.view.viewWithTag(viewLayer)

        var closeLayer: Bool = false
        if viewWithTag?.frame.height != 0.0 && viewWithTag != nil
        {
            
            closeLayer = true
        }
        
        if (screenWidth > screenHeight) {
            //print("landscape")
            menuLandscapeWidth = 258
            positionmenuLandscapeWidth = 258
            if (!visible) {
                positionmenuLandscapeWidth = -screenWidth
            }
            
        } else {
            //print("portrait")
            menuLandscapeWidth = 68
            positionmenuLandscapeWidth = 68
            if (!visible) {
                positionmenuLandscapeWidth = -screenWidth
            }
            
        }
        //print (positionmenuLandscapeWidth)
        //print(menuLandscapeWidth)
        
        let panelContainer = UIView()
        
        panelContainer.frame = CGRect(x: -screenWidth, y: 64 + applicationParametres.paddingBorder, width: screenWidth - menuLandscapeWidth - (applicationParametres.paddingBorder * 2), height: Int(UIScreen.main.bounds.size.height) - 64 - (applicationParametres.paddingBorder * 2))

        panelContainer.backgroundColor = UIColor.white
        panelContainer.layer.cornerRadius = CGFloat(applicationParametres.borderCornerRadius)
        panelContainer.tag = viewLayer
        panelContainer.isUserInteractionEnabled = true
        
        if visible {
            
            let viewWithTag = self.view.viewWithTag(10000)
            viewWithTag?.alpha = 1.0
            viewWithTag?.backgroundColor = UIColor.white
            
            // Insertion Texte
            let titre = UIButton(type: .custom)
            titre.frame = CGRect(x: 0, y: 0, width: screenWidth - menuLandscapeWidth - (applicationParametres.paddingBorder * 2) , height: 60)
            titre.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0.8)
            titre.layer.cornerRadius = CGFloat(applicationParametres.borderCornerRadius)
            titre.setTitleColor(UIColor.black, for: .normal)
            titre.titleLabel?.font = UIFont(name: "SF UI Display Ultralight", size: 30)
            titre.titleLabel?.font = titre.titleLabel?.font.withSize(24)
            titre.contentHorizontalAlignment = .center
            titre.setTitle("Plans de Vol", for: .normal)
            
            panelContainer.addSubview(titre)
            
            //Ligne separator
            let lineViewUp = UIView(frame: CGRect(x: 0, y: 60, width: screenWidth - menuLandscapeWidth - (applicationParametres.paddingBorder * 2), height: Int(1.0)))
            lineViewUp.layer.borderWidth = 1.0
            lineViewUp.layer.borderColor = UIColor.black.cgColor
            panelContainer.addSubview(lineViewUp)
            
            let imageMaquette  = UIButton(type: .custom)
            imageMaquette.setImage(UIImage(named: "maquettePlansDeVol.png"), for: .normal)
            imageMaquette.frame = CGRect(x: ((screenWidth - menuLandscapeWidth - (applicationParametres.paddingBorder * 2))-670) / 2, y: 74, width: 670, height: 516)
            
            panelContainer.addSubview(imageMaquette)
            
            
            self.view.insertSubview(panelContainer, at: viewLayer)
            
            UIView.animate(withDuration: 0.5) {
                panelContainer.frame = CGRect(x: positionmenuLandscapeWidth + applicationParametres.paddingBorder, y: 64 + applicationParametres.paddingBorder, width: screenWidth - menuLandscapeWidth - (applicationParametres.paddingBorder * 2), height: Int(UIScreen.main.bounds.size.height) - 64 - (applicationParametres.paddingBorder * 2))
            }
        }

    }
    
    /* End Of Function ******************************************************/
    
    /* Begin Of Function ******************************************************
     *     Cartes VAC                               *
     ************************************************/
    
    func processCartesVACMenu(visible: Bool) {
        
        print("Panel Cartes VAC \(visible) ")
        
        let viewLayer = 140
        
        let screenWidth = Int(UIScreen.main.bounds.size.width)
        let screenHeight = Int(UIScreen.main.bounds.size.height)
        
        var menuLandscapeWidth: Int
        var positionmenuLandscapeWidth: Int
        
        let viewWithTag = self.view.viewWithTag(viewLayer)
        
        var closeLayer: Bool = false
        if viewWithTag?.frame.height != 0.0 && viewWithTag != nil
        {
            
            closeLayer = true
        }
        
        if (screenWidth > screenHeight) {
            //print("landscape")
            menuLandscapeWidth = 258
            positionmenuLandscapeWidth = 258
            if (!visible) {
                positionmenuLandscapeWidth = -screenWidth
            }
            
        } else {
            //print("portrait")
            menuLandscapeWidth = 68
            positionmenuLandscapeWidth = 68
            if (!visible) {
                positionmenuLandscapeWidth = -screenWidth
            }
            
        }
        //print (positionmenuLandscapeWidth)
        //print(menuLandscapeWidth)
        
        let panelContainer = UIView()
        
        panelContainer.frame = CGRect(x: -screenWidth, y: 64 + applicationParametres.paddingBorder, width: screenWidth - menuLandscapeWidth - (applicationParametres.paddingBorder * 2), height: 1250)
        
        panelContainer.backgroundColor = UIColor.white
        panelContainer.layer.cornerRadius = CGFloat(applicationParametres.borderCornerRadius)
        panelContainer.tag = viewLayer
        panelContainer.isUserInteractionEnabled = true
        
        if visible {
            
            let viewWithTag = self.view.viewWithTag(10001)
            viewWithTag?.alpha = 1.0
            viewWithTag?.backgroundColor = UIColor.white
            
            // Insertion Texte
            let titre = UIButton(type: .custom)
            titre.frame = CGRect(x: 0, y: 0, width: screenWidth - menuLandscapeWidth - (applicationParametres.paddingBorder * 2) , height: 60)
            titre.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0.8)
            titre.layer.cornerRadius = CGFloat(applicationParametres.borderCornerRadius)
            titre.setTitleColor(UIColor.black, for: .normal)
            titre.titleLabel?.font = UIFont(name: "SF UI Display Ultralight", size: 30)
            titre.titleLabel?.font = titre.titleLabel?.font.withSize(24)
            titre.contentHorizontalAlignment = .center
            titre.setTitle("Cartes VAC", for: .normal)
            
            panelContainer.addSubview(titre)
            
            //Ligne separator
            let lineViewUp = UIView(frame: CGRect(x: 0, y: 60, width: screenWidth - menuLandscapeWidth - (applicationParametres.paddingBorder * 2), height: Int(1.0)))
            lineViewUp.layer.borderWidth = 1.0
            lineViewUp.layer.borderColor = UIColor.black.cgColor
            panelContainer.addSubview(lineViewUp)
            
            let imageMaquette  = UIButton(type: .custom)
            imageMaquette.setImage(UIImage(named: "maquetteCartesVACA.png"), for: .normal)
            imageMaquette.frame = CGRect(x: ((screenWidth - menuLandscapeWidth - (applicationParametres.paddingBorder * 2))-670) / 2, y: 74, width: 670, height: 747)
            imageMaquette.isUserInteractionEnabled = false
            imageMaquette.translatesAutoresizingMaskIntoConstraints = true
            panelContainer.addSubview(imageMaquette)
            
            let imageMaquette1  = UIButton(type: .custom)
            imageMaquette1.setImage(UIImage(named: "maquetteCartesVACB.png"), for: .normal)
            imageMaquette1.frame = CGRect(x: ((screenWidth - menuLandscapeWidth - (applicationParametres.paddingBorder * 2))-670) / 2, y: 833, width: 443, height: 368)
            
            panelContainer.addSubview(imageMaquette1)
            
            
            self.view.insertSubview(panelContainer, at: viewLayer)
            
            UIView.animate(withDuration: 0.5) {
                panelContainer.frame = CGRect(x: positionmenuLandscapeWidth + applicationParametres.paddingBorder, y: 64 + applicationParametres.paddingBorder, width: screenWidth - menuLandscapeWidth - (applicationParametres.paddingBorder * 2), height: 1250)
            }
            
        }

    }
    
    /* End Of Function ******************************************************/
    
    /* Begin Of Function ******************************************************
     *     eBibliotheque                               *
     ************************************************/
    
    func processEBibliothequeMenu(visible: Bool) {
        
        print("Panel eBibliotheque \(visible) ")
        
        let viewLayer = 140
        
        let screenWidth = Int(UIScreen.main.bounds.size.width)
        let screenHeight = Int(UIScreen.main.bounds.size.height)
        
        var menuLandscapeWidth: Int
        var positionmenuLandscapeWidth: Int
        
        let viewWithTag = self.view.viewWithTag(viewLayer)
        
        var closeLayer: Bool = false
        if viewWithTag?.frame.height != 0.0 && viewWithTag != nil
        {
            
            closeLayer = true
        }
        
        if (screenWidth > screenHeight) {
            //print("landscape")
            menuLandscapeWidth = 258
            positionmenuLandscapeWidth = 258
            if (!visible) {
                positionmenuLandscapeWidth = -screenWidth
            }
            
        } else {
            //print("portrait")
            menuLandscapeWidth = 68
            positionmenuLandscapeWidth = 68
            if (!visible) {
                positionmenuLandscapeWidth = -screenWidth
            }
            
        }
        //print (positionmenuLandscapeWidth)
        //print(menuLandscapeWidth)
        
        let panelContainer = UIView()
        
        panelContainer.frame = CGRect(x: -screenWidth, y: 64 + applicationParametres.paddingBorder, width: screenWidth - menuLandscapeWidth - (applicationParametres.paddingBorder * 2), height: Int(UIScreen.main.bounds.size.height) - 64 - (applicationParametres.paddingBorder * 2))
        
        panelContainer.backgroundColor = UIColor.white
        panelContainer.layer.cornerRadius = CGFloat(applicationParametres.borderCornerRadius)
        panelContainer.tag = viewLayer
        panelContainer.isUserInteractionEnabled = true
        
        if visible {
            
            let viewWithTag = self.view.viewWithTag(10002)
            viewWithTag?.alpha = 1.0
            viewWithTag?.backgroundColor = UIColor.white
            
            // Insertion Texte
            let titre = UIButton(type: .custom)
            titre.frame = CGRect(x: 0, y: 0, width: screenWidth - menuLandscapeWidth - (applicationParametres.paddingBorder * 2) , height: 60)
            titre.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0.8)
            titre.layer.cornerRadius = CGFloat(applicationParametres.borderCornerRadius)
            titre.setTitleColor(UIColor.black, for: .normal)
            titre.titleLabel?.font = UIFont(name: "SF UI Display Ultralight", size: 30)
            titre.titleLabel?.font = titre.titleLabel?.font.withSize(24)
            titre.contentHorizontalAlignment = .center
            titre.setTitle("e-Bibliothèque", for: .normal)
            
            panelContainer.addSubview(titre)
            
            //Ligne separator
            let lineViewUp = UIView(frame: CGRect(x: 0, y: 60, width: screenWidth - menuLandscapeWidth - (applicationParametres.paddingBorder * 2), height: Int(1.0)))
            lineViewUp.layer.borderWidth = 1.0
            lineViewUp.layer.borderColor = UIColor.black.cgColor
            panelContainer.addSubview(lineViewUp)
            
            let imageMaquette  = UIButton(type: .custom)
            imageMaquette.setImage(UIImage(named: "eBibliotheque.png"), for: .normal)
            imageMaquette.frame = CGRect(x: ((screenWidth - menuLandscapeWidth - (applicationParametres.paddingBorder * 2))-670) / 2, y: 74, width: 670, height: 599)
            
            panelContainer.addSubview(imageMaquette)
            
            self.view.insertSubview(panelContainer, at: viewLayer)
            
            UIView.animate(withDuration: 0.5) {
                panelContainer.frame = CGRect(x: positionmenuLandscapeWidth + applicationParametres.paddingBorder, y: 64 + applicationParametres.paddingBorder, width: screenWidth - menuLandscapeWidth - (applicationParametres.paddingBorder * 2), height: Int(UIScreen.main.bounds.size.height) - 64 - (applicationParametres.paddingBorder * 2))
            }
            
        }

    }
    
    /* End Of Function ******************************************************/
    
    /* Begin Of Function ******************************************************
     *     Aeronefs                                 *
     ************************************************/
    
    func processAeronefsMenu(visible: Bool) {
        
        print("Panel Aeronefs \(visible) ")
        
        let viewLayer = 140
        
        let screenWidth = Int(UIScreen.main.bounds.size.width)
        let screenHeight = Int(UIScreen.main.bounds.size.height)
        
        var menuLandscapeWidth: Int
        var positionmenuLandscapeWidth: Int
        
        let viewWithTag = self.view.viewWithTag(viewLayer)
        
        var closeLayer: Bool = false
        if viewWithTag?.frame.height != 0.0 && viewWithTag != nil
        {
            
            closeLayer = true
        }
        
        if (screenWidth > screenHeight) {
            //print("landscape")
            menuLandscapeWidth = 258
            positionmenuLandscapeWidth = 258
            if (!visible) {
                positionmenuLandscapeWidth = -screenWidth
            }
            
        } else {
            //print("portrait")
            menuLandscapeWidth = 68
            positionmenuLandscapeWidth = 68
            if (!visible) {
                positionmenuLandscapeWidth = -screenWidth
            }
            
        }
        //print (positionmenuLandscapeWidth)
        //print(menuLandscapeWidth)
        
        let panelContainer = UIView()
        
        panelContainer.frame = CGRect(x: -screenWidth, y: 64 + applicationParametres.paddingBorder, width: screenWidth - menuLandscapeWidth - (applicationParametres.paddingBorder * 2), height: Int(UIScreen.main.bounds.size.height) - 64 - (applicationParametres.paddingBorder * 2))
        
        panelContainer.backgroundColor = UIColor.white
        panelContainer.layer.cornerRadius = CGFloat(applicationParametres.borderCornerRadius)
        panelContainer.tag = viewLayer
        panelContainer.isUserInteractionEnabled = true
        
        if visible {
            
            let viewWithTag = self.view.viewWithTag(10003)
            viewWithTag?.alpha = 1.0
            viewWithTag?.backgroundColor = UIColor.white
            
            // Insertion Texte
            let titre = UIButton(type: .custom)
            titre.frame = CGRect(x: 0, y: 0, width: screenWidth - menuLandscapeWidth - (applicationParametres.paddingBorder * 2) , height: 60)
            titre.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0.8)
            titre.layer.cornerRadius = CGFloat(applicationParametres.borderCornerRadius)
            titre.setTitleColor(UIColor.black, for: .normal)
            titre.titleLabel?.font = UIFont(name: "SF UI Display Ultralight", size: 30)
            titre.titleLabel?.font = titre.titleLabel?.font.withSize(24)
            titre.contentHorizontalAlignment = .center
            titre.setTitle("Aéronefs", for: .normal)
            
            panelContainer.addSubview(titre)
            
            //Ligne separator
            let lineViewUp = UIView(frame: CGRect(x: 0, y: 60, width: screenWidth - menuLandscapeWidth - (applicationParametres.paddingBorder * 2), height: Int(1.0)))
            lineViewUp.layer.borderWidth = 1.0
            lineViewUp.layer.borderColor = UIColor.black.cgColor
            panelContainer.addSubview(lineViewUp)
            
            let imageMaquette  = UIButton(type: .custom)
            imageMaquette.setImage(UIImage(named: "aeronefs.png"), for: .normal)
            imageMaquette.frame = CGRect(x: ((screenWidth - menuLandscapeWidth - (applicationParametres.paddingBorder * 2))-665) / 2, y: 74, width: 665, height: 574)
            
            panelContainer.addSubview(imageMaquette)
                        
            self.view.insertSubview(panelContainer, at: viewLayer)
            
            UIView.animate(withDuration: 0.5) {
                panelContainer.frame = CGRect(x: positionmenuLandscapeWidth + applicationParametres.paddingBorder, y: 64 + applicationParametres.paddingBorder, width: screenWidth - menuLandscapeWidth - (applicationParametres.paddingBorder * 2), height: Int(UIScreen.main.bounds.size.height) - 64 - (applicationParametres.paddingBorder * 2))
            }
            
        }

    }
    
    /* End Of Function ******************************************************/
    
    /* Begin Of Function ******************************************************
     *     Utilisateurs                             *
     ************************************************/
    
    func processUtilisateursMenu(visible: Bool) {
        
        print("Panel Utilisateurs \(visible) ")
        
        let viewLayer = 140
        
        let screenWidth = Int(UIScreen.main.bounds.size.width)
        let screenHeight = Int(UIScreen.main.bounds.size.height)
        
        var menuLandscapeWidth: Int
        var positionmenuLandscapeWidth: Int
        
        let viewWithTag = self.view.viewWithTag(viewLayer)
        
        var closeLayer: Bool = false
        if viewWithTag?.frame.height != 0.0 && viewWithTag != nil
        {
            
            closeLayer = true
        }
        
        if (screenWidth > screenHeight) {
            //print("landscape")
            menuLandscapeWidth = 258
            positionmenuLandscapeWidth = 258
            if (!visible) {
                positionmenuLandscapeWidth = -screenWidth
            }
            
        } else {
            //print("portrait")
            menuLandscapeWidth = 68
            positionmenuLandscapeWidth = 68
            if (!visible) {
                positionmenuLandscapeWidth = -screenWidth
            }
            
        }
        //print (positionmenuLandscapeWidth)
        //print(menuLandscapeWidth)
        
        let panelContainer = UIView()
        
        panelContainer.frame = CGRect(x: -screenWidth, y: 64 + applicationParametres.paddingBorder, width: screenWidth - menuLandscapeWidth - (applicationParametres.paddingBorder * 2), height: Int(UIScreen.main.bounds.size.height) - 64 - (applicationParametres.paddingBorder * 2))
        
        panelContainer.backgroundColor = UIColor.white
        panelContainer.layer.cornerRadius = CGFloat(applicationParametres.borderCornerRadius)
        panelContainer.tag = viewLayer
        panelContainer.isUserInteractionEnabled = true
        
        if visible {
            
            let viewWithTag = self.view.viewWithTag(10004)
            viewWithTag?.alpha = 1.0
            viewWithTag?.backgroundColor = UIColor.white
            
            // Insertion Texte
            let titre = UIButton(type: .custom)
            titre.frame = CGRect(x: 0, y: 0, width: screenWidth - menuLandscapeWidth - (applicationParametres.paddingBorder * 2) , height: 60)
            titre.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0.8)
            titre.layer.cornerRadius = CGFloat(applicationParametres.borderCornerRadius)
            titre.setTitleColor(UIColor.black, for: .normal)
            titre.titleLabel?.font = UIFont(name: "SF UI Display Ultralight", size: 30)
            titre.titleLabel?.font = titre.titleLabel?.font.withSize(24)
            titre.contentHorizontalAlignment = .center
            titre.setTitle("Utilisateurs", for: .normal)
            
            panelContainer.addSubview(titre)
            
            //Ligne separator
            let lineViewUp = UIView(frame: CGRect(x: 0, y: 60, width: screenWidth - menuLandscapeWidth - (applicationParametres.paddingBorder * 2), height: Int(1.0)))
            lineViewUp.layer.borderWidth = 1.0
            lineViewUp.layer.borderColor = UIColor.black.cgColor
            panelContainer.addSubview(lineViewUp)
            
            let imageMaquette  = UIButton(type: .custom)
            imageMaquette.setImage(UIImage(named: "utilisateurs.png"), for: .normal)
            imageMaquette.frame = CGRect(x: ((screenWidth - menuLandscapeWidth - (applicationParametres.paddingBorder * 2))-665) / 2, y: 74, width: 665, height: 521)
            
            panelContainer.addSubview(imageMaquette)
            
            self.view.insertSubview(panelContainer, at: viewLayer)
            
            UIView.animate(withDuration: 0.5) {
                panelContainer.frame = CGRect(x: positionmenuLandscapeWidth + applicationParametres.paddingBorder, y: 64 + applicationParametres.paddingBorder, width: screenWidth - menuLandscapeWidth - (applicationParametres.paddingBorder * 2), height: Int(UIScreen.main.bounds.size.height) - 64 - (applicationParametres.paddingBorder * 2))
            }
            
        }

    }
    
    /* End Of Function ******************************************************/
    
    /* Begin Of Function ******************************************************
     *     Checklists                               *
     ************************************************/
    
    func processChecklistsMenu(visible: Bool) {
        
        print("Panel Checklists \(visible) ")
        
        let viewLayer = 140
        
        let screenWidth = Int(UIScreen.main.bounds.size.width)
        let screenHeight = Int(UIScreen.main.bounds.size.height)
        
        var menuLandscapeWidth: Int
        var positionmenuLandscapeWidth: Int
        
        let viewWithTag = self.view.viewWithTag(viewLayer)
        
        var closeLayer: Bool
        if viewWithTag?.frame.height != 0.0 && viewWithTag != nil
        {
            closeLayer = true
        } else {
            closeLayer = false
            
        }
        
        if (screenWidth > screenHeight) {
            //print("landscape")
            menuLandscapeWidth = 258
            positionmenuLandscapeWidth = 258
            if (!visible) {
                positionmenuLandscapeWidth = -screenWidth
            }
            
        } else {
            //print("portrait")
            menuLandscapeWidth = 68
            positionmenuLandscapeWidth = 68
            if (!visible) {
                positionmenuLandscapeWidth = -screenWidth
            }
            
        }
        //print (positionmenuLandscapeWidth)
        //print(menuLandscapeWidth)
        
        let panelContainer = UIView()
        
        panelContainer.frame = CGRect(x: -screenWidth, y: 64 + applicationParametres.paddingBorder, width: screenWidth - menuLandscapeWidth - (applicationParametres.paddingBorder * 2), height: 1660)
        
        panelContainer.backgroundColor = UIColor.white
        panelContainer.layer.cornerRadius = CGFloat(applicationParametres.borderCornerRadius)
        panelContainer.tag = viewLayer
        panelContainer.isUserInteractionEnabled = true
        
        if visible {
            
            let viewWithTag = self.view.viewWithTag(10005)
            viewWithTag?.alpha = 1.0
            viewWithTag?.backgroundColor = UIColor.white
            
            // Insertion Texte
            let titre = UIButton(type: .custom)
            titre.frame = CGRect(x: 0, y: 0, width: screenWidth - menuLandscapeWidth - (applicationParametres.paddingBorder * 2) , height: 60)
            titre.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0.8)
            titre.layer.cornerRadius = CGFloat(applicationParametres.borderCornerRadius)
            titre.setTitleColor(UIColor.black, for: .normal)
            titre.titleLabel?.font = UIFont(name: "SF UI Display Ultralight", size: 30)
            titre.titleLabel?.font = titre.titleLabel?.font.withSize(24)
            titre.contentHorizontalAlignment = .center
            titre.setTitle("Checklists", for: .normal)
            
            panelContainer.addSubview(titre)
            
            //Ligne separator
            let lineViewUp = UIView(frame: CGRect(x: 0, y: 60, width: screenWidth - menuLandscapeWidth - (applicationParametres.paddingBorder * 2), height: Int(1.0)))
            lineViewUp.layer.borderWidth = 1.0
            lineViewUp.layer.borderColor = UIColor.black.cgColor
            panelContainer.addSubview(lineViewUp)
            
            let imageMaquette  = UIButton(type: .custom)
            imageMaquette.setImage(UIImage(named: "checklists1.png"), for: .normal)
            imageMaquette.frame = CGRect(x: ((screenWidth - menuLandscapeWidth - (applicationParametres.paddingBorder * 2))-670) / 2, y: 74, width: 670, height: 699)
            
            panelContainer.addSubview(imageMaquette)
            
            let imageMaquette1  = UIButton(type: .custom)
            imageMaquette1.setImage(UIImage(named: "checklists2.png"), for: .normal)
            imageMaquette1.frame = CGRect(x: ((screenWidth - menuLandscapeWidth - (applicationParametres.paddingBorder * 2))-670) / 2, y: 773, width: 670, height: 600)
            
            panelContainer.addSubview(imageMaquette1)
            
            let imageMaquette3  = UIButton(type: .custom)
            imageMaquette3.setImage(UIImage(named: "checklists2.png"), for: .normal)
            imageMaquette3.frame = CGRect(x: ((screenWidth - menuLandscapeWidth - (applicationParametres.paddingBorder * 2))-670) / 2, y: 1373, width: 670, height: 275)
            
            panelContainer.addSubview(imageMaquette3)
            
            
            self.view.insertSubview(panelContainer, at: viewLayer)
            
            UIView.animate(withDuration: 0.5) {
                panelContainer.frame = CGRect(x: positionmenuLandscapeWidth + applicationParametres.paddingBorder, y: 64 + applicationParametres.paddingBorder, width: screenWidth - menuLandscapeWidth - (applicationParametres.paddingBorder * 2), height: 1660)
            }
            
        }

    }
    
    /* End Of Function ******************************************************/
    
}
