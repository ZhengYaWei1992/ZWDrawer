//
//  ZWDrawerViewController.h
//  ZWDrawer
//
//  Created by 郑亚伟 on 2017/1/18.
//  Copyright © 2017年 zhengyawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZWDrawerViewController : UIViewController


/**
 快速创建对象
 */
+(instancetype)shareDrawer;


/**
 快速创建抽屉控制器

 @param mainVC 主控制器（tabbatController）
 @param leftMenuVC 左边菜单控制器
 leftWidth菜单控制器左边显示的最大宽度
 @return 抽屉控制器
 */
+(instancetype)drawerVCWithMainVC:(UIViewController *)mainVC leftMenuVC:(UIViewController *)leftMenuVC leftWidth:(CGFloat)leftWidth;


/**
 打开左边菜单
 */
- (void)openLeftMenu;


/**
 切换到制定的控制器
 */
-(void)switchViewController:(UIViewController *)destVC;

/**
 回到主界面
 */
- (void)backHome;
@end
