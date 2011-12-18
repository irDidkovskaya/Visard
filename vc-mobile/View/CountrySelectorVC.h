//
//  CountrySelectorVC.h
//  vc-mobile
//
//  Created by Ирина Дидковская on 17.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OverlayViewController.h"
@class OverlayViewController;
@interface CountrySelectorVC : UITableViewController <NSFetchedResultsControllerDelegate, UISearchBarDelegate>{
    
    BOOL searching;
    BOOL letUserSelectRow;
    
}


@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) UISearchBar *countrySearchBar;
@property (nonatomic, retain) OverlayViewController *ovController;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSPredicate *searchPredicate;
@property (nonatomic, retain) NSArray *filteredCountries;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;


@end
