//
//  AppStyle.m
//  vc-mobile
//
//  Created by Ирина Дидковская on 26.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppStyle.h"

@implementation AppStyle

//gtoup = 0 - страны шенгена
//group = 1 - безвизовые страны
//group = 2 - визовые
//group = 3 - условно безвизовые

+(UIColor *)colorForNavigationBar {
    
    return [UIColor colorWithRed:7/255.0 green:200/255.0 blue:98/255.0 alpha:1];
}

+(UIColor *)colorForSearchBar {
    
    return [UIColor colorWithRed:215/255.0 green:250/255.0 blue:232/255.0 alpha:1];
}

@end
