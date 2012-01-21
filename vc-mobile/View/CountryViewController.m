//
//  CountryViewController.m
//  vc-mobile
//
//  Created by Ирина Дидковская on 17.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CountryViewController.h"
#import "DataController.h"

@implementation CountryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Add to  favorites button
    UIBarButtonItem *btn = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 
                                                                          target:self 
                                                                          action:@selector(showAddToFavoritesConfirmationAlert)] autorelease];
    self.navigationItem.rightBarButtonItem = btn;
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
        [self addCountryToFavorites];
    }
}

- (void)addCountryToFavorites
{
    NSLog(@"country to favorites adding");
    [[DataController sharedDataController] addToFavoritesCountryWithName:self.name];
}

@end
