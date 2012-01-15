//
//  ConsulateLocationViewController.h
//  vc-mobile
//
//  Created by Ирина Дидковская on 17.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ConsulateLocationViewController : UIViewController <MKMapViewDelegate> {
    
    CLLocationCoordinate2D coord;
}

@property (nonatomic, retain) MKMapView *mapView;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *img;
@property (nonatomic, retain) NSString *countryName;
@property (nonatomic, retain) NSString *cityName;
@property (nonatomic, retain) UIToolbar *toolBar;

- (id)initWithLocationLatitute:(double)latitude longitude:(double)longitude;
@end
