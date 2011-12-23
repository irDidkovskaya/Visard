//
//  CountryViewController.m
//  vc-mobile
//
//  Created by Ирина Дидковская on 17.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CountryViewController.h"
#import "UISegmentedControl+CustomTintExtension.h"
#import "ConsulateLocationViewController.h"
#import "AppDelegate.h"
#import "Consulate.h"
#import "Requirement.h"
#import "ConsulateViewController.h"

@implementation CountryViewController
@synthesize requirement, user, tableView = tableView_;
@synthesize fetchedResultsController = __fetchedResultsController, managedObjectContext, code, img, name, text;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.managedObjectContext = appDelegate.managedObjectContext;
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.managedObjectContext = appDelegate.managedObjectContext;
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

- (UIView *)headerView {
    
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 70)] autorelease];
    UILabel *countryName = [[[UILabel alloc] initWithFrame:CGRectMake(100, 25, 0, 0)] autorelease];
    headerView.backgroundColor = [UIColor colorWithRed:215/255.0 green:250/255.0 blue:232/255.0 alpha:1];
    countryName.text = self.name;
    
    countryName.backgroundColor = [UIColor clearColor];
    
    [countryName sizeToFit];
    
    
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(12, 12, 66, 44)];
    
    [iv setImage:[UIImage imageNamed:self.img]];
    
    [headerView addSubview:iv];
    [headerView addSubview:countryName];
    return headerView;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    NSLog(@"fetched objects: %@", self.fetchedResultsController.fetchedObjects);
    
    self.navigationItem.title = self.name;
    
    UIView *scView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)] autorelease];
    scView.backgroundColor = [UIColor colorWithRed:215/255.0 green:250/255.0 blue:232/255.0 alpha:1];
    
    NSArray *itemArray = [NSArray arrayWithObjects: NSLocalizedString(@"Консульство", nil) , NSLocalizedString(@"Требование", nil), NSLocalizedString(@"Советы", nil), nil];
    UISegmentedControl *segmentedControl = [[[UISegmentedControl alloc] initWithItems:itemArray] autorelease];
    segmentedControl.frame = CGRectMake(50, 7, 250, 30);
	segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
	segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = [UIColor colorWithRed:7/255.0 green:200/255.0 blue:98/255.0 alpha:1];
    [segmentedControl addTarget:self
	                     action:@selector(pickOne:)
	           forControlEvents:UIControlEventValueChanged];
    
    [segmentedControl setTag:0 forSegmentAtIndex:0];
    [segmentedControl setTag:0 forSegmentAtIndex:1];
    [segmentedControl setTag:0 forSegmentAtIndex:2];
    [self setTextColorsForSegmentedControl:segmentedControl];
    [scView addSubview:segmentedControl];

    
    [self.view addSubview:scView];
    
    //[self.view addSubview:[self headerView]];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:7/255.0 green:200/255.0 blue:98/255.0 alpha:1];
    if (segmentedControl.selectedSegmentIndex == 0) {
        
        UITableView *tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        tv.delegate = self;
        tv.dataSource = self;
        self.tableView = tv;
         [self.view addSubview:self.tableView];
        currSigmentControll = 0;
    }
    
    
    
   
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)setTextColorsForSegmentedControl:(UISegmentedControl*)segmented {
   [segmented setTextColor:[UIColor blackColor] forTag:0]; 

}

- (void) pickOne:(id)sender{
    UISegmentedControl *sc = (UISegmentedControl *)sender;
    currSigmentControll = sc.selectedSegmentIndex;
    switch (sc.selectedSegmentIndex) {
        case 0: {
            UITableView *tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
            self.fetchedResultsController = nil;
            tv.delegate = self;
            tv.dataSource = self;
            self.tableView = tv;
            [self.view addSubview:self.tableView];
            [self.tableView reloadData];
        }
            break;
        case 1: {
            UITableView *tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
            self.fetchedResultsController = nil;
            tv.delegate = self;
            tv.dataSource = self;
            self.tableView = tv;
            [self.view addSubview:self.tableView];
            [self.tableView reloadData];
        }
            break;
        case 2: {
            
            [self.tableView removeFromSuperview];
            UITextView *tv = [[UITextView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height)];
            tv.text = @"This app halp you find all information about the visa";
            [self.view addSubview:tv];
        }
            break;
        default:
            break;
    }
    
    
    
    //label.text = [segmentedControl titleForSegmentAtIndex: [segmentedControl selectedSegmentIndex]];
}


- (void)dealloc {
    
    self.requirement = nil;
    self.user = nil;
    self.tableView = nil;
    self.code = nil;
    self.fetchedResultsController = nil;
    self.managedObjectContext = nil;
    self.img = nil;
    self.name = nil;
    self.text = nil;
    [super dealloc];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
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
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
   [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (currSigmentControll == 0) {
        Consulate *currConsulate = (Consulate *)[self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.row];
        
        ConsulateViewController *vc = [[ConsulateViewController alloc] init];
        vc.consulate = currConsulate;
        vc.countryName = self.name;
        vc.img = self.img;
        
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    } else {
        
        
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
    if (currSigmentControll == 0) {
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Consulate" inManagedObjectContext:self.managedObjectContext];
        [fetchRequest setEntity:entity];
        
        // Set the batch size to a suitable number.
        [fetchRequest setFetchBatchSize:20];
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"countryId == %@", self.code];
        
        [fetchRequest setPredicate:pred];
        
        // Edit the sort key as appropriate.
        NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"city" ascending:YES] autorelease];
        NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
        
        [fetchRequest setSortDescriptors:sortDescriptors];
        
    } else {
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Requirement" inManagedObjectContext:self.managedObjectContext];
        [fetchRequest setEntity:entity];
        
        // Set the batch size to a suitable number.
        [fetchRequest setFetchBatchSize:20];
        NSLog(@"self.name = %@", self.name);
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"country.name == %@", self.name];
        
        [fetchRequest setPredicate:pred];
        
        // Edit the sort key as appropriate.
        NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES] autorelease];
        NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
        
        [fetchRequest setSortDescriptors:sortDescriptors]; 
        
        
    }
    
    
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


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    if (currSigmentControll == 0) {
        Consulate *consulate = (Consulate *)[self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.row];
        cell.textLabel.text = consulate.city;
        cell.detailTextLabel.text = consulate.address;
    } else {
        
        Requirement *requir = (Requirement *)[self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.row];
        
        cell.textLabel.text = requir.name;
        cell.detailTextLabel.text = requir.value;
        
    }
}

@end
