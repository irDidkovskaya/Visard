//
//  PlaceMark.h
//  MobileCiklum
//
//  Created by bunny on 11/29/11.
//  Copyright (c) 2011 Ciklum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Place.h"

@interface PlaceMark : NSObject <MKAnnotation> {
    
	CLLocationCoordinate2D coordinate;
	Place* place;
    MKPinAnnotationColor pinColor;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) Place* place;
@property (nonatomic, assign) MKPinAnnotationColor pinColor;

-(id) initWithPlace: (Place*) p;

@end
