//
//  Country.h
//  vc-mobile
//
//  Created by Alexandr Fal' on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Advice, Consulate, Requirement;

@interface Country : NSManagedObject

@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * isFavorite;
@property (nonatomic, retain) NSString * itemId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *advices;
@property (nonatomic, retain) NSSet *consulates;
@property (nonatomic, retain) NSSet *requirements;
@end

@interface Country (CoreDataGeneratedAccessors)

- (void)addAdvicesObject:(Advice *)value;
- (void)removeAdvicesObject:(Advice *)value;
- (void)addAdvices:(NSSet *)values;
- (void)removeAdvices:(NSSet *)values;

- (void)addConsulatesObject:(Consulate *)value;
- (void)removeConsulatesObject:(Consulate *)value;
- (void)addConsulates:(NSSet *)values;
- (void)removeConsulates:(NSSet *)values;

- (void)addRequirementsObject:(Requirement *)value;
- (void)removeRequirementsObject:(Requirement *)value;
- (void)addRequirements:(NSSet *)values;
- (void)removeRequirements:(NSSet *)values;

@end
