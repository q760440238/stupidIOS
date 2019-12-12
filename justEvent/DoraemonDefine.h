//
//  DoraemonDefine.h
//  DoraemonKitDemo
//
//  Created by yixiang on 2017/12/11.
//  Copyright © 2017年 yixiang. All rights reserved.
//

#ifndef DoraemonDefine_h
#define DoraemonDefine_h

#define DoKitVersion @"1.2.4"

#define DoraemonScreenWidth [UIScreen mainScreen].bounds.size.width
#define DoraemonScreenHeight [UIScreen mainScreen].bounds.size.height

//Doraemon默认位置
#define DoraemonStartingPosition            CGPointMake(0, DoraemonScreenHeight/3.0)

//Doraemon全屏默认位置
#define DoraemonFullScreenStartingPosition  CGPointZero

//根据750*1334分辨率计算size
#define kDoraemonSizeFrom750(x) ((x)*DoraemonScreenWidth/750)
// 如果横屏显示
#define kDoraemonSizeFrom750_Landscape(x) (kInterfaceOrientationPortrait ? kDoraemonSizeFrom750(x) : ((x)*DoraemonScreenHeight/750))

#define kInterfaceOrientationPortrait UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)

#define STRING_NOT_NULL(str) ((str==nil)?@"":str)


#define DoraemonShowPluginNotification @"DoraemonShowPluginNotification"
#define DoraemonClosePluginNotification @"DoraemonClosePluginNotification"
#define DoraemonQuickOpenLogVCNotification @"DoraemonQuickOpenLogVCNotification"

#endif /* DoraemonDefine_h */
