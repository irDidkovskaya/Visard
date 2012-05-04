//
//  CountrySelectorVC.m
//  vc-mobile
//
//  Created by Ирина Дидковская on 17.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CountrySelectorVC.h"
#import "Country.h"
#import "CountryViewController.h"
#import "User.h"
#import "AppStyle.h"
#import "DataController.h"

@interface CountrySelectorVC () {
@private
    
}
@end

@implementation CountrySelectorVC

@synthesize managedObjectContext, countrySearchBar;
@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize searchPredicate;
@synthesize filteredCountries;

@synthesize group;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithGroupNumber:(NSNumber *)groupNumber
{
    self = [super init];
    if (self) {
        self.group = groupNumber;
    }
    return self;
}

- (void)dealloc
{
    self.group = nil;
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    switch ([self.group intValue]) {
        case 0:
            if (self.group) {
                self.navigationItem.title = NSLocalizedString(@"Шенген", nil);
            }
            else {
                self.navigationItem.title = NSLocalizedString(@"Поиск по странам", nil);
            }
            break;
        case 1:
            self.navigationItem.title = NSLocalizedString(@"Безвизовые", nil);
            break;
        case 2:
            self.navigationItem.title = NSLocalizedString(@"Визовые", nil);
            break;
        default:
            break;
    }
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (__fetchedResultsController != nil) {
        return __fetchedResultsController;
    }
    
    // Set up the fetched results controller.
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Country" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Set Predicate
    if (self.group) {
        NSPredicate *groupPredicate = [NSPredicate predicateWithFormat:@"group == %@", self.group];
        [fetchRequest setPredicate:groupPredicate];
    }
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES] autorelease];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil] autorelease];
//    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
	    /*
	     Replace this implementation with code to handle the error appropriately.
         
	     abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
	     */
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return __fetchedResultsController;
}    

@end
