//
//  Visa.h
//  vc-mobile
//
//  Created by Ирина Дидковская on 24.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Country, Requirement;

@interface Visa : NSManagedObject

@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) Country *country;
@property (nonatomic, retain) Requirement *requirements;

@end
