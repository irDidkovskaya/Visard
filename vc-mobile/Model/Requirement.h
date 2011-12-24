//
//  Requirement.h
//  vc-mobile
//
//  Created by Ирина Дидковская on 24.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Visa;

@interface Requirement : NSManagedObject

@property (nonatomic, retain) NSNumber * isDone;
@property (nonatomic, retain) NSNumber * isRequired;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * value;
@property (nonatomic, retain) Visa *visa;

@end
