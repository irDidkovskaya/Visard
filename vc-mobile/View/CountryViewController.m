//
//  CountryViewController.m
//  vc-mobile
//
//  Created by Ирина Дидковская on 17.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CountryViewController.h"
#import "UISegmentedControl+CustomTintExtension.h"

@implementation CountryViewController
@synthesize requirement, user, tableView = tableView_;

//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

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

    
    
    UIView *scView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)] autorelease];
    scView.backgroundColor = [UIColor colorWithRed:7/255.0 green:200/255.0 blue:98/255.0 alpha:1];
    
    NSArray *itemArray = [NSArray arrayWithObjects: @"Consulate", @"Requirements", @"Advices", nil];
    UISegmentedControl *segmentedControl = [[[UISegmentedControl alloc] initWithItems:itemArray] autorelease];
    segmentedControl.frame = CGRectMake(50, 7, 250, 30);
	segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
	segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    [segmentedControl addTarget:self
	                     action:@selector(pickOne:)
	           forControlEvents:UIControlEventValueChanged];
    
    [segmentedControl setTag:0 forSegmentAtIndex:0];
    [segmentedControl setTag:0 forSegmentAtIndex:1];
    [segmentedControl setTag:0 forSegmentAtIndex:2];
    [self setTextColorsForSegmentedControl:segmentedControl];
    [scView addSubview:segmentedControl];

    
    [self.view addSubview:scView];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:7/255.0 green:200/255.0 blue:98/255.0 alpha:1];
    if (segmentedControl.selectedSegmentIndex == 0) {
        
        UITableView *tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        tv.delegate = self;
        self.tableView = tv;
         [self.view addSubview:self.tableView];
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
    
    switch (sc.selectedSegmentIndex) {
        case 0: {
            UITableView *tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
            
            tv.delegate = self;
            
            self.tableView = tv;
            [self.view addSubview:self.tableView];
        }
            break;
        case 1: {
            UITableView *tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
            
            tv.delegate = self;
            self.tableView = tv;
            [self.view addSubview:self.tableView];
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
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
