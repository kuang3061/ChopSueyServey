//
//  AppDelegate.m
//  DemoCareers
//
//  Created by will_kuang on 16/7/14.
//  Copyright © 2016年 KCC. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarController.h"
#import "BaseNavgationController.h"
#import "ViewController.h"
#import "TechViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window.rootViewController = [self loadViewController];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BaseTabBarController *)loadViewController {
    
    BaseTabBarController *tabBar = [[BaseTabBarController alloc] init];
    ViewController *firestVC = [[ViewController alloc] init];
    TechViewController *secondeVC = [[TechViewController alloc] init];
    
    BaseNavgationController *baseNavFirest = [[BaseNavgationController alloc] initWithRootViewController:firestVC];
    BaseNavgationController *baseNavSeconde = [[BaseNavgationController alloc] initWithRootViewController:secondeVC];
    NSArray *VCArray = [NSArray arrayWithObjects:baseNavFirest,baseNavSeconde, nil];
    
    tabBar.viewControllers = VCArray;
    
    baseNavFirest.title = @"test1";
    baseNavSeconde.title = @"test2";
    
    return tabBar;
}

@end
