//
//  RequirementsViewController.h
//  vc-mobile
//
//  Created by Ирина Дидковская on 24.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Requirement.h"
#import "VCustomAccessory.h"

@interface RequirementsViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
    
}

@property (nonatomic, retain) NSString *visaType;
@property (nonatomic, retain) NSString *countryName;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSMutableIndexSet *expandedSections;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
