//
//  XZBaseNavigationController.m
//  MyApp
//
//  Created by jameswatt on 16/3/18.
//  Copyright © 2016年 xuzhixiang1. All rights reserved.
//

#import "XZBaseNavigationController.h"
#import "AppDelegate.h"

@interface XZBaseNavigationController ()

@end

@implementation XZBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.barTintColor = [UIColor lightGrayColor];
    
    self.navigationBar.tintColor = [UIColor blackColor];
    
    
    //title 颜色
    NSDictionary *att = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    //只针对当前的控件有效
//    self.navigationBar.titleTextAttributes = att;
    //对所有创建出来的 UINavigationBar 都有效
    [[UINavigationBar appearance] setTitleTextAttributes:att];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
   
    if (self.viewControllers.count>0 ) {
            viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
