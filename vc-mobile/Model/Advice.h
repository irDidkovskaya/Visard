//
//  Advice.h
//  vc-mobile
//
//  Created by Ирина Дидковская on 17.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Advice : NSManagedObject

@property (nonatomic, retain) NSString * discriptionText;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSManagedObject *countries;

@end
