//
//  Country.h
//  vc-mobile
//
//  Created by Alexandr Fal' on 12/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Advice, Consulate;

@interface Country : NSManagedObject

@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * isFavorite;
@property (nonatomic, retain) NSString * itemId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *advices;
@property (nonatomic, retain) NSSet *consulates;
@property (nonatomic, retain) NSSet *visas;
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

- (void)addVisasObject:(NSManagedObject *)value;
- (void)removeVisasObject:(NSManagedObject *)value;
- (void)addVisas:(NSSet *)values;
- (void)removeVisas:(NSSet *)values;

@end
