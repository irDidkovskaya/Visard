//
//  User.h
//  vc-mobile
//
//  Created by Alexandr Fal' on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * citezenShip;
@property (nonatomic, retain) NSString * currentCountry;
@property (nonatomic, retain) NSString * name;

@end
