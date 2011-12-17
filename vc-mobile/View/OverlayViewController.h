//
//  OverlayViewController.h
//  vc-mobile
//
//  Created by Ирина Дидковская on 17.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountrySelectorVC.h"

@class CountrySelectorVC;
@interface OverlayViewController : UIViewController

@property (nonatomic, retain) CountrySelectorVC *rvController;

@end
