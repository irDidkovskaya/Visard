//
//  ColorfulButton.m
//  bSafe
//
//  Created by Alexandr Fal' on 9/21/11.
//  Copyright 2011 Ciklum. All rights reserved.
//

#import "ColorfulButton.h"

@implementation ColorfulButton

@synthesize topGradientColor;
@synthesize bottomGradientColor;

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        [self addObserver:self forKeyPath:@"highlighted" options:NSKeyValueObservingOptionNew context:NULL];
        
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor blackColor] CGColor];
        self.layer.cornerRadius = 7;
        self.layer.masksToBounds = YES;
    }    
    return self;
}

- (id)initWithFrame:(CGRect)frame topGradientColor:(UIColor *)topColor andBottomGradientColor:(UIColor *)bottomColor
{
    if ((self = [super initWithFrame:frame]))
    {
        [self addObserver:self forKeyPath:@"highlighted" options:NSKeyValueObservingOptionNew context:NULL];
        
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor colorWithRed:1/255.0 green:64/255.0 blue:135/255.0 alpha:1] CGColor];
        self.layer.cornerRadius = 7;
        self.layer.masksToBounds = YES;
        
        self.topGradientColor = topColor;
        self.bottomGradientColor = bottomColor;
    }
    
    return self;
}
 
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();    
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    
    const CGFloat *topGradientColorComponents;
    const CGFloat *bottomGradientColorComponents;
    
    if (self.highlighted == YES)
    {        
        topGradientColorComponents = CGColorGetComponents([self.topGradientColor CGColor]);
        bottomGradientColorComponents = CGColorGetComponents([self.bottomGradientColor CGColor]);
        
    }
    else
    {
        // Do custom drawing for normal state
        topGradientColorComponents = CGColorGetComponents([self.bottomGradientColor CGColor]);
        bottomGradientColorComponents = CGColorGetComponents([self.topGradientColor CGColor]);        
    }
    CGFloat colors[] =
    {
        topGradientColorComponents[0], topGradientColorComponents[1], topGradientColorComponents[2], topGradientColorComponents[3],
        bottomGradientColorComponents[0], bottomGradientColorComponents[1], bottomGradientColorComponents[2], bottomGradientColorComponents[3]
    };
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors) / (sizeof(colors[0]) * 4));
    CGColorSpaceRelease(rgb);
    
    CGContextDrawLinearGradient(ctx, gradient, CGPointMake(0, 0), CGPointMake(0, self.bounds.size.height), 0);
    CGGradientRelease(gradient);
}

- (void)setupTopGradientColor:(UIColor *)topColor
{
    self.topGradientColor = topColor;
    [self setNeedsDisplay];
}

- (void)setupBottomGradientColor:(UIColor *)bottomColor
{
    self.bottomGradientColor = bottomColor;
    [self setNeedsDisplay];
}    

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"highlighted"];
    self.topGradientColor = nil;
    self.bottomGradientColor = nil;
    
    [super dealloc];
}

@end
