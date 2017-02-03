//
//  ZWLeftMenuViewController.m
//  ZWDrawer
//
//  Created by 郑亚伟 on 2017/1/18.
//  Copyright © 2017年 zhengyawei. All rights reserved.
//

#import "ZWLeftMenuViewController.h"
#import "ZWDrawerViewController.h"

@interface ZWLeftMenuViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *titleArr;
@end

@implementation ZWLeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"leftbackiamge.png"]];
    UITableView *tableview = [[UITableView alloc] init];
    //这里没有设置tableView的frame，而是将它传递到ZWLeftSlideViewController中，这样便于设置frame的值，便于设置动画效果
    
    
    self.tableview = tableview;
    self.tableview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"leftbackiamge.png"]];
    //
    tableview.frame = CGRectMake(0, 0, 300, self.view.frame.size.height);
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArr.count;
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
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = self.titleArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    UIViewController *vc = [[UIViewController alloc]init];
    
    //注意：这里的target是[ZWDrawerViewController shareDrawer]，backHome是它内部的一个方法
    vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:[ZWDrawerViewController shareDrawer] action:@selector(backHome)];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    vc.title = self.titleArr[indexPath.row];
    [[ZWDrawerViewController shareDrawer]switchViewController:nav];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{//因为头部返回180的高度，所以视觉上显示的是tableView居中
    return 180;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableview.bounds.size.width, 180)];
    view.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.tableview.bounds.size.width, 180)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"我是表头";
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (NSMutableArray *)titleArr{
    if (_titleArr == nil) {
        _titleArr = [NSMutableArray arrayWithObjects:@"开通会员",@"QQ钱包",@"网上营业厅",@"个性装扮",@"我的收藏",@"我的相册", @"我的文件", nil];
    }
    return _titleArr;
}



@end
