//
//  FavoriteCountriesVC.m
//  vc-mobile
//
//  Created by Alexandr Fal' on 1/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FavoriteCountriesVC.h"
#import "VCountryViewController.h"
#import "Country.h"
#import "DataController.h"


@implementation FavoriteCountriesVC

@synthesize fetchedResultsController = __fetchedResultsController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
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

    self.navigationItem.title = NSLocalizedString(@"Favorites", nil);
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    VCountryViewController *vc = [[VCountryViewController alloc] init];
    
    NSString *code = nil;
    NSString *img = nil;
    NSString *name = nil;
    NSString *text = nil;
    
    if (self.filteredCountries) {
        Country *currCountry = (Country *)[self.filteredCountries objectAtIndex:indexPath.row];
        code = currCountry.itemId;
        img = currCountry.image;
        name = currCountry.name;
        //text = currCountry.advices;
    } else {
        Country *currCountry = (Country *)[self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.row];
        code = currCountry.itemId;
        img = currCountry.image;
        name = currCountry.name;
        //text = currCountry.advices;
    }
    NSLog(@"code = %@", code);
    vc.code = code;
    vc.img = img;
    vc.name = name;
    vc.text = text;
    
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
    
}

#pragma mark - Table View Editing

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Country *country = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.row];
        
        [[DataController sharedDataController] removeFromFavoritesCountryWithName:country.name];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"isFavorite == %@", [NSNumber numberWithBool:YES]];
    [fetchRequest setPredicate:pred];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES] autorelease];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil] autorelease];
    aFetchedResultsController.delegate = self;
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
