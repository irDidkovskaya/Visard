//
//  ColorfulButton.h
//  bSafe
//
//  Created by Alexandr Fal' on 9/21/11.
//  Copyright 2011 Ciklum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ColorfulButton : UIButton {

}

@property (nonatomic, retain) UIColor *topGradientColor;
@property (nonatomic, retain) UIColor *bottomGradientColor;

- (id)initWithFrame:(CGRect)frame topGradientColor:(UIColor *)topColor andBottomGradientColor:(UIColor *)bottomColor;

- (void)setupTopGradientColor:(UIColor *)topColor;
- (void)setupBottomGradientColor:(UIColor *)bottomColor;

@end
