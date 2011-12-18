//
//  MyPinAnnotation.m
//  Danish
//
//  Created by Ирина Дидковская on 02.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyPinAnnotation.h"


@implementation MyPinAnnotation


@synthesize coordinate;
@synthesize title;
@synthesize subtitle;
@synthesize thumb;
@synthesize tag;

- (id)initWithCoordinate:(CLLocationCoordinate2D) c title:(NSString *) nTitle
{
    self = [super init];
    if (self) {
        self.coordinate = c;
        self.title = nTitle;
        
    }
    return self;
}





- (void)dealloc {
    self.title = nil;
    self.subtitle = nil;
    self.thumb = nil;
    [super dealloc];
}

@end
