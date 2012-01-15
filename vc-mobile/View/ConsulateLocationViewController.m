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
- (void)addToolBar{
    
    UIToolbar *tb = [[[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 88, self.view.frame.size.width, 44)] autorelease];
    
    UIBarButtonItem *yourLocatBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(showYourLocation)];
    
    
    //UIBarButtonItem *showRoute = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(showRoute)];
    
    
    NSArray *arrWithButt = [NSArray arrayWithObjects:yourLocatBtn, nil];
    [tb setItems:arrWithButt];
    tb.tintColor = [AppStyle colorForNavigationBar];
    tb.barStyle = UIBarStyleDefault;
    self.toolBar = tb;
    [self.mapView addSubview:self.toolBar];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = [NSString stringWithFormat:@"Консульство %@ d %@ на карте", self.countryName, self.cityName];
    self.mapView = [[[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44)] autorelease]; 
    self.mapView.delegate = self; 
    self.mapView.showsUserLocation = NO;
    
    
    [self addToolBar];
    
    MyPinAnnotation *ann = [[MyPinAnnotation alloc] initWithCoordinate:coord title:address];
    ann.tag = 0;
    //ann.thumb = p.thumb;
    [self.mapView addAnnotation:ann];
    [ann release];
    
    
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 12.0; //0.2
    span.longitudeDelta = 12.0;
    
    
    CLLocationCoordinate2D coordCenter;
    coordCenter.longitude = 11.469727; 
    coordCenter.latitude = 51.096623;
    region.span = span;
    region.center = coordCenter;
    
    [self.mapView setRegion:MKCoordinateRegionMake(coord, MKCoordinateSpanMake(0.1, 0.1))];
    
    [mapView setRegion:region animated:YES];
    [mapView regionThatFits:region];
    
    [self.view addSubview:self.mapView];
    
    self.navigationController.navigationBar.tintColor = [AppStyle colorForNavigationBar];
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
    [super dealloc];
    
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    MyPinAnnotation *ann = (id)annotation;
    
    MKPinAnnotationView *annView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"];
    annView.pinColor = MKPinAnnotationColorGreen;
    annView.animatesDrop = YES;
    annView.canShowCallout = YES;
    annView.calloutOffset = CGPointMake(-5, 5);
    
    //[self.mapView setRegion:MKCoordinateRegionMake(coord, MKCoordinateSpanMake(0.1, 0.1))];
    
    
    if (ann.thumb) {
        //NSString *file = [ann.thumb stringByAppendingPathExtension:@"jpg"];
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 23, 23)];
        iv.image = [UIImage imageNamed:self.img];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        //UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:file]];
        annView.leftCalloutAccessoryView = iv;
        [iv release];
    }
    
    
    return [annView autorelease];
}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [self.mapView setCenterCoordinate:self.mapView.userLocation.coordinate animated:YES];
}

#pragma mark Action


- (void)gotoLocation
{
    MKCoordinateRegion newRegion;
    
    CLLocation *userLocation = mapView.userLocation.location;
    float latitude = userLocation.coordinate.latitude;
    float longitude = userLocation.coordinate.latitude;
    newRegion.center.latitude = latitude;
    newRegion.center.longitude = longitude;
    
    [self.mapView setRegion:newRegion animated:YES];
}

- (void)showYourLocation {
    self.mapView.showsUserLocation = YES;
    [self gotoLocation];
}

- (void)showRoute {
    
}

@end
