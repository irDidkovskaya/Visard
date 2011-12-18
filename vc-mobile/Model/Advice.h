//
//  Advice.h
//  vc-mobile
//
//  Created by Alexandr Fal' on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Country;

@interface Advice : NSManagedObject

@property (nonatomic, retain) NSString * discriptionText;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) Country *country;

@end
