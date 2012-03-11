//
//  Place.m
//  MobileCiklum
//
//  Created by bunny on 11/29/11.
//  Copyright (c) 2011 Ciklum. All rights reserved.
//

#import "Place.h"


@implementation Place

@synthesize name;
@synthesize description;
@synthesize latitude;
@synthesize longitude;

- (void) dealloc
{
	[name release];
	[description release];
	[super dealloc];
}

@end
