//
//  Model.swift
//  eFFUNOV5
//
//  Created by Thierry Danthez on 26/11/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import UIKit

extension ViewController {
    
    /* Begin Of Function ******************************************************
     *    Bouton Planification Menu Accueil         *
     ************************************************/
    
    @objc func buttonPlanificationAction(sender: UIButton!) {
        
        print("Button planification tapped")
        
        print("Page Cartes")
        
        applicationParametres.screenActive = "mapScreen"
        
        //1 Masquer menu Accueil
        self.menuAccueil(visible: false)
        self.navigationBarMenu(visible: true)
        //2 Activer menu right
        //self.addMenuPrincipal(visible: true)
        //3 Activer menu option map
        
        //2 Afficher Cartes
        //self.mapBox()
        
    }
    /* End Of Function ******************************************************/
    
    /* Begin Of Function ******************************************************
     *    Bouton Navigation Bar                     *
     ************************************************/
    
    @objc func actionOpenMenuPrincipalView() {
        print("Appel Panel Menu Principal")

        applicationParametres.visibleMenuPrincipal = !applicationParametres.visibleMenuPrincipal
        
        if applicationParametres.visibleMenuPrincipal {
        applicationParametres.visibleMenuOptionMapView = false
        applicationParametres.visibleClipBoardMapView = false
        }
        reLoadLayerStatusBar()
    }
    /* End Of Function ******************************************************/
    
    /* Begin Of Function ******************************************************
     *    Bouton Navigation Bar                     *
     ************************************************/
    
    @objc func actionOpenMenuOptionMapView() {
        print("Appel Options Map Menu Principal")
        
        applicationParametres.visibleMenuOptionMapView = !applicationParametres.visibleMenuOptionMapView
        
        if applicationParametres.visibleMenuOptionMapView {
            applicationParametres.visibleClipBoardMapView = false
            applicationParametres.visibleMenuPrincipal = false
        }
        
       reLoadLayerStatusBar()
        
    }
    
    /* End Of Function ******************************************************/
    
    /* Begin Of Function ******************************************************
     *    Bouton Navigation Bar                     *
     ************************************************/
    
    @objc func actionOpenMenuClipBoardView() {
        print("Appel Clipboard Menu Principal")
        
        applicationParametres.visibleClipBoardMapView = !applicationParametres.visibleClipBoardMapView
        
        if applicationParametres.visibleClipBoardMapView {
            applicationParametres.visibleMenuOptionMapView = false
            applicationParametres.visibleMenuPrincipal = false
        }
        reLoadLayerStatusBar()

    }
    
    /* End Of Function ******************************************************/
    
    
    /* Begin Of Function ******************************************************
     *    Bouton Vol Menu Accueil                   *
     ************************************************/
    
    @objc func buttonVolAction(sender: UIButton!) {
        
        print("Button vol tapped")
        //self.view.backgroundColor = UIColor.yellow
        
    }
    /* End Of Function ******************************************************/
    
    /* Begin Of Function ******************************************************
     *    Bouton Archives Menu Accueil              *
     ************************************************/
    
    @objc func buttonArchivesAction(sender: UIButton!) {
        
        print("Button archives tapped")
        self.view.backgroundColor = UIColor.blue
        
    }
    
    /* End Of Function ******************************************************/
    
    /* Begin Of Function ******************************************************
     *    return value clicked on Menu Principal    *
     ************************************************/
    
