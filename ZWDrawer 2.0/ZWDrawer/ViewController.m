//
//  ViewController.m
//  ZWDrawer
//
//  Created by 郑亚伟 on 2017/1/18.
//  Copyright © 2017年 zhengyawei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, self.view.frame.size.width/2 - 50, 50)];
    [btn setTitle:@"点击进入下一界面" forState:UIControlStateNormal];
    [btn setTintColor:[UIColor blackColor]];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)btnClick{
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
