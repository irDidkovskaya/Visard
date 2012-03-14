//
//  DataController.h
//  vc-mobile
//
//  Created by Ирина Дидковская on 17.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Visa.h"
#import "JSONKit.h"

typedef enum {
    VisaCountrySheepNone,
    VisaCountrySheepUkraine,
    VisaCountrySheepRussia,
} VisaCountrySheep;

@interface DataController : NSObject
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, assign) VisaCountrySheep countrySheep;
@property (nonatomic, retain) NSNumberFormatter *numberFormatter;


+ (DataController *)sharedDataController;
- (void)saveUserToCoreData:(NSString *)userName countryShip:(NSString *)cs;
- (BOOL)ifUserExist;
- (void)updateCoreDataWithCountrySheep:(VisaCountrySheep)csh;
- (void)updateCoreDataWithDataArray:(NSArray *)dataArray;

- (void)addToFavoritesCountryWithName:(NSString *)countryName;
- (void)removeFromFavoritesCountryWithName:(NSString *)countryName;

- (void)addToFavoritesVisaWithCountry:(NSString *)countryName andType:(NSString *)visaType;
- (void)removeFromFavoritesVisaWithCountry:(NSString *)countryName andType:(NSString *)visaType;

- (void)updateRequirementWithName:(NSString *)requirementName forVisa:(Visa *)targetVisa withDoneOption:(BOOL)isDone;
- (void)updateRequirementWithName:(NSString *)requirementName forVisa:(Visa *)targetVisa withRemiderDate:(NSDate *)reminderDate;
- (void)scheduleRemiderForRequirementWithName:(NSString *)requirementName forVisa:(Visa *)targetVisa withRemiderDate:(NSDate *)remiderDate; 

@end
