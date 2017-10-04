//
//  AppDelegate.m
//  MFAnimationTransitionMigratDemo
//
//  Created by Lyman Li on 2017/10/4.
//  Copyright © 2017年 Lyman Li. All rights reserved.
//

#import "AppDelegate.h"

#import "FirstViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[FirstViewController alloc] init]];
    
    self.window.rootViewController = navigationController;
    
    return YES;
}



@end