    @objc func buttonMenuAction(sender: UIButton!) {
        
        print("Button menu tapped")
        let buttonTapped = sender.tag
        print (buttonTapped)
        print( arrayMenuOptions[buttonTapped]["target"]! )

        if arrayMenuOptions[buttonTapped]["target"]! == "plansDeVol" && !applicationParametres.visiblePlanDeVolMenu {
            
            let viewWithTag1 = self.view.viewWithTag(140)
            viewWithTag1?.removeFromSuperview()
            
            applicationParametres.visiblePlanDeVolMenu = true
            applicationParametres.visibleCartesVACMenu = false
            applicationParametres.visibleEBibliothequeMenu = false
            applicationParametres.visibleAeronefsMenu = false
            applicationParametres.visibleUtilisateursMenu = false
            applicationParametres.visibleCheckListMenu = false
            applicationParametres.visibleMenuPrincipalMenu = false
            
            reLoadLayerMenu()
            
            processPlanDeVol(visible: applicationParametres.visiblePlanDeVolMenu)
            
        }
        
        if arrayMenuOptions[buttonTapped]["target"]! == "cartesVAC" && !applicationParametres.visibleCartesVACMenu {
            
            let viewWithTag1 = self.view.viewWithTag(140)
            viewWithTag1?.removeFromSuperview()
            
            applicationParametres.visiblePlanDeVolMenu = false
            applicationParametres.visibleCartesVACMenu = true
            applicationParametres.visibleEBibliothequeMenu = false
            applicationParametres.visibleAeronefsMenu = false
            applicationParametres.visibleUtilisateursMenu = false
            applicationParametres.visibleCheckListMenu = false
            applicationParametres.visibleMenuPrincipalMenu = false
            
            reLoadLayerMenu()
            
            processCartesVACMenu(visible: applicationParametres.visibleCartesVACMenu)
            
        }
        
        if arrayMenuOptions[buttonTapped]["target"]! == "eBibliotheque" && !applicationParametres.visibleEBibliothequeMenu {
            
            let viewWithTag1 = self.view.viewWithTag(140)
            viewWithTag1?.removeFromSuperview()
            
            applicationParametres.visiblePlanDeVolMenu = false
            applicationParametres.visibleCartesVACMenu = false
            applicationParametres.visibleEBibliothequeMenu = true
            applicationParametres.visibleAeronefsMenu = false
            applicationParametres.visibleUtilisateursMenu = false
            applicationParametres.visibleCheckListMenu = false
            applicationParametres.visibleMenuPrincipalMenu = false
            
            reLoadLayerMenu()
        
            processEBibliothequeMenu(visible: applicationParametres.visibleEBibliothequeMenu)
        
        }
        
        if arrayMenuOptions[buttonTapped]["target"]! == "aeronefs" && !applicationParametres.visibleAeronefsMenu {
            
            let viewWithTag1 = self.view.viewWithTag(140)
            viewWithTag1?.removeFromSuperview()
            
            applicationParametres.visiblePlanDeVolMenu = false
            applicationParametres.visibleCartesVACMenu = false
            applicationParametres.visibleEBibliothequeMenu = false
            applicationParametres.visibleAeronefsMenu = true
            applicationParametres.visibleUtilisateursMenu = false
            applicationParametres.visibleCheckListMenu = false
            applicationParametres.visibleMenuPrincipalMenu = false
            
            reLoadLayerMenu()
            
            processAeronefsMenu(visible: applicationParametres.visibleAeronefsMenu)
            
        }
        
        if arrayMenuOptions[buttonTapped]["target"]! == "utilisateurs" && !applicationParametres.visibleUtilisateursMenu {
            
            let viewWithTag1 = self.view.viewWithTag(140)
            viewWithTag1?.removeFromSuperview()
            
            applicationParametres.visiblePlanDeVolMenu = false
            applicationParametres.visibleCartesVACMenu = false
            applicationParametres.visibleEBibliothequeMenu = false
            applicationParametres.visibleAeronefsMenu = false
            applicationParametres.visibleUtilisateursMenu = true
            applicationParametres.visibleCheckListMenu = false
            applicationParametres.visibleMenuPrincipalMenu = false
            
            reLoadLayerMenu()
            
            processUtilisateursMenu(visible: applicationParametres.visibleUtilisateursMenu)
            
        }
        
        if arrayMenuOptions[buttonTapped]["target"]! == "checklists" && !applicationParametres.visibleCheckListMenu {
            
            let viewWithTag1 = self.view.viewWithTag(140)
            viewWithTag1?.removeFromSuperview()
            
            applicationParametres.visiblePlanDeVolMenu = false
            applicationParametres.visibleCartesVACMenu = false
            applicationParametres.visibleEBibliothequeMenu = false
            applicationParametres.visibleAeronefsMenu = false
            applicationParametres.visibleUtilisateursMenu = false
            applicationParametres.visibleCheckListMenu = true
            applicationParametres.visibleMenuPrincipalMenu = false
            
            reLoadLayerMenu()
            
            processChecklistsMenu(visible: applicationParametres.visibleCheckListMenu)
            
        }
        
        if arrayMenuOptions[buttonTapped]["target"]! == "menuPrincipal" {
            
            applicationParametres.screenActive = "accueilScreen"
            self.menuAccueil(visible: true)
            
        }
        
    }
    
