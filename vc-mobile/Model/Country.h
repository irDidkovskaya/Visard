//
//  Country.h
//  vc-mobile
//
//  Created by Ирина Дидковская on 17.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Advice, Consulate;

@interface Country : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * itemId;
@property (nonatomic, retain) NSString * isFavorite;
@property (nonatomic, retain) NSSet *requirements;
@property (nonatomic, retain) NSSet *consulates;
@property (nonatomic, retain) NSSet *advices;
@end

@interface Country (CoreDataGeneratedAccessors)

- (void)addRequirementsObject:(NSManagedObject *)value;
- (void)removeRequirementsObject:(NSManagedObject *)value;
- (void)addRequirements:(NSSet *)values;
- (void)removeRequirements:(NSSet *)values;

- (void)addConsulatesObject:(Consulate *)value;
- (void)removeConsulatesObject:(Consulate *)value;
- (void)addConsulates:(NSSet *)values;
- (void)removeConsulates:(NSSet *)values;

- (void)addAdvicesObject:(Advice *)value;
- (void)removeAdvicesObject:(Advice *)value;
- (void)addAdvices:(NSSet *)values;
- (void)removeAdvices:(NSSet *)values;

@end
