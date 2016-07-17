//
//  BaseTabBarController.m
//  KCCDemo
//
//  Created by farben_cc on 16/6/27.
//  Copyright © 2016年 farben_cc. All rights reserved.
//

#import "BaseTabBarController.h"
#import "ViewController.h"
#import "TechViewController.h"

/**
 *  tabBar
 */
typedef NS_ENUM(NSInteger, CCTabBarState) {
    /**
     *  第一个tabBar
     */
    CCTabBarFirest = 990,
    /**
     *  第二个tabBar
     */
    CCTabBarSeconde,
};

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self loadViewController];
}
- (void)loadViewController {
    
    ViewController *firset = [[ViewController alloc] init];
    UITabBarItem *tabbarFirset = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:CCTabBarFirest];
    firset.tabBarItem = tabbarFirset;
    
    TechViewController *seconde = [[TechViewController alloc] init];
    UITabBarItem *tabbarSeconde = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:CCTabBarSeconde];
    seconde.tabBarItem = tabbarSeconde;
    
    NSArray *VCArray = [NSArray arrayWithObjects:tabbarFirset,tabbarSeconde, nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
