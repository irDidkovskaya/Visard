//
//  Visa.h
//  vc-mobile
//
//  Created by Alexandr Fal' on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Country, Requirement;

@interface Visa : NSManagedObject

@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSNumber * isFavorite;
@property (nonatomic, retain) Country *country;
@property (nonatomic, retain) NSSet *requirements;
@end

@interface Visa (CoreDataGeneratedAccessors)

- (void)addRequirementsObject:(Requirement *)value;
- (void)removeRequirementsObject:(Requirement *)value;
- (void)addRequirements:(NSSet *)values;
- (void)removeRequirements:(NSSet *)values;

@end
