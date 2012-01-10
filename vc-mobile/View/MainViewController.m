//
//  MainViewController.m
//  vc-mobile
//
//  Created by Ирина Дидковская on 22.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "CountrySelectorVC.h"


@implementation MainViewController
@synthesize managedObjectContext;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
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

    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:7/255.0 green:200/255.0 blue:98/255.0 alpha:1];
    self.navigationItem.title = NSLocalizedString(@"Visard", nil);
    
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mainBg.png"]];
    
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)] autorelease];
    self.tableView.tableHeaderView = headerView;
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = YES;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)dealloc 
{
    self.managedObjectContext = nil;
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
    return 5;
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
    
    switch (indexPath.row) {
        case 0: {
            cell.textLabel.text = NSLocalizedString(@"Поиск по странам", nil);
        }
            break;
        case 1: {
            cell.textLabel.text = NSLocalizedString(@"Безвизовые", nil);
        }
            break;
        case 2: {
            cell.textLabel.text = NSLocalizedString(@"Визовые", nil);
        }
            break;
        case 3: {
            cell.textLabel.text = NSLocalizedString(@"Шенген", nil);
        }
            break;
            
        case 4: {
            cell.textLabel.text = NSLocalizedString(@"Избранное", nil);
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0: {
            CountrySelectorVC *vc = [[CountrySelectorVC alloc] init];
            vc.managedObjectContext = self.managedObjectContext;
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
        }
            break;
        case 1: {
            
        }
            break;
        case 2: {
            
        }
            break;
        case 3: {
            
        }
            break;
            
        case 4: {
            
        }
            break;
        case 5: {
            
        }
            break;
            
        default:
            break;
    }

}

@end
