//
//  MainTabBarViewController.m
//  MyApp
//
//  Created by jameswatt on 16/3/15.
//  Copyright © 2016年 xuzhixiang1. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "TabBarModel.h"
#import "XZBaseNavigationController.h"
#import "ViewController1.h"
#import "ViewController.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.view.backgroundColor = [UIColor greenColor];
    //用配置文件去创建 子视图控制器和子视图控制器上面的图片和文字
    //第一次 运行的时候直接读取本地的配置文件
    [self creataTabBarViewControllers];
    
    NSDictionary *dict = @{NSForegroundColorAttributeName:[UIColor blueColor],NSFontAttributeName:[UIFont systemFontOfSize:15]};
    
    [[UITabBarItem appearance]setTitleTextAttributes:dict forState:UIControlStateSelected];
}

- (void)viewWillAppear:(BOOL)animated{
    //appdelegate中的mainNavigationgControl在这里要隐藏，首界面上，只是负责界面跳转时的管理工作，不负责显示工作。但是跳入子界面的时候要显示navigationBar
//     self.navigationController.navigationBar.hidden = YES;
}
-(void)viewDidDisappear:(BOOL)animated{
//    self.navigationController.navigationBar.hidden = NO;
}

- (void)creataTabBarViewControllers {
    NSArray *tabBarModelArray = [self loadConfigFile];
    //创建子视图控制器
    for (TabBarModel *item in tabBarModelArray) {
        UIViewController *vc = [[NSClassFromString(item.className) alloc]init];
        vc.title = item.title;
        vc.tabBarItem.title = item.title;
        vc.tabBarItem.image = [UIImage imageNamed:item.image];
        vc.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_press",item.image]];
        
        XZBaseNavigationController *nav = [[XZBaseNavigationController alloc]initWithRootViewController:vc];
        
        [self addChildViewController:nav];
    }
}


/**
 *  记载配置文件
 */
- (NSMutableArray*)loadConfigFile {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Tabbar.plist" ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    NSMutableArray *resultArray = [TabBarModel arrayOfModelsFromDictionaries:array];
    return resultArray;
    
}

@end
