//
//  AppDelegate.m
//  justEvent
//
//  Created by 魏勇城 on 2019/12/10.
//  Copyright © 2019 余谦. All rights reserved.
//

#import "AppDelegate.h"
#import "SelectCreateUIVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
      
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [_window makeKeyAndVisible];
    SelectCreateUIVC * rootBar = [[SelectCreateUIVC alloc] init];
    [_window setRootViewController:rootBar];
    
    return YES;
}




@end
