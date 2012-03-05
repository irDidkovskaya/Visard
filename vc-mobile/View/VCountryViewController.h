//
//  VCountryViewController.h
//  vc-mobile
//
//  Created by Alexandr Fal' on 1/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Requirement.h"
#import "User.h"

@interface VCountryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, UIWebViewDelegate> {
    
    int currSigmentControll;
    
}


@property (nonatomic, retain) Requirement *requirement;
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, retain) NSString *code;
@property (nonatomic, retain) NSString *img;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) UIView *viewForSegmContr;

- (void)setTextColorsForSegmentedControl:(UISegmentedControl*)segmented;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
