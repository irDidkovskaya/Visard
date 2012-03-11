//
//  ConsulateLocationViewController.m
//  vc-mobile
//
//  Created by Ирина Дидковская on 17.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ConsulateLocationViewController.h"
#import <MapKit/MapKit.h>
#import "MyPinAnnotation.h"
#import "AppStyle.h"


@implementation ConsulateLocationViewController
@synthesize mapView, address, img, countryName, cityName, toolBar;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}


- (id)initWithLocationLatitute:(double)latitude longitude:(double)longitude
{
    self = [super init];
    if (self) {
        //self.mapView.showsUserLocation = YES;
        coord.longitude = (CLLocationDegrees)longitude;
        coord.latitude = (CLLocationDegrees)latitude;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)addToolBar
{
    
    UIToolbar *tb = [[[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 88, self.view.frame.size.width, 44)] autorelease];
   
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *yourLocatBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow.png"] style:UIBarButtonItemStylePlain target:self action:@selector(showYourLocation)];
   
    UIBarButtonItem *showRouteBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(showRoute)];
    
    
    //UIBarButtonItem *showRoute = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(showRoute)];
    
    
    NSArray *arrWithButt = [NSArray arrayWithObjects:yourLocatBtn, flexibleSpace, showRouteBtn, nil];
    [tb setItems:arrWithButt];
    tb.tintColor = [AppStyle colorForNavigationBar];
    tb.barStyle = UIBarStyleDefault;
    self.toolBar = tb;
    [self.view addSubview:self.toolBar];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = [NSString stringWithFormat:@"Консульство %@ d %@ на карте", self.countryName, self.cityName];
    //self.mapView = [[[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44)] autorelease]; 
    //self.mapView.delegate = self; 
    //self.mapView.showsUserLocation = YES;
       
    MapView *mapViewNew = [[[MapView alloc] initWithFrame:
                            CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height - 44)] autorelease];
    self.mapView = mapViewNew;
    [self.view addSubview:self.mapView];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.delegate = self;
    
    [locationManager startUpdatingLocation];
    
    
    Place *end = [[[Place alloc] init] autorelease];
    end.latitude = coord.latitude;
    end.longitude = coord.longitude;
    end.name = self.cityName;
    end.description = self.address;
    
    
    
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    Place *home = [[[Place alloc] init] autorelease];
    home.name = @"You here";
    home.description = @"";
    home.latitude = coordinate.latitude;
    home.longitude = coordinate.longitude;
    
    
    [self.mapView showCounsulateLocation:end andSendCurrentLocaton:home];
    
    
    [self addToolBar];
    
    //MyPinAnnotation *ann = [[MyPinAnnotation alloc] initWithCoordinate:coord title:address];
    //ann.tag = 0;
    //ann.thumb = p.thumb;
    //[self.mapView addAnnotation:ann];
    //[ann release];
    
    //[self.mapView setRegion:MKCoordinateRegionMake(coord, MKCoordinateSpanMake(0.1, 0.1))];
    
    //[self zoomToFitMapAnnotations:self.mapView];
    
    //[self.view addSubview:self.mapView];
    
    self.navigationController.navigationBar.tintColor = [AppStyle colorForNavigationBar];
    //self.mapView.showsUserLocation = NO;

}


- (void)viewDidUnload
{
    [super viewDidUnload];
    self.mapView = nil;
    self.toolBar = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    
    self.mapView = nil;
    self.address = nil;
    self.img = nil;
    self.countryName = nil;
    self.cityName = nil;
    self.toolBar = nil;
    locationManager.delegate = nil;
    [locationManager release];
    [super dealloc];
    
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) 
    {
        return nil;
    }
    
    
    MyPinAnnotation *ann = (id)annotation;
    
    MKPinAnnotationView *annView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"] autorelease];
    annView.pinColor = MKPinAnnotationColorGreen;
    annView.animatesDrop = YES;
    annView.canShowCallout = YES;
    MKCoordinateRegion counsLocation;
    counsLocation.center.latitude = coord.latitude;
    counsLocation.center.longitude = coord.longitude;
    if (ann.thumb) 
    {
        //NSString *file = [ann.thumb stringByAppendingPathExtension:@"jpg"];
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 23, 23)];
        iv.image = [UIImage imageNamed:self.img];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        //UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:file]];
        annView.leftCalloutAccessoryView = iv;
        [iv release];
    }
    
   
    return annView;
}



- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    //[self zoomToFitMapAnnotations:self.mapView];
}

- (void)mapView:(MKMapView *)mp didUpdateUserLocation:(MKUserLocation *)userLocation
{
    //[self zoomToFitMapAnnotations:mp];
}

#pragma mark Action




- (void)showYourLocation {
    //self.mapView.showsUserLocation = YES;

    [self.mapView showCurrentLocation];
}

- (void)showRoute {
    [self.mapView showRoute];
}

@end
