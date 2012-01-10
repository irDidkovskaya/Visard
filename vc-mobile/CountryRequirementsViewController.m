//
//  CountryRequirementsViewController.m
//  vc-mobile
//
//  Created by Alexandr Fal' on 1/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CountryRequirementsViewController.h"
#import "DataController.h"
#import "AppStyle.h"

@implementation CountryRequirementsViewController

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

    // Add button
    UIBarButtonItem *addBtn = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 
                                                                             target:self 
                                                                             action:@selector(showAddToFavoritesConfirmationAlert)] autorelease];
    self.navigationController.navigationBar.tintColor = [AppStyle colorForNavigationBar];
    
    self.navigationItem.rightBarButtonItem = addBtn;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Nav Bar button actions

- (void)showAddToFavoritesConfirmationAlert
{
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Add to Favorites?", nil) 
                                                     message:nil
                                                    delegate:self 
                                           cancelButtonTitle:NSLocalizedString(@"No", nil) 
                                           otherButtonTitles:NSLocalizedString(@"Yes", nil), nil] autorelease];
    [alert show];
}

#pragma mark - Alert View Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex) {
        [self addVisaToFavorites];
    }
}

- (void)addVisaToFavorites
{
    NSLog(@"visa to favorites adding");
    [[DataController sharedDataController] addToFavoritesVisaWithCountry:self.countryName andType:self.visaType];
}

@end
