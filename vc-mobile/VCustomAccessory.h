//
//  ISCustomAccessory.h
//  InfoSuit
//
/*
 * InfoSuite Copyright ¬© 1995-2011 Excel Data A/S, All Rights Reserved.
 *
 * http://www.exceldata.com
 * http://www.exceldata.dk
 */

#import <Foundation/Foundation.h>


typedef enum 
{
    VCustomAccessoryTypeRight = 0,
    VCustomAccessoryTypeUp,
    VCustomAccessoryTypeDown
} VCustomAccessoryType;

@interface VCustomAccessory : UIControl
{
	UIColor *_accessoryColor;
	UIColor *_highlightedColor;
    
    VCustomAccessoryType _type;
}

@property (nonatomic, retain) UIColor *accessoryColor;
@property (nonatomic, retain) UIColor *highlightedColor;

@property (nonatomic, assign)  VCustomAccessoryType type;

+ (VCustomAccessory *)accessoryWithColor:(UIColor *)color type:(VCustomAccessoryType)type;

@end