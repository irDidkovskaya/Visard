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
#import "AppStyle.h"

@implementation StartViewController

@synthesize nameField, countryField, pickerView, toolBar, countrySheeps, countrySheep, countrySheepID;
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
    
    self.navigationItem.title = NSLocalizedString(@"Старт", nil);
    
    self.tableView.backgroundColor = [UIColor colorWithRed:7/255.0 green:200/255.0 blue:98/255.0 alpha:1];
    self.tableView.tableHeaderView = [self headerView];
    self.tableView.userInteractionEnabled = YES;
    self.tableView.scrollEnabled = NO;
    UIPickerView *myPickerView = [[[UIPickerView alloc] initWithFrame:CGRectMake(0.0, 460+44, 320.0, 216.0)] autorelease];
    myPickerView.showsSelectionIndicator = YES;
    //myPickerView.dataSource = self;
    myPickerView.delegate = self;
    self.pickerView = myPickerView;
    [self.tableView addSubview:self.pickerView];
    
    
    UIToolbar *myToolBar = [[[UIToolbar alloc] initWithFrame:CGRectMake(0, 460, 320, 44)] autorelease];
    //toolBar.tintColor = [AppStyle colorForNavigationBar];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(hidePickerController)];
    [myToolBar setItems:[NSArray arrayWithObjects:doneBtn, nil]];
    self.toolBar = myToolBar;
    [self.tableView addSubview:self.toolBar];
    
    self.countrySheeps = [NSArray arrayWithObjects:@"Украина", @"Россия", nil];
    

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
    self.pickerView = nil;
    
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc
{
    self.nameField = nil;
    self.countryField = nil;
    self.pickerView = nil;
    self.countrySheep = nil;
    self.countrySheeps = nil;
    [super dealloc];
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
        UITextField *tf = [[[UITextField alloc] initWithFrame:CGRectMake(20, 35, 280, 25)] autorelease];
        tf.delegate = self;
        tf.backgroundColor = [UIColor clearColor];
        tf.placeholder = NSLocalizedString(@"Ваше Имя", nil);
        self.nameField = tf;
        cell.accessoryView = self.nameField;
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        UILabel *tf = [[[UILabel alloc] initWithFrame:CGRectMake(20, 15, 280, 30)] autorelease];
        tf.textColor = [UIColor lightGrayColor];
        tf.backgroundColor = [UIColor clearColor];
        tf.text = NSLocalizedString(@"Выберите гражданство", nil);
        self.countryField = tf;
        cell.accessoryView = self.countryField;
    } else {
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        ColorfulButton *btn = [[ColorfulButton alloc] initWithFrame:cell.frame topGradientColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1] andBottomGradientColor:[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1]];
        
        [btn setTitleColor:[UIColor colorWithRed:11/255.0 green:121/255.0 blue:5/255.0 alpha:1]  forState:UIControlStateNormal];
        
        
        
        [btn setTitle:NSLocalizedString(@"Старт", nil) forState:UIControlStateNormal];
        
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
   if (indexPath.section == 0 && indexPath.row == 1) 
   {
       
       [UIView animateWithDuration:0.5 
                        animations:^{
                            self.pickerView.frame = CGRectMake(0, 264, 320, 216);
                            self.toolBar.frame = CGRectMake(0, 264-44, 320, 44);
                            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                        } completion:^(BOOL finished){
                            self.countrySheep = [self.countrySheeps objectAtIndex:0];
                            self.countrySheepID = VisaCountrySheepUkraine;
                            
                            
                        }];
       
       [self.nameField resignFirstResponder];
       
   } else if (indexPath.section == 1) 
   {
        
        [self openCountryList];
    }
}


- (void)hidePickerController 
{
    [UIView animateWithDuration:0.5 
                     animations:^{
                         self.pickerView.frame = CGRectMake(0, 460+44, 320, 216);
                         self.toolBar.frame = CGRectMake(0, 460, 320, 44);
                         self.countryField.textColor = [UIColor blackColor];
                         self.countryField.text = self.countrySheep;
                     } completion:^(BOOL finished){
                         
                     }];
}

#pragma mark Action 

- (void)openCountryList {

    DataController *dc = [DataController sharedDataController];
    [dc saveUserToCoreData:nameField.text countryShip:self.countryField.text];
    
    [dc updateCoreDataWithCountrySheep:self.countrySheepID];
    
    [self dismissModalViewControllerAnimated:YES];
    
}

#pragma mark - Text Field Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark UIPickerViewController
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    self.countrySheep = [self.countrySheeps objectAtIndex:row];
    self.countrySheepID = row+1;
    NSLog(@"self.countrySheepI = %d", self.countrySheepID);
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger numRows = [self.countrySheeps count];
    
    return numRows;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
    title = [self.countrySheeps objectAtIndex:row];
    
    return title;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    
    return sectionWidth;
}


@end
