//
//  DataController.m
//  vc-mobile
//
//  Created by Ирина Дидковская on 17.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DataController.h"
#import "NetworkController.h"
#import "AppDelegate.h"

#import "User.h"
#import "Country.h"
#import "Visa.h"
#import "Requirement.h"
#import "Advice.h"
#import "Consulate.h"

@interface DataController () 

- (void)updateIsFavoriteState:(BOOL)isFavorite forCountry:(NSString *)countryName;
- (void)updateIsFavoriteState:(BOOL)isFavorite forVisaWithCountry:(NSString *)countryName andType:(NSString *)visaType;

@end

@implementation DataController

@synthesize managedObjectContext;

+ (DataController *)sharedDataController
{
    static DataController *_sharedDataController = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedDataController = [[self alloc] init];
        
        // You additional setup goes here...
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        _sharedDataController.managedObjectContext = appDelegate.managedObjectContext;
        
        
    });
    
    return _sharedDataController;
}

- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateRequirementWithNotification:) name:@"AppDidReceiveLocalNotification" object:nil];
    }
    return self;
}

- (void)saveUserToCoreData:(NSString *)userName countryShip:(NSString *)cs {
    
    User *user = (User *)[NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    
    user.name = userName;
    user.citezenShip = cs;
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Problem saving MOC: %@", [error localizedDescription]);
    }
    
}

- (BOOL)ifUserExist {
    
    BOOL ifUserExist = NO;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *checkData = [[NSFetchRequest alloc] init];
    [checkData setEntity:entity];
    NSError *error;
    NSArray *results = [self.managedObjectContext executeFetchRequest:checkData error:&error];
    if ([results count]) {
        ifUserExist = YES;
    }
    return ifUserExist;
}

#pragma mark - DB filling

- (void)updateCoreData
{
    [[NetworkController sharedNetworkController] loadData];
}

- (void)updateCoreDataWithDataArray:(NSArray *)dataArray
{
    NSEntityDescription *country = [NSEntityDescription entityForName:@"Country" inManagedObjectContext:self.managedObjectContext];
    
    NSFetchRequest *countryRequest = [[NSFetchRequest alloc] init];
    [countryRequest setEntity:country];
    
    NSError *error;
    NSArray *results = [self.managedObjectContext executeFetchRequest:countryRequest error:&error];
    if ([results count]) {
        return;
    }
    
    for (NSDictionary *countryDict in dataArray) {
        
        // Country
        Country *newCountry = [NSEntityDescription insertNewObjectForEntityForName:@"Country" inManagedObjectContext:self.managedObjectContext];
        newCountry.name = [countryDict objectForKey:@"name"];
        newCountry.itemId = [countryDict objectForKey:@"code"];
        newCountry.image = [countryDict objectForKey:@"img"];
        newCountry.group = [countryDict objectForKey:@"group"];
        newCountry.partOfTheWorld = [countryDict objectForKey:@"partOfTheWorld"];
        newCountry.isFavorite = [NSNumber numberWithBool:NO];
        
        // Consulates
        NSArray *consulates = [countryDict objectForKey:@"consulates"];
//        NSLog(@"counslulates for %@: %@", newCountry.name, consulates);
        for (NSDictionary *consulateDict in consulates) {
            Consulate *newConsulate = [NSEntityDescription insertNewObjectForEntityForName:@"Consulate" inManagedObjectContext:self.managedObjectContext];        
            newConsulate.countryId = newCountry.itemId;
            newConsulate.country = newCountry;
            newConsulate.city = [consulateDict objectForKey:@"city"];
            newConsulate.address = [consulateDict objectForKey:@"address"];
            newConsulate.email = [consulateDict objectForKey:@"e-mail"];
            newConsulate.phone = [consulateDict objectForKey:@"phone"];
            newConsulate.site = [consulateDict objectForKey:@"site"];
            newConsulate.price = [consulateDict objectForKey:@"price"];
            newConsulate.workTime = [consulateDict objectForKey:@"timeWork"];
            newConsulate.latitude = [consulateDict objectForKey:@"latitude"];
            newConsulate.longitude = [consulateDict objectForKey:@"longitude"];
        }
        
        // Visas
        NSArray *visas = [countryDict objectForKey:@"visas"];
        for (NSDictionary *visaDict in visas) {
            Visa *newVisa = [NSEntityDescription insertNewObjectForEntityForName:@"Visa" inManagedObjectContext:self.managedObjectContext];
            newVisa.country = newCountry;
            newVisa.type = [visaDict objectForKey:@"type"];
            newVisa.image = [visaDict objectForKey:@"img"];
            
            // Requirements
            NSArray *requirements = [visaDict objectForKey:@"requirements"];
            for (NSDictionary *requirementDict in requirements) {
                Requirement *newRequirement = [NSEntityDescription insertNewObjectForEntityForName:@"Requirement" inManagedObjectContext:self.managedObjectContext];        
                newRequirement.visa = newVisa;
                newRequirement.name = [requirementDict objectForKey:@"name"];
                newRequirement.value = [requirementDict objectForKey:@"value"];
            }
        }
        
        // Advice 
        Advice *newAdvice = [NSEntityDescription insertNewObjectForEntityForName:@"Advice" inManagedObjectContext:self.managedObjectContext];
        newAdvice.country = newCountry;
        newAdvice.discriptionText = [countryDict objectForKey:@"advice"];
    }
    
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Problem saving MOC: %@", [error localizedDescription]);
    }
}

