//
//  CountrySelectorVC.h
//  vc-mobile
//
//  Created by Ирина Дидковская on 17.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountrySelectorVC : UITableViewController {
    
    BOOL searching;
    BOOL letUserSelectRow;
    
}


@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;



- (void) searchTableView;
- (void) doneSearching_Clicked:(id)sender;

@end
