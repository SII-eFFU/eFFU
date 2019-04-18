//
//  Configuration.swift
//
//  Created by Thierry Danthez on 27/11/18.
//

import Foundation
import CoreLocation

//Tableaux Menus
var arrayMenuOptions = [[String : String]]()
var arrayMapViewOptions = [[String : String]]()

public struct ApplicationParametres {
    
    /*********************************************************
     *     Parametres localisation Site pour ipad simulator  *
     *********************************************************/
    
    // Menu et Cartes Actives
    
    let lieu = "Toulouse-Lasbordes"

    var screenActive: String?
    var optionMapActionButton: String?
    var visibleMenuPrincipal: Bool = false
    var visibleMenuOptionMapView: Bool = false
    var visibleClipBoardMapView: Bool = false
    
    var visiblePlanDeVolMenu: Bool = false
    var visibleCartesVACMenu: Bool = false
    var visibleEBibliothequeMenu: Bool = false
    var visibleAeronefsMenu: Bool = false
    var visibleUtilisateursMenu: Bool = false
    var visibleCheckListMenu: Bool = false
    var visibleMenuPrincipalMenu: Bool = false
    
    //0 => mapMenuIconFligthPlan
    //1 => mapMenuIconAirfield
    //2 => mapMenuIconRadionav
    //3 => mapMenuIconLandmark
    //4 => mapMenuIconWarningInterdiction
    //5 => mapMenuIconAirspaceLow
    //6 => mapMenuIconAirspaceHigh
    //7 => mapMenuIconFir
    //8 => mapMenuIconCity
    //9 => mapMenuIconPeak
    //10 => mapMenuIconForest
    //11 => mapMenuIconLake
    //12 => menuMapOtionsViewMap1
    //13 => menuMapOtionsViewMap2
    //14 => menuMapOtionsViewMap3
    //15 => menuMapOtionsViewMap4
    var buttonOptionMapView: [Bool] = [false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, true, false, false,false, false]
    
    // Styles
    
    var borderCornerRadius: Int = 8
    var paddingBorder: Int = 4
    var opacityMenu: Double = 0.8
}


