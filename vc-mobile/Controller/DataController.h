//
//  DataController.h
//  vc-mobile
//
//  Created by Ирина Дидковская on 17.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Visa.h"

@interface DataController : NSObject
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


+ (DataController *)sharedDataController;
- (void)saveUserToCoreData:(NSString *)userName countryShip:(NSString *)cs;
- (BOOL)ifUserExist;
- (void)updateCoreData;
- (void)updateCoreDataWithDataArray:(NSArray *)dataArray;

- (void)addToFavoritesCountryWithName:(NSString *)countryName;
- (void)removeFromFavoritesCountryWithName:(NSString *)countryName;

- (void)addToFavoritesVisaWithCountry:(NSString *)countryName andType:(NSString *)visaType;
- (void)removeFromFavoritesVisaWithCountry:(NSString *)countryName andType:(NSString *)visaType;

- (void)updateRequirementWithName:(NSString *)requirementName forVisa:(Visa *)targetVisa withDoneOption:(BOOL)isDone;

@end
