//
//  Consulate.h
//  vc-mobile
//
//  Created by Ирина Дидковская on 17.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Consulate : NSManagedObject

@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSNumber * addres;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSManagedObject *countries;

@end
