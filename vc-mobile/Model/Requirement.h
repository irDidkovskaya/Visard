//
//  Requirement.h
//  vc-mobile
//
//  Created by Alexandr Fal' on 2/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Visa;

@interface Requirement : NSManagedObject

@property (nonatomic, retain) NSNumber * isDone;
@property (nonatomic, retain) NSNumber * isRequired;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * value;
@property (nonatomic, retain) NSDate * reminderDate;
@property (nonatomic, retain) Visa *visa;

@end
