//
//  MapView.m
//  MobileCiklum
//
//  Created by bunny on 11/29/11.
//  Copyright (c) 2011 Ciklum. All rights reserved.
//

#import "MapView.h"
#import "PlaceMark.h"

@interface MapView()

-(NSMutableArray *)decodePolyLine: (NSMutableString *)encoded;
-(void) updateRouteView;
-(NSArray*) calculateRoutesFrom:(CLLocationCoordinate2D) from to: (CLLocationCoordinate2D) to;
- (void)showAlertView;

@end

@implementation MapView

@synthesize lineColor, from, to;

- (id) initWithFrame:(CGRect) frame
{
	self = [super initWithFrame:frame];
	if (self != nil) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        
		mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-44)];
        
        mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
		mapView.showsUserLocation = NO;
		[mapView setDelegate:self];
		[self addSubview:mapView];
		routeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, mapView.frame.size.width, mapView.frame.size.height)];
        routeView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
		routeView.userInteractionEnabled = NO;
		[mapView addSubview:routeView];
		
		self.lineColor = [UIColor colorWithWhite:0.2 alpha:0.5];
	}
	return self;
}

-(NSMutableArray *)decodePolyLine: (NSMutableString *)encoded {
	[encoded replaceOccurrencesOfString:@"\\\\" withString:@"\\"
								options:NSLiteralSearch
								  range:NSMakeRange(0, [encoded length])];
	NSInteger len = [encoded length];
	NSInteger index = 0;
	NSMutableArray *array = [[[NSMutableArray alloc] init] autorelease];
	NSInteger lat=0;
	NSInteger lng=0;
	while (index < len) {
		NSInteger b;
		NSInteger shift = 0;
		NSInteger result = 0;
		do {
			b = [encoded characterAtIndex:index++] - 63;
			result |= (b & 0x1f) << shift;
			shift += 5;
		} while (b >= 0x20);
		NSInteger dlat = ((result & 1) ? ~(result >> 1) : (result >> 1));
		lat += dlat;
		shift = 0;
		result = 0;
		do {
			b = [encoded characterAtIndex:index++] - 63;
			result |= (b & 0x1f) << shift;
			shift += 5;
		} while (b >= 0x20);
		NSInteger dlng = ((result & 1) ? ~(result >> 1) : (result >> 1));
		lng += dlng;
		NSNumber *latitude = [[[NSNumber alloc] initWithFloat:lat * 1e-5] autorelease];
		NSNumber *longitude = [[[NSNumber alloc] initWithFloat:lng * 1e-5] autorelease];
		printf("[%f,", [latitude doubleValue]);
		printf("%f]", [longitude doubleValue]);
		CLLocation *loc = [[[CLLocation alloc] initWithLatitude:[latitude floatValue] longitude:[longitude floatValue]] autorelease];
		[array addObject:loc];
	}
	
	return array;
}

-(NSArray *) calculateRoutesFrom:(CLLocationCoordinate2D) f to: (CLLocationCoordinate2D) t {
	NSString *saddr = [NSString stringWithFormat:@"%f,%f", f.latitude, f.longitude];
	NSString *daddr = [NSString stringWithFormat:@"%f,%f", t.latitude, t.longitude];
	
	NSString *apiUrlStr = [NSString stringWithFormat:@"http://maps.google.com/maps?output=dragdir&saddr=%@&daddr=%@", saddr, daddr];
	NSURL *apiUrl = [NSURL URLWithString:apiUrlStr];
    NSString *apiResponse = [NSString stringWithContentsOfURL:apiUrl encoding:NSStringEncodingConversionExternalRepresentation error:nil];
	NSString *encodedPoints = [apiResponse stringByMatching:@"points:\\\"([^\\\"]*)\\\"" capture:1L];
	
	return [self decodePolyLine:[[encodedPoints mutableCopy] autorelease]];
}



- (void)zoomToFitMapAnnotations
{
    if([mapView.annotations count] == 0)
        return;
    
    CLLocationCoordinate2D topLeftCoord;
    topLeftCoord.latitude = -90;
    topLeftCoord.longitude = 180;
    
    CLLocationCoordinate2D bottomRightCoord;
    bottomRightCoord.latitude = 90;
    bottomRightCoord.longitude = -180;
    NSLog(@"mapView.annotations = %d", [mapView.annotations count]);
    for(PlaceMark* annotation in mapView.annotations)
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

    if ([mapView.annotations count] == 1)
    {
        region1.span.latitudeDelta = 0.1; 
        region1.span.longitudeDelta = 0.1;
    }
    region1 = [mapView regionThatFits:region1];
    [mapView setRegion:region1 animated:YES];
}



- (void)showCounsulateLocation: (Place *)location andSendCurrentLocaton:(Place *)currentLocation
{
    
//    PlaceMark *userLocation = [[[PlaceMark alloc] initWithPlace:currentLocation] autorelease];
//    self.from = userLocation;
//    self.from.pinColor = MKPinAnnotationColorPurple;
    
    
    PlaceMark *consulateLocation = [[[PlaceMark alloc] initWithPlace:location] autorelease];
    self.to = consulateLocation;
    self.to.pinColor = MKPinAnnotationColorRed;
    [mapView addAnnotation:self.to];
    [self zoomToFitMapAnnotations];
}

