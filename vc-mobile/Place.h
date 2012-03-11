//
//  Place.h
//  MobileCiklum
//
//  Created by bunny on 11/29/11.
//  Copyright (c) 2011 Ciklum. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Place : NSObject {
    
	NSString* name;
	NSString* description;
	double latitude;
	double longitude;
}

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* description;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

@end
