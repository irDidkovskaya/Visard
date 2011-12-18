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
#import "Requirement.h"
#import "Advice.h"
#import "Consulate.h"

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

- (void)updateCountiesList
{
    [[NetworkController sharedNetworkController] updateCountiesList];
}

- (void)updateDBWithCountriesList:(NSArray *)updatedCountries
{
    NSEntityDescription *country = [NSEntityDescription entityForName:@"Country" inManagedObjectContext:self.managedObjectContext];
    
    NSFetchRequest *countryRequest = [[NSFetchRequest alloc] init];
    [countryRequest setEntity:country];
    
    NSError *error;
    NSArray *results = [self.managedObjectContext executeFetchRequest:countryRequest error:&error];
    if ([results count]) {
        return;
    }
    
    for (NSDictionary *countryDict in updatedCountries) {
        Country *newCountry = [NSEntityDescription insertNewObjectForEntityForName:@"Country" inManagedObjectContext:self.managedObjectContext];
        
        newCountry.name = [countryDict objectForKey:@"name"];
        newCountry.itemId = [countryDict objectForKey:@"code"];
        newCountry.image = [countryDict objectForKey:@"img"];
    }
    
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Problem saving MOC: %@", [error localizedDescription]);
    }
}

@end
