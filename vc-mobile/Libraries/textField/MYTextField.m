//
//  UITextField+PlaceHolder.m
//  vc-mobile
//
//  Created by Ирина Дидковская on 03.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MYTextField.h"

@implementation MYTextField

- (void)drawPlaceholderInRect:(CGRect)rect {
    [[UIColor colorWithRed:66/255.0 green:97/255.0 blue:133/255.0 alpha:1] setFill];
    [[self placeholder] drawInRect:rect withFont:[UIFont fontWithName:@"Helvetica" size:17.0]];
}

@end