#pragma mark - Adding Country to/Removing from Favorites

- (void)updateIsFavoriteState:(BOOL)isFavorite forCountry:(NSString *)countryName
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Country" inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predCountry = [NSPredicate predicateWithFormat:@"name == %@", countryName];
    [fetchRequest setPredicate:predCountry];
    
    NSError *error = nil;
    Country *targetCountry = [[self.managedObjectContext executeFetchRequest:fetchRequest error:&error] lastObject];
    
    if (targetCountry) {
        targetCountry.isFavorite = [NSNumber numberWithBool:isFavorite];
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Problem saving MOC: %@", [error localizedDescription]);
        }
        NSLog(@"country: %@ added to favorites", countryName);
    }
}

- (void)addToFavoritesCountryWithName:(NSString *)countryName
{
    [self updateIsFavoriteState:YES forCountry:countryName];
}

- (void)removeFromFavoritesCountryWithName:(NSString *)countryName
{
    [self updateIsFavoriteState:NO forCountry:countryName];
}

#pragma mark - Adding Visa to/Removing from Favorites

- (void)updateIsFavoriteState:(BOOL)isFavorite forVisaWithCountry:(NSString *)countryName andType:(NSString *)visaType
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Visa" inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predCountry = [NSPredicate predicateWithFormat:@"country.name == %@", countryName];
    NSPredicate *predVisa = [NSPredicate predicateWithFormat:@"type == %@", visaType];
    NSPredicate *compoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:predCountry, predVisa, nil]];
    
    [fetchRequest setPredicate:compoundPredicate];
    
    NSError *error = nil;
    Visa *targetVisa = [[self.managedObjectContext executeFetchRequest:fetchRequest error:&error] lastObject];
    
    if (targetVisa) {
        targetVisa.isFavorite = [NSNumber numberWithBool:isFavorite];
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Problem saving MOC: %@", [error localizedDescription]);
        }
        NSLog(@"visa with type: %@ for country: %@ added to favorites", visaType, countryName);
    }
}

- (void)addToFavoritesVisaWithCountry:(NSString *)countryName andType:(NSString *)visaType
{
    [self updateIsFavoriteState:YES forVisaWithCountry:countryName andType:visaType];
}

- (void)removeFromFavoritesVisaWithCountry:(NSString *)countryName andType:(NSString *)visaType
{
    [self updateIsFavoriteState:NO forVisaWithCountry:countryName andType:visaType];

}

