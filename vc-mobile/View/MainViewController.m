//
//  MainViewController.m
//  vc-mobile
//
//  Created by Ирина Дидковская on 22.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "CountrySelectorVC.h"
#import "FavoriteCountriesVC.h"
#import "AppStyle.h"

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
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    
    self.tableView.separatorColor = [AppStyle colorForSeparatorInTable];
    self.navigationController.navigationBar.tintColor = [AppStyle colorForNavigationBar];
    self.navigationItem.title = NSLocalizedString(@"Visard", nil);
    
//    self.navigationController.navigationBarHidden = YES;
    
    self.tableView.backgroundColor = [AppStyle backgroundColor];
    
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)] autorelease];
    self.tableView.tableHeaderView = headerView;
    
    self.clearsSelectionOnViewWillAppear = YES;
}

- (void)dealloc 
{
    self.managedObjectContext = nil;
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
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
//    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
//    self.navigationController.navigationBarHidden = NO;
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
            cell.imageView.image = [UIImage imageNamed:@"search.png"];
        }
            break;
        case 1: {
            cell.textLabel.text = NSLocalizedString(@"Безвизовые", nil);
            cell.imageView.image = [UIImage imageNamed:@"noVisa.png"];
        }
            break;
        case 2: {
            cell.textLabel.text = NSLocalizedString(@"Визовые", nil);
            cell.imageView.image = [UIImage imageNamed:@"Visa.png"];
        }
            break;
        case 3: {
            cell.textLabel.text = NSLocalizedString(@"Шенген", nil);
            cell.imageView.image = [UIImage imageNamed:@"eu.png"];
        }
            break;
            
        case 4: {
            cell.textLabel.text = NSLocalizedString(@"Избранное", nil);
            cell.imageView.image = [UIImage imageNamed:@"favorit.png"];
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}



- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0: // All countries
        {  
            CountrySelectorVC *vc = [[[CountrySelectorVC alloc] init] autorelease];
            vc.managedObjectContext = self.managedObjectContext;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1: // No Visa countries
        {
            CountrySelectorVC *vc = [[[CountrySelectorVC alloc] initWithGroupNumber:[NSNumber numberWithInt:1]] autorelease];
            vc.managedObjectContext = self.managedObjectContext;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2: // Visa countries
        {
            CountrySelectorVC *vc = [[[CountrySelectorVC alloc] initWithGroupNumber:[NSNumber numberWithInt:2]] autorelease];
            vc.managedObjectContext = self.managedObjectContext;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3: // Shengen
        {
            CountrySelectorVC *vc = [[[CountrySelectorVC alloc] initWithGroupNumber:[NSNumber numberWithInt:0]] autorelease];
            vc.managedObjectContext = self.managedObjectContext;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 4: // Favorite countries
        {
            FavoriteCountriesVC *vc = [[[FavoriteCountriesVC alloc] init] autorelease];
            vc.managedObjectContext = self.managedObjectContext;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }

}

@end
