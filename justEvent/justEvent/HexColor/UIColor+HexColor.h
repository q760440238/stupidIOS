//
//  UIColor+HexColor.h
//  speedauction
//
//  Created by yuanku on 2017/3/31.
//  Copyright © 2017年 yuanku. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexColor)

// 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)
//[UIColor colorWithHexString:@"333333"]
+ (UIColor *) colorWithHexString: (NSString *)color;

@end