- (void)showCurrentLocation {
    if (mapView.showsUserLocation == NO) 
    {
        mapView.showsUserLocation = YES;
       // [mapView addAnnotation:from];
    }

    [self zoomToFitMapAnnotations];
}

-(void) showRoute {
	
//	if([routes count]) {
//		[mapView removeAnnotations:[mapView annotations]];
//		[routes release];
//	}
    
    if (mapView.showsUserLocation == NO) {
        [self showCurrentLocation];
    }
    
    Place *currentLocation = [[[Place alloc] init] autorelease];
    currentLocation.latitude =  mapView.userLocation.coordinate.latitude;
    currentLocation.longitude =  mapView.userLocation.coordinate.longitude;
    PlaceMark *userLocation = [[[PlaceMark alloc] initWithPlace:currentLocation] autorelease];
    //    self.from = userLocation;
    
	routes = [[self calculateRoutesFrom:userLocation.coordinate to:to.coordinate] retain];
    if (![routes count]) {
        
        [self showAlertView];
        return;
        
    }
    //from.pinColor = MKPinAnnotationColorGreen;
    //to.pinColor = MKPinAnnotationColorRed;
	
	[self updateRouteView];
	[self zoomToFitMapAnnotations];
}

-(void) updateRouteView {
	CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = 	CGBitmapContextCreate(nil, 
												  routeView.frame.size.width, 
												  routeView.frame.size.height, 
												  8, 
												  4 * routeView.frame.size.width,
												  rgb,
												  kCGImageAlphaPremultipliedLast);
	
	CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
	CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 1.0);
	CGContextSetLineWidth(context, 3.0);
	CGColorSpaceRelease(rgb);
	for(int i = 0; i < routes.count; i++) {
		CLLocation* location = [routes objectAtIndex:i];
		CGPoint point = [mapView convertCoordinate:location.coordinate toPointToView:routeView];
		
		if (i == 0) {
			CGContextMoveToPoint(context, point.x, routeView.frame.size.height - point.y);
		} else {
			CGContextAddLineToPoint(context, point.x, routeView.frame.size.height - point.y);
		}
	}
	
	CGContextStrokePath(context);
	
	CGImageRef image = CGBitmapContextCreateImage(context);
	UIImage *img = [UIImage imageWithCGImage:image];
	
	routeView.image = img;
	CGContextRelease(context);
	CGImageRelease(image);

    
}

#pragma mark mapView delegate functions
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
	routeView.hidden = YES;
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
	[self updateRouteView];
	routeView.hidden = NO;
	[routeView setNeedsDisplay];
}


//
//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
//{
//    if ([annotation isKindOfClass:[MKUserLocation class]]) 
//    {
//        return nil;
//    }
//    
//    
//    MyPinAnnotation *ann = (id)annotation;
//    
//    MKPinAnnotationView *annView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"] autorelease];
//    annView.pinColor = MKPinAnnotationColorGreen;
//    annView.animatesDrop = YES;
//    annView.canShowCallout = YES;
//    MKCoordinateRegion counsLocation;
//    counsLocation.center.latitude = coord.latitude;
//    counsLocation.center.longitude = coord.longitude;
//    if (ann.thumb) 
//    {
//        //NSString *file = [ann.thumb stringByAppendingPathExtension:@"jpg"];
//        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 23, 23)];
//        iv.image = [UIImage imageNamed:self.img];
//        iv.contentMode = UIViewContentModeScaleAspectFit;
//        //UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:file]];
//        annView.leftCalloutAccessoryView = iv;
//        [iv release];
//    }
//    
//    
//    return annView;
//}

- (MKAnnotationView *)mapView:(MKMapView *)mapViewMy viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) 
    {
        return nil;
    }
    
    MKPinAnnotationView *annView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"] autorelease];
    //MKPinAnnotationView *pinView = (MKPinAnnotationView*)[mapViewMy dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
    PlaceMark *myPin = (id)annotation;
    
    if(annView != nil) {
        //pinView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"] autorelease];
        
        if ([myPin isKindOfClass:[PlaceMark class]]) 
            annView.pinColor = myPin.pinColor;
        
        annView.animatesDrop = YES;
        annView.canShowCallout = YES;
        //[pinView setSelected:YES animated:YES];
    } else {
        annView.annotation = annotation;
    }
    
    //[mapViewMy selectAnnotation:annotation animated:YES];
    //NSLog(@"Pin color = %@", [[[mapViewMy  annotations] objectAtIndex:0] pinColor]);
    
    return annView;
}


- (void) showAlertView {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Ошибка", nil) message:NSLocalizedString(@"Нет интернет соеденения", nil) delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil];
    [alertView show];
    [alertView release];
    
    
}




- (void)dealloc {
	if(routes) {
		[routes release];
	}
    [lineColor release];
	[mapView release];
	[routeView release];
    self.from = nil;
    self.to = nil;
    [super dealloc];
}

@end