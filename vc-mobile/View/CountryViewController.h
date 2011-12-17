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

@interface CountryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, retain) Requirement *requirement;
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) UITableView *tableView;

-(void)setTextColorsForSegmentedControl:(UISegmentedControl*)segmented;
@end
