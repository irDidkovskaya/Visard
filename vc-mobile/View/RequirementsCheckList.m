//
//  ChackListsesViewController.m
//  vc-mobile
//
//  Created by Ирина Дидковская on 23.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RequirementsCheckList.h"
#import "AppStyle.h"
#import "DataController.h"

@interface RequirementsCheckList() {
@private
    
}

@property (nonatomic, retain) NSArray *cellHeights;

@end

@implementation RequirementsCheckList

@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize managedObjectContext;
@synthesize cellHeights;

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

- (void)dealloc
{
    self.cellHeights = nil;
    
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = YES;
    self.navigationController.navigationBar.tintColor = [AppStyle colorForNavigationBar];
    self.navigationItem.backBarButtonItem.title = NSLocalizedString(@"Back", nil);
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.cellHeights = [NSArray array];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.fetchedResultsController.fetchedObjects count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Requirement *requirement = (Requirement *)[self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.row];
    NSString *cellText = requirement.name;
    
    UIFont *cellFont = [UIFont boldSystemFontOfSize:17.0];
    CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    
    CGFloat heightForCell = labelSize.height + 20.0f;
    if (heightForCell < 44) {
        heightForCell = 44;
    }
//    NSLog(@"heightForCell: %f", heightForCell);
    
    self.cellHeights = [self.cellHeights arrayByAddingObject:[NSNumber numberWithFloat:heightForCell]];
    
    return heightForCell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil] autorelease];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
        
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    CGFloat curCellHeight = [[self.cellHeights objectAtIndex:indexPath.row] floatValue];
    UIView *cellView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, curCellHeight)] autorelease];
    cellView.backgroundColor = [UIColor clearColor];
    
    Requirement *requirement = (Requirement *)[self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.row];
    
    // Label
    UILabel *cellLabel = [[[UILabel alloc] initWithFrame:CGRectMake(40, 0, 280, curCellHeight)] autorelease];
    cellLabel.backgroundColor = [UIColor clearColor];
    cellLabel.font = [UIFont boldSystemFontOfSize:17];
    cellLabel.text = requirement.name;
    cellLabel.numberOfLines = 4;
    cellLabel.lineBreakMode = UILineBreakModeWordWrap;
    cellLabel.textAlignment = UITextAlignmentLeft;
    [cellView addSubview:cellLabel];
    
    // Checkbox button
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(5, (curCellHeight - 30)/2, 30, 30);
    //[smsBtn setImage:[UIImage imageNamed:@"checkbox_sms_grey.png"] forState:UIControlStateHighlighted];
    if ([requirement.isDone boolValue]) {
        [btn setImage:[UIImage imageNamed:@"Checkbox_checked.png"] forState:UIControlStateNormal];
    } else { 
        [btn setImage:[UIImage imageNamed:@"Checkbox_unchecked.png"] forState:UIControlStateNormal];
    }
    btn.tag = indexPath.row;
    [btn addTarget:self action:@selector(changeisDoneOption:) forControlEvents:UIControlEventTouchUpInside];
    [cellView addSubview:btn];
    
    cell.accessoryView = cellView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - NSFetchedResultsController

- (NSFetchedResultsController *)fetchedResultsController
{
    if (__fetchedResultsController != nil) {
        return __fetchedResultsController;
    }
    
    // Set up the fetched results controller.
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
    // Edit the entity name as appropriate.
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Requirement" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    NSPredicate *predCountry = [NSPredicate predicateWithFormat:@"visa.country.name == %@", self.countryName];
    NSPredicate *predVisa = [NSPredicate predicateWithFormat:@"visa.type == %@", self.visaType];
    NSPredicate *comp = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:predCountry, predVisa, nil]];
    
    //NSCompoundPredicate *compPred = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:predCountry, predVisa, nil]];
    
    [fetchRequest setPredicate:comp];
    
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

#pragma mark - checkbox button actions

- (void)changeisDoneOption:(UIButton *)sender
{
    Requirement *targetReq = [self.fetchedResultsController.fetchedObjects objectAtIndex:sender.tag];
    NSInteger reqDoneOption = abs([targetReq.isDone intValue] - 1);
    [[DataController sharedDataController] updateRequirementWithName:targetReq.name forVisa:targetReq.visa withDoneOption:reqDoneOption];
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}

@end