    //Reload All Layer Menu
    func reLoadLayerMenu() {
        
        print("Reload Layer A")
        for layer: CALayer in self.view.layer.sublayers! {
            if layer.name == "Touch Zone" {
                layer.removeFromSuperlayer()
            }
        }
        
        let viewWithTag22156 = self.view.viewWithTag(221)
        viewWithTag22156?.removeFromSuperview()
        
        for i in 0...20 {
            let viewWithTag = self.view.viewWithTag(10000 + i)
            viewWithTag?.alpha = 1.0
            viewWithTag?.backgroundColor = UIColor.clear
            
        }
        
        let viewWithTag1 = self.view.viewWithTag(140)
        viewWithTag1?.removeFromSuperview()
        
        if !applicationParametres.visibleMenuPrincipal {
            print("Erase Layer")
            applicationParametres.visiblePlanDeVolMenu = false
            applicationParametres.visibleCartesVACMenu = false
            applicationParametres.visibleEBibliothequeMenu = false
            applicationParametres.visibleAeronefsMenu = false
            applicationParametres.visibleUtilisateursMenu = false
            applicationParametres.visibleCheckListMenu = false
            applicationParametres.visibleMenuPrincipalMenu = false

        }
        
//        //navigationBarMenu(visible: true)
//        menuOptionMapView(visible: applicationParametres.visibleMenuOptionMapView)
//        clipBoardPanel(visible: applicationParametres.visibleClipBoardMapView)
//        addMenuPrincipal(visible: applicationParametres.visibleMenuPrincipal)
        processPlanDeVol(visible: applicationParametres.visiblePlanDeVolMenu)
        processCartesVACMenu(visible: applicationParametres.visibleCartesVACMenu)
        processEBibliothequeMenu(visible: applicationParametres.visibleEBibliothequeMenu)
        processAeronefsMenu(visible: applicationParametres.visibleAeronefsMenu)
        processUtilisateursMenu(visible: applicationParametres.visibleUtilisateursMenu)
        processChecklistsMenu(visible: applicationParametres.visibleCheckListMenu)
    }
    
    //Reload All Layer Menu
    func reLoadLayerStatusBar() {
        
        print("Reload Layer B ")
            let viewWithTag1 = self.view.viewWithTag(140)
            viewWithTag1?.removeFromSuperview()
            navigationBarMenu(visible: true)
            menuOptionMapView(visible: applicationParametres.visibleMenuOptionMapView)
            clipBoardPanel(visible: applicationParametres.visibleClipBoardMapView)
            addMenuPrincipal(visible: applicationParametres.visibleMenuPrincipal)

    }
    
    
    /* Begin Of Function ******************************************************
     *    return value clicked on Option Map View Menu *
     ***************************************************/
    
    @objc func buttonMenuMapOptionAction(sender: UIButton!) {
        
        print("Button Map Option tapped")
        let buttonTapped = sender.tag
        print( " \(sender.tag) => \(arrayMapViewOptions[buttonTapped]["target"]!) \(applicationParametres.buttonOptionMapView[buttonTapped]) ")
        //print (applicationParametres.buttonOptionMapView)
        
        
        if applicationParametres.buttonOptionMapView[buttonTapped] {
            
            applicationParametres.buttonOptionMapView[buttonTapped] = false
            
        } else {
            
            applicationParametres.buttonOptionMapView[buttonTapped] = true
            
        }
             menuOptionMapView(visible: applicationParametres.visibleMenuOptionMapView)
        
        if arrayMapViewOptions[buttonTapped]["target"]!  == "mapMenuIconFligthPlan" {
            
            drawRoutePlane()
            
        }
        
        if arrayMapViewOptions[buttonTapped]["target"]!  == "mapMenuIconAirfield" {
            
            carteAirports()
        }
        
        if arrayMapViewOptions[buttonTapped]["target"]!  == "mapMenuIconAirfield2" {
        
            drawPolyLineShape()
        
        }
        
        if arrayMapViewOptions[buttonTapped]["target"]!  == "mapMenuIconRadionave" {
           
            carteNavaidsEnRoute()
        }
        
        if arrayMapViewOptions[buttonTapped]["target"]!  == "mapMenuIconRadionavt" {
            
            carteNavaidsTerminal()
        }
        
        if arrayMapViewOptions[buttonTapped]["target"]!  == "mapMenuIconLandmark" {
            carteReperesVisuels()
            
        }
        
        if arrayMapViewOptions[buttonTapped]["target"]!  == "mapMenuIconWarningInterdiction" {
            carteWarningInterdictions()
        }
        
        if arrayMapViewOptions[buttonTapped]["target"]!  == "mapMenuIconAirspaceLow" {
            carteZoneAeriennes()
        }
        
        if arrayMapViewOptions[buttonTapped]["target"]!  == "mapMenuIconAirspaceHigh" {

        }
        
        if arrayMapViewOptions[buttonTapped]["target"]!  == "mapMenuIconFir" {
            
        }
        
        if arrayMapViewOptions[buttonTapped]["target"]!  == "mapMenuIconCity" {
        
            carteVilles()
        }
        
        if arrayMapViewOptions[buttonTapped]["target"]!  == "mapMenuIconPeak" {
            
            carteReperesVisuelsMontagne()
            
        }
        
        if arrayMapViewOptions[buttonTapped]["target"]!  == "mapMenuIconForest" {
            
            carteReperesVisuelsForet()
            
        }
        
        if arrayMapViewOptions[buttonTapped]["target"]!  == "mapMenuIconLake" {
            
            carteReperesVisuelsLac()
            
        }
        
        if arrayMapViewOptions[buttonTapped]["target"]!  == "menuMapOtionsViewMap1" {
            
            applicationParametres.buttonOptionMapView[15] = true
            applicationParametres.buttonOptionMapView[16] = false
            applicationParametres.buttonOptionMapView[17] = false
            applicationParametres.buttonOptionMapView[18] = false
            applicationParametres.buttonOptionMapView[19] = false
            affichageFondCartesMapbox()
        }
        
        if arrayMapViewOptions[buttonTapped]["target"]!  == "menuMapOtionsViewMap2" {
            
            applicationParametres.buttonOptionMapView[15] = false
            applicationParametres.buttonOptionMapView[16] = true
            applicationParametres.buttonOptionMapView[17] = false
            applicationParametres.buttonOptionMapView[18] = false
            applicationParametres.buttonOptionMapView[19] = false
            affichageFondCartesMapbox()
        }

        if arrayMapViewOptions[buttonTapped]["target"]!  == "menuMapOtionsViewMap3" {
            
            applicationParametres.buttonOptionMapView[15] = false
            applicationParametres.buttonOptionMapView[16] = false
            applicationParametres.buttonOptionMapView[17] = true
            applicationParametres.buttonOptionMapView[18] = false
            applicationParametres.buttonOptionMapView[19] = false
            affichageFondCartesMapbox()
            
        }
        
        if arrayMapViewOptions[buttonTapped]["target"]!  == "menuMapOtionsViewMap4" {
            
            applicationParametres.buttonOptionMapView[15] = false
            applicationParametres.buttonOptionMapView[16] = false
            applicationParametres.buttonOptionMapView[17] = false
            applicationParametres.buttonOptionMapView[18] = true
            applicationParametres.buttonOptionMapView[19] = false
            affichageFondCartesMapbox()
            
        }
        
        if arrayMapViewOptions[buttonTapped]["target"]!  == "menuMapOtionsViewMap5" {
            
            applicationParametres.buttonOptionMapView[15] = false
            applicationParametres.buttonOptionMapView[16] = false
            applicationParametres.buttonOptionMapView[17] = false
            applicationParametres.buttonOptionMapView[18] = false
            applicationParametres.buttonOptionMapView[19] = true
            affichageFondCartesMapbox()
            
        }
        
        ReloadMapboxViewOption()
        
    }
    
