//
//  CountryViewController.h
//  vc-mobile
//
//  Created by Ирина Дидковская on 17.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCountryViewController.h"

@interface CountryViewController : VCountryViewController <UIAlertViewDelegate>

- (void)addCountryToFavorites;

@end
