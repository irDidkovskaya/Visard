//
//  ConsulateViewController.h
//  vc-mobile
//
//  Created by Ирина Дидковская on 22.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Consulate.h"

@interface ConsulateViewController : UIViewController <UIActionSheetDelegate>

@property (nonatomic, retain) NSString *countryName;
@property (nonatomic, retain) NSString *img;
@property (nonatomic, retain) Consulate *consulate;
@property (nonatomic, retain) UIToolbar *toolBar;
@property (nonatomic, retain) NSArray *numbersList;
@end
