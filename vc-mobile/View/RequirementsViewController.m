//
//  RequirementsViewController.m
//  vc-mobile
//
//  Created by Ирина Дидковская on 24.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RequirementsViewController.h"


@implementation RequirementsViewController
@synthesize typeVisa;
@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize managedObjectContext, requirements;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStylePlain];
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

- (void)dealloc {
    
    self.typeVisa = nil;
    self.fetchedResultsController = nil;
    self.managedObjectContext = nil;
    self.requirements = nil;
    
    [super dealloc];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 10 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = requirements.name;
    cell.detailTextLabel.text = requirements.value;
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    if (!indexPath.row) {
//        
//        return 44.0f;
//    }
//    else
//    {
//        NSDictionary *details = [NSDictionary dictionary];
//        NSArray *list = [details objectForKey:@"analysisDetailsItems"];
//        NSDictionary *obj = [list objectAtIndex:indexPath.section];
//        NSArray *subItems = [obj objectForKey:@"subItems"];
//        int index = 0;
//        if ([subItems count] > 1) {
//            index = indexPath.row-1;
//        }
//        NSDictionary *detail = [subItems objectAtIndex:index];
//        NSString *cellText = @"";
//        
//        if ([detail objectForKey:@"headLine"]) {
//            
//            
//            NSString *descript = [detail objectForKey:@"description"];
//            NSString *headLine = [detail objectForKey:@"headLine"];
//            if ([descript isEqual:[NSNull null]]) {
//                descript = @"";
//            }
//            if ([headLine isEqual:[NSNull null]]) {
//                headLine = @"";
//            } else {
//                headLine = [NSString stringWithFormat:@"%@\n", headLine];
//            }
//            NSString *text = [NSString stringWithFormat:@"%@%@", headLine, descript];
//            cellText = text;
//        }
//        else
//        {
//            NSString *descript = [detail objectForKey:@"description"];
//            if ([descript isEqual:[NSNull null]]) {
//                descript = @"";
//            }
//            cellText = descript;
//        }
//        
//        UIFont *cellFont = [UIFont systemFontOfSize:13.0];
//        CGSize constraintSize = CGSizeMake(320.0f, MAXFLOAT);
//        CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
//        
//        return labelSize.height + 45.0f;
//    }
    
    
    
    
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    if (!indexPath.row)
//    {
//        // only first row toggles exapand/collapse
//        [tableView deselectRowAtIndexPath:indexPath animated:YES];
//        
//        NSInteger section = indexPath.section;
//        //BOOL currentlyExpanded = [expandedSections containsIndex:section];
//        NSInteger rows;
//        
//        
//        NSMutableArray *tmpArray = [NSMutableArray array];
//        
//        if (currentlyExpanded)
//        {
//            rows = [self tableView:tableView numberOfRowsInSection:section];
//            [expandedSections removeIndex:section];
//            
//        }
//        else
//        {
//            [expandedSections addIndex:section];
//            rows = [self tableView:tableView numberOfRowsInSection:section];
//        }
//        
//        NSLog(@"rows = %d", rows);
//        for (int i=1; i<rows; i++)
//        {
//            NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:i 
//                                                           inSection:section];
//            [tmpArray addObject:tmpIndexPath];
//        }
//        
//        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//        
//        if (currentlyExpanded)
//        {
//            [tableView deleteRowsAtIndexPaths:tmpArray 
//                             withRowAnimation:UITableViewRowAnimationTop];
//            
//            cell.accessoryView = [ISCustomAccessory accessoryWithColor:[UIColor grayColor] type:ISCustomAccessoryTypeDown];
//            
//        }
//        else
//        {
//            [tableView insertRowsAtIndexPaths:tmpArray 
//                             withRowAnimation:UITableViewRowAnimationTop];
//            cell.accessoryView =  [ISCustomAccessory accessoryWithColor:[UIColor grayColor] type:ISCustomAccessoryTypeUp];
//            
//        }
//    }
    
}



@end
