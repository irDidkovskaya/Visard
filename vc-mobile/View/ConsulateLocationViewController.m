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
        self.mapView.showsUserLocation = YES;
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
    //self.mapView.showsUserLocation = YES;
       
    [self addToolBar];
    
    MyPinAnnotation *ann = [[MyPinAnnotation alloc] initWithCoordinate:coord title:address];
    ann.tag = 0;
    //ann.thumb = p.thumb;
    [self.mapView addAnnotation:ann];
    [ann release];
    
    [self.mapView setRegion:MKCoordinateRegionMake(coord, MKCoordinateSpanMake(0.1, 0.1))];
    
    [self zoomToFitMapAnnotations:self.mapView];
    
    [self.view addSubview:self.mapView];
    
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


- (void)zoomToFitMapAnnotations:(MKMapView *)mapView
{
    if([self.mapView.annotations count] == 0)
        return;
    
    CLLocationCoordinate2D topLeftCoord;
    topLeftCoord.latitude = -90;
    topLeftCoord.longitude = 180;
    
    CLLocationCoordinate2D bottomRightCoord;
    bottomRightCoord.latitude = 90;
    bottomRightCoord.longitude = -180;
    
    for(MyPinAnnotation* annotation in self.mapView.annotations)
    {
        topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude);
        topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude);
        
        bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
        bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
    }
    
    MKCoordinateRegion region1;
    region1.center.latitude = topLeftCoord.latitude -  (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5;
    region1.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;
    region1.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.2f; // Add a little extra space on the sides
    region1.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.2f; // Add a little extra space on the sides

    if ([self.mapView.annotations count] == 1)
    {
        region1.span.latitudeDelta = 0.1; 
        region1.span.longitudeDelta = 0.1;
    }
    region1 = [self.mapView regionThatFits:region1];
    [self.mapView setRegion:region1 animated:YES];
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    [self zoomToFitMapAnnotations:self.mapView];
}

- (void)mapView:(MKMapView *)mp didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [self zoomToFitMapAnnotations:mp];
}

#pragma mark Action




- (void)showYourLocation {
    self.mapView.showsUserLocation = YES;
}

- (void)showRoute {
    
}

@end
