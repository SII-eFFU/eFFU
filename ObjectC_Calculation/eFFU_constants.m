//
//  eFFU-Constants.m
//  eFFU
//
//  Created by lpery on 02/06/2015.
//  Copyright (c) 2015 SII. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "eFFU_constants.h"

//asotemp? ajout de @interface/@implementation/@end + les const dans ce fichier + l'import du .h
@implementation eFFU_Constants : NSObject

const int iconSideDim = 40;
const int iconTopOffset = 18;
const int iconAccessDim = 64;
const int iconSpacing = 4;
const int subPageWith = 680;
const int toolBarHeight = 70;
const int tabBarHeight = 49;
const int actionViewHeightShift = 5;
const int actionViewWidthShift = 50;
const int flightPlanDateWidth = 180;
const int flightPlanLabelShift = 210;

const float kMaxZoomAirport = 13.f;
const float kMaxZoomRunway = 16.f;
const float kPortraitStartingLat = 46.5f;
const float kPortraitStartingLon = 1.45f;
const float kLandscapeStartingLat = 46.5f;
const float kLandscapeStartingLon = 0.f;
const float kStartingZoom = 6.0f;
const float kMinZoom = 5.0f;
const float fplnLabelShift = -21.0f;
const float communeLabelShift = 8.0f;
const float communeShowZoom = 11.0f;
const double radian_to_degree = 180.0/M_PI;
const double degree_to_radian = M_PI/180.0;

@end
