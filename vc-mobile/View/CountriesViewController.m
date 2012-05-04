//
//  CountriesViewController.m
//  vc-mobile
//
//  Created by Alexandr Fal' on 1/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CountriesViewController.h"
#import "Country.h"
#import "CountryViewController.h"
#import "User.h"
#import "AppStyle.h"
#import <QuartzCore/QuartzCore.h>


@implementation CountriesViewController

@synthesize managedObjectContext, countrySearchBar;
@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize searchPredicate;
@synthesize filteredCountries;

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
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    
    UISearchBar *sb = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    self.countrySearchBar = sb;
    self.countrySearchBar.delegate = self;
    UITextField *searchBarTextField = [[self.countrySearchBar subviews] objectAtIndex:1];
    searchBarTextField.enablesReturnKeyAutomatically = NO;
    searchBarTextField.returnKeyType = UIReturnKeyDone;
    self.countrySearchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    self.countrySearchBar.tintColor = [AppStyle colorForSearchBar];
    
    self.tableView.tableHeaderView = self.countrySearchBar;
    //self.tableView.backgroundColor = [UIColor colorWithRed:7/255.0 green:200/255.0 blue:98/255.0 alpha:1];
    searching = NO;
    letUserSelectRow = YES;
    
    self.navigationController.navigationBar.tintColor = [AppStyle colorForNavigationBar];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = YES;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)dealloc 
{
    self.managedObjectContext = nil;
    self.fetchedResultsController = nil;
    self.searchPredicate = nil;
    self.filteredCountries = nil;
    
    [super dealloc];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.filteredCountries) {
        return [self.filteredCountries count];
    }
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [self configureCell:cell atIndexPath:indexPath];
    
    
    return cell;
}

- (NSIndexPath *)tableView :(UITableView *)theTableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(letUserSelectRow)
        return indexPath;
    else
        return nil;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    CountryViewController *vc = [[CountryViewController alloc] init];
    
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


//- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
//{
//    [self.tableView beginUpdates];
//}
//
//- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
//           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
//{
//    switch(type) {
//        case NSFetchedResultsChangeInsert:
//            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
//            break;
//            
//        case NSFetchedResultsChangeDelete:
//            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
//            break;
//    }
//}
//
//- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
//       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
//      newIndexPath:(NSIndexPath *)newIndexPath
//{
//    UITableView *tableView = self.tableView;
//    
//    switch(type) {
//        case NSFetchedResultsChangeInsert:
//            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
//            break;
//            
//        case NSFetchedResultsChangeDelete:
//            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//            break;
//            
//        case NSFetchedResultsChangeUpdate:
//            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
//            break;
//            
//        case NSFetchedResultsChangeMove:
//            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
//            break;
//    }
//}
//
//- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
//{
//    [self.tableView endUpdates];
//}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    //    NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    //    cell.textLabel.text = [[managedObject valueForKey:@"name"] description];
    Country *currentContry = nil;
    if (self.filteredCountries) {
        currentContry = [self.filteredCountries objectAtIndex:indexPath.row];
    } else {
        currentContry = (Country *)[self.fetchedResultsController objectAtIndexPath:indexPath];
    }
    
    cell.textLabel.text = currentContry.name;
    
    
    cell.imageView.layer.borderWidth = 1;
    cell.imageView.layer.borderColor = [AppStyle colorForSeparatorInTable].CGColor;
    cell.imageView.layer.cornerRadius = 15;
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.image = [UIImage imageNamed:currentContry.image];
    
    // cell.detailTextLabel.text = [[managedObject valueForKey:@"translation"] description];
}

#pragma mark - SearchBar delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([searchText isEqualToString:@""]) {
        self.searchPredicate = nil;
        self.filteredCountries = nil;
    } else {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name BEGINSWITH[cd] %@", searchText];
        self.searchPredicate = predicate;
        NSArray *searchResult = [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:predicate];
        self.filteredCountries = [NSArray arrayWithArray:searchResult];
        NSLog(@"search text: %@", searchText);
        NSLog(@"filtered countries: %@", self.filteredCountries);
    }
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

@end
