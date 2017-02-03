//
//  AppDelegate.m
//  ZWDrawer
//
//  Created by 郑亚伟 on 2017/1/18.
//  Copyright © 2017年 zhengyawei. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarViewController.h"
#import "ZWDrawerViewController.h"
#import "ZWLeftMenuViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //1.创建左边菜单控制器
    ZWLeftMenuViewController *leftMenuVC = [[ZWLeftMenuViewController alloc]init];
   //2.创建tabbarController
    MainTabBarViewController *tabbarVC = [[MainTabBarViewController alloc]init];
//    UINavigationController *tabbarNav = [[UINavigationController alloc]initWithRootViewController:tabbarVC];
    //3.抽屉控制器设置为根控制器
    _window.rootViewController = [ZWDrawerViewController drawerVCWithMainVC:tabbarVC leftMenuVC:leftMenuVC leftWidth:300];
    _window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
