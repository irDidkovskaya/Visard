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
@interface CountrySelectorVC : UITableViewController <NSFetchedResultsControllerDelegate>{
    
    BOOL searching;
    BOOL letUserSelectRow;
    
}


@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) OverlayViewController *ovController;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

- (void) searchTableView;
- (void) doneSearching_Clicked:(id)sender;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;


@end
