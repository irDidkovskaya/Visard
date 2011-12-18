//
//  Consulate.h
//  vc-mobile
//
//  Created by Alexandr Fal' on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Country;

@interface Consulate : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * countryId;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) Country *country;

@end