    func ReloadMapboxViewOption() {
        
        print("Reload Mapbox")
        for layer: CALayer in self.view.layer.sublayers! {
            if layer.name == "Touch Zone" {
                layer.removeFromSuperlayer()
            }
            
        }
        
        let viewWithTag221 = self.view.viewWithTag(221)
        viewWithTag221?.removeFromSuperview()
        //drawPolyLineShape()
        //        carteReperesVisuelsMontagne()
//        carteReperesVisuels()
//        carteReperesVisuelsMontagne()
//        carteReperesVisuelsLac()
//        carteReperesVisuelsForet()
//        carteWarningInterdictions()
//        carteAirports()
//        carteVilles()
//        carteNavaidsTerminal()
//        carteNavaidsEnRoute()
//        carteZoneAeriennes()

       
        affichageVillesZoom()
        
        menuOptionMapView(visible: applicationParametres.visibleMenuOptionMapView)
        navigationBarMenu(visible: true)
        
    }
    
    func affichageVillesZoom() {
        
        print ("Affichage Villes \(zoomLevelMap)")

        if applicationParametres.buttonOptionMapView[11] == false {
            
        //Capitales
        let viewWithTag15a = self.view.viewWithTag(15)
        viewWithTag15a?.removeFromSuperview()

        //Sous-Prefectures / Canton / Prefecture
        let viewWithTag15b = self.view.viewWithTag(16)
        viewWithTag15b?.removeFromSuperview()

        //Commune Simple
        let viewWithTag15d = self.view.viewWithTag(17)
        viewWithTag15d?.removeFromSuperview()
        }
        
        if applicationParametres.buttonOptionMapView[11] == true {
            print ("Cartes Villes")
            //Sous-Prefectures
            
            if zoomLevelMap >= 7 {
                print ("Afficher Sous-Prefecture")
                //viewWithTag15b?.isHidden = false
                
            } else {
                let viewWithTag15b = self.view.viewWithTag(16)
                 viewWithTag15b?.removeFromSuperview()
            }

            if zoomLevelMap >= 9.5  {
                print ("Afficher Commune Simple")
                //viewWithTag15c?.isHidden = false
            } else {
                let viewWithTag15c = self.view.viewWithTag(17)
                viewWithTag15c?.removeFromSuperview()
            }
        }
    
    }
  
    /* End Of Function ******************************************************/
    
}
