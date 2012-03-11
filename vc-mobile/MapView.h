//
//  MapView.h
//  MobileCiklum
//
//  Created by bunny on 11/29/11.
//  Copyright (c) 2011 Ciklum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "RegexKitLite.h"
#import "Place.h"
#import "PlaceMark.h"

@interface MapView : UIView <MKMapViewDelegate, UIAlertViewDelegate> {
    
	MKMapView* mapView;
	UIImageView* routeView;
	
	NSArray* routes;
	
	UIColor* lineColor;
    
}

@property (nonatomic, retain) UIColor* lineColor;
@property (nonatomic, retain) PlaceMark *from;
@property (nonatomic, retain) PlaceMark *to;



-(void) showRoute;
- (void)showCurrentLocation;
- (void)showCounsulateLocation: (Place *)location andSendCurrentLocaton:(Place *)currentLocation;


@end
