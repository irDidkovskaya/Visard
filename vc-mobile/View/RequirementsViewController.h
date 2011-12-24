//
//  RequirementsViewController.h
//  vc-mobile
//
//  Created by Ирина Дидковская on 24.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Requirement.h"

@interface RequirementsViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, retain) NSString *typeVisa;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) Requirement *requirements;


@end