//
//  CountryViewController.h
//  vc-mobile
//
//  Created by Ирина Дидковская on 17.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Requirement.h"
#import "User.h"

@interface CountryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, UIWebViewDelegate> {
    
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

- (void)setTextColorsForSegmentedControl:(UISegmentedControl*)segmented;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
