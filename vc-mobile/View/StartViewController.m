//
//  StartViewController.m
//  vc-mobile
//
//  Created by Ирина Дидковская on 17.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "StartViewController.h"
#import "ColorfulButton.h"
#import "CountrySelectorVC.h"
#import "DataController.h"


@implementation StartViewController
@synthesize nameField, countryField;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
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
    
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 160)] autorelease];
    UIImageView *logoView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 30, 320, 122)] autorelease];
    
    UIImage *logoImg = [UIImage imageNamed:@"visard.png"];
    
    [logoView setImage:logoImg];
    [headerView addSubview:logoView];
    
    
    return headerView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = NSLocalizedString(@"Start", nil);
    
    self.tableView.backgroundColor = [UIColor colorWithRed:7/255.0 green:200/255.0 blue:98/255.0 alpha:1];
    self.tableView.tableHeaderView = [self headerView];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.nameField = nil;
    self.countryField = nil;
    
    
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return 2;
    } else {
        return 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        UITextField *tf = [[[UITextField alloc] initWithFrame:CGRectMake(10, 15, 280, 30)] autorelease];
        tf.delegate = self;
        tf.placeholder = NSLocalizedString(@"Enter your name", nil);
        self.nameField = tf;
        cell.accessoryView = self.nameField;
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        UITextField *tf = [[[UITextField alloc] initWithFrame:CGRectMake(20, 15, 280, 30)] autorelease];
        tf.delegate = self;
        tf.placeholder = NSLocalizedString(@"Enter your country", nil);
        self.countryField = tf;
        cell.accessoryView = self.countryField;
    } else {
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        ColorfulButton *btn = [[ColorfulButton alloc] initWithFrame:cell.frame topGradientColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1] andBottomGradientColor:[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1]];
        
        [btn setTitleColor:[UIColor colorWithRed:11/255.0 green:121/255.0 blue:5/255.0 alpha:1]  forState:UIControlStateNormal];
        
        
        
        [btn setTitle:NSLocalizedString(@"Start", nil) forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(openCountryList) forControlEvents:UIControlEventTouchUpInside];
        
        cell.backgroundView = btn;
        
    }
    
    
    
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1) {
        
        [self openCountryList];
    }
}


#pragma mark Action 

- (void)openCountryList {

    DataController *dc = [DataController sharedDataController];
    [dc saveUserToCoreData:nameField.text countryShip:self.countryField.text];
    
    [self dismissModalViewControllerAnimated:YES];
    
}

#pragma mark - Text Field Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
