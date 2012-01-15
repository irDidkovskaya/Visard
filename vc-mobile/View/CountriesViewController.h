//
//  CountriesViewController.h
//  vc-mobile
//
//  Created by Alexandr Fal' on 1/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountriesViewController:UITableViewController <NSFetchedResultsControllerDelegate, UISearchBarDelegate> {
    
    BOOL searching;
    BOOL letUserSelectRow;    
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) UISearchBar *countrySearchBar;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSPredicate *searchPredicate;
@property (nonatomic, retain) NSArray *filteredCountries;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