- (void)updateRequirementWithName:(NSString *)requirementName forVisa:(Visa *)targetVisa withDoneOption:(BOOL)isDone
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Requirement" inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predCountry = [NSPredicate predicateWithFormat:@"name == %@", requirementName];
    NSPredicate *predVisa = [NSPredicate predicateWithFormat:@"visa == %@", targetVisa];
    NSPredicate *compoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:predCountry, predVisa, nil]];
    
    [fetchRequest setPredicate:compoundPredicate];
    
    NSError *error = nil;
    Requirement *targetRequirement = [[self.managedObjectContext executeFetchRequest:fetchRequest error:&error] lastObject];
    
    if (targetRequirement) {
        targetRequirement.isDone = [NSNumber numberWithBool:isDone];
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Problem saving MOC: %@", [error localizedDescription]);
        }
        NSLog(@"Requirement with name: %@ for visa:%@ for country: %@ is Done: %@", requirementName, targetVisa.type, targetVisa.country.name, [NSNumber numberWithBool:isDone]);
    }
}

- (void)updateRequirementWithName:(NSString *)requirementName forVisa:(Visa *)targetVisa withRemiderDate:(NSDate *)reminderDate
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Requirement" inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predCountry = [NSPredicate predicateWithFormat:@"name == %@", requirementName];
    NSPredicate *predVisa = [NSPredicate predicateWithFormat:@"visa == %@", targetVisa];
    NSPredicate *compoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:predCountry, predVisa, nil]];
    
    [fetchRequest setPredicate:compoundPredicate];
    
    NSError *error = nil;
    Requirement *targetRequirement = [[self.managedObjectContext executeFetchRequest:fetchRequest error:&error] lastObject];
    
    if (targetRequirement) {
        targetRequirement.reminderDate = reminderDate;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Problem saving MOC: %@", [error localizedDescription]);
        }
        NSLog(@"Requirement with name: %@ for visa:%@ for country: %@ reminder date: %@", requirementName, targetVisa.type, targetVisa.country.name, reminderDate);
    }
}

- (void)scheduleRemiderForRequirementWithName:(NSString *)requirementName forVisa:(Visa *)targetVisa withRemiderDate:(NSDate *)remiderDate
{
    NSString *notificationId = [NSString stringWithFormat:@"%@_%@_%@", requirementName, targetVisa, targetVisa.country.name];
    
    // Cancel notification if it was scheduled before
    for(UILocalNotification *notif in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
        if([[notif.userInfo objectForKey:@"notificationId"] isEqualToString:notificationId]) {
            [[UIApplication sharedApplication] cancelLocalNotification:notif];
            break;
        }
    }
    if (remiderDate) {
        
        NSDictionary *notificationUserInfo = [NSDictionary dictionaryWithObjectsAndKeys:notificationId, @"notificationId", requirementName, @"requirementName", targetVisa.type, @"visaType", targetVisa.country.name, @"countryName", nil];
        UIApplication *app = [UIApplication sharedApplication];
        
        // Create a new notification.
        UILocalNotification *alarm = [[[UILocalNotification alloc] init] autorelease];
        if (alarm)
        {
            alarm.fireDate = remiderDate;
            alarm.timeZone = [NSTimeZone defaultTimeZone];
            alarm.repeatInterval = 0;
            alarm.soundName = UILocalNotificationDefaultSoundName;
            alarm.alertBody = NSLocalizedString(requirementName, nil);
            alarm.userInfo = notificationUserInfo;
            
            [app scheduleLocalNotification:alarm];
        }
    } 
}

#pragma mark - Notification Handling

- (void)updateRequirementWithNotification:(NSNotification *)note
{
    NSDictionary *ui = [note userInfo];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Visa" inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predCountry = [NSPredicate predicateWithFormat:@"country.name == %@", [ui objectForKey:@"countryName"]];
    NSPredicate *predVisa = [NSPredicate predicateWithFormat:@"type == %@", [ui objectForKey:@"visaType"]];
    NSPredicate *compoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:predCountry, predVisa, nil]];
    
    [fetchRequest setPredicate:compoundPredicate];
    
    NSError *error = nil;
    Visa *targetVisa = [[self.managedObjectContext executeFetchRequest:fetchRequest error:&error] lastObject];
    
    [self updateRequirementWithName:[ui objectForKey:@"requirementName"] forVisa:targetVisa withRemiderDate:nil];
}

@end
