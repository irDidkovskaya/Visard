//
//  StartViewController.h
//  vc-mobile
//
//  Created by Ирина Дидковская on 17.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataController.h"
@interface StartViewController : UITableViewController <UITextFieldDelegate, UIPickerViewDelegate, UIActionSheetDelegate>



@property (nonatomic, retain) UITextField *nameField;
@property (nonatomic, retain) UILabel *countryField;
@property (nonatomic, retain) UIPickerView *pickerView;
@property (nonatomic, retain) UIToolbar *toolBar;
@property (nonatomic, retain) NSString *countrySheep;
@property (nonatomic, retain) NSArray *countrySheeps;
@property (nonatomic, assign) VisaCountrySheep countrySheepID;


- (void)openCountryList;
@end
