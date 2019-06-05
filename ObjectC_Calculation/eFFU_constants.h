//
//  eFFU_Constants.h
//  eFFU
//
//  Created by lpery on 02/06/2015.
//  Copyright (c) 2015 SII. All rights reserved.
//

#ifndef eFFU_Constants_h
#define eFFU_Constants_h

#define iconBGColorUnselected [UIColor colorWithRed:0.76f green:0.88f blue:1.f alpha:1.f]
#define iconBGColorMenus [UIColor colorWithRed:0.76f green:0.88f blue:1.f alpha:0.f]
//asotemp?
@interface eFFU_Constants : NSObject

extern const int iconSideDim; // If moved over 40, the size of the declutterPopUp shall be adapted...
extern const int iconTopOffset;
extern const int iconAccessDim;
extern const int iconSpacing;
extern const int subPageWith;
extern const int toolBarHeight;
extern const int tabBarHeight;
extern const int actionViewHeightShift;
extern const int actionViewWidthShift;
extern const int flightPlanDateWidth;
extern const int flightPlanLabelShift;

extern const float kMaxZoomAirport;
extern const float kMaxZoomRunway;
extern const float kLandscapeStartingLat;
extern const float kLandscapeStartingLon;
extern const float kPortraitStartingLat;
extern const float kPortraitStartingLon;
extern const float kStartingZoom;
extern const float kMinZoom;
extern const float communeShowZoom;
extern const float fplnLabelShift;
extern const float communeLabelShift;
extern const double radian_to_degree;
extern const double degree_to_radian;

@end
#endif
