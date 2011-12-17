//
//  DataController.h
//  vc-mobile
//
//  Created by Ирина Дидковская on 17.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface DataController : NSObject
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


+ (DataController *)sharedDataController;
- (void)saveUserToCoreData:(NSString *)userName countryShip:(NSString *)cs;
- (BOOL)ifUserExist;
@end
