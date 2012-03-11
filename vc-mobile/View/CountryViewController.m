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
//    UIBarButtonItem *btn = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"favorite.png"] style:UIBarButtonItemStylePlain 
//                                                                          target:self 
//                                                                          action:@selector(showAddToFavoritesConfirmationAlert)] autorelease];
//    self.navigationItem.rightBarButtonItem = btn;
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    [btn setImage:[UIImage imageNamed:@"favorite.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showAddToFavoritesConfirmationAlert) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:btn] autorelease];
    [btn release];
    
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
