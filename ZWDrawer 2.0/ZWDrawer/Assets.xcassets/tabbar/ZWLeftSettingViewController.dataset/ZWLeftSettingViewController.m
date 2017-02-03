//
//  ZWLeftSettingViewController.m
//  ZWDrawerAnimation
//
//  Created by 郑亚伟 on 16/9/28.
//  Copyright © 2016年 郑亚伟. All rights reserved.
//

#import "ZWLeftSettingViewController.h"
#import "AppDelegate.h"
#import "OtherViewController.h"

@interface ZWLeftSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ZWLeftSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageview.image = [UIImage imageNamed:@"体育运动18"];
    imageview.userInteractionEnabled = YES;
    [self.view addSubview:imageview];
    
    UITableView *tableview = [[UITableView alloc] init];
    //这里没有设置tableView的frame，而是将它传递到ZWLeftSlideViewController中，这样便于设置frame的值，便于设置动画效果
    
    
    self.tableview = tableview;
    tableview.frame = self.view.bounds;
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
    cell.backgroundColor = [UIColor orangeColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"ZW1";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"ZW2";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"ZW3";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"ZW4";
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"ZW5";
    } else if (indexPath.row == 5) {
        cell.textLabel.text = @"ZW6";
    } else if (indexPath.row == 6) {
        cell.textLabel.text = @"ZW7";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    OtherViewController *vc = [[OtherViewController alloc] init];
    
    [tempAppDelegate.drawerVC closeLeftView];//关闭左侧抽屉
    //点击对应的cell是主界面的navigation负责跳转，这里的设置界面只是一个展示的形式，这个设置界面的VC不包含在任何的容器视图中
    [tempAppDelegate.mainNavigationController pushViewController:vc animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{//因为头部返回180的高度，所以视觉上显示的是tableView居中
    return 180;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableview.bounds.size.width, 180)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.tableview.bounds.size.width, 180)];
    label.backgroundColor = [UIColor redColor];
    label.text = @"我是表头";
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
