//
//  ReminderSetupViewController.h
//  vc-mobile
//
//  Created by Alexandr Fal' on 2/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Requirement.h"

@interface ReminderSetupViewController : UITableViewController

- (id)initWithRequirement:(Requirement *)requirement;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
