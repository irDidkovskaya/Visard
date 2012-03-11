//
//  PlaceMark.m
//  MobileCiklum
//
//  Created by bunny on 11/29/11.
//  Copyright (c) 2011 Ciklum. All rights reserved.
//

#import "PlaceMark.h"


@implementation PlaceMark

@synthesize coordinate;
@synthesize place;
@synthesize pinColor;

-(id) initWithPlace: (Place*) p
{
	self = [super init];
	if (self != nil) {
		coordinate.latitude = p.latitude;
		coordinate.longitude = p.longitude;
		self.place = p;
	}
	return self;
}

- (NSString *)subtitle
{
	return self.place.description;
}
- (NSString *)title
{
	return self.place.name;
}

- (MKPinAnnotationColor)pinColor {
    return pinColor;
}

- (void) dealloc
{
	[place release];
	[super dealloc];
}


@end
