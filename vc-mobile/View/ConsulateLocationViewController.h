//
//  ConsulateLocationViewController.h
//  vc-mobile
//
//  Created by Ирина Дидковская on 17.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapView.h"
#import "Place.h"


@interface ConsulateLocationViewController : UIViewController <CLLocationManagerDelegate> {
    
    CLLocationCoordinate2D coord;
    CLLocationManager *locationManager;
}

@property (nonatomic, retain) MapView *mapView;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *img;
@property (nonatomic, retain) NSString *countryName;
@property (nonatomic, retain) NSString *cityName;
@property (nonatomic, retain) UIToolbar *toolBar;

- (id)initWithLocationLatitute:(double)latitude longitude:(double)longitude;
//- (void)zoomToFitMapAnnotations:(MKMapView *)mapView;
- (void)showRoute;

@end
