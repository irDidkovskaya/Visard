//
//  StartViewController.h
//  vc-mobile
//
//  Created by Ирина Дидковская on 17.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartViewController : UITableViewController



@property (nonatomic, retain) UITextField *nameField;
@property (nonatomic, retain) UITextField *countryField;


- (void)openCountryList;
@end
