//
//  ZWDrawerViewController.m
//  ZWDrawer
//
//  Created by 郑亚伟 on 2017/1/18.
//  Copyright © 2017年 zhengyawei. All rights reserved.
//

#import "ZWDrawerViewController.h"

@interface ZWDrawerViewController ()

/**
 主控制器（通常是tabbar）
 */
@property(nonatomic,strong)UIViewController *mainVC;

/**
 左边菜单控制器
 */
@property(nonatomic,strong)UIViewController *leftMenuVC;

/**
 抽屉效果滑出的距离
 */
@property(nonatomic,assign)CGFloat leftWidth;

/**遮盖按钮 */
@property(nonatomic,strong)UIButton *coverBtn;

/**
 记录左边栏切入的控制器
 */
@property(nonatomic,strong)UIViewController *showingVC;
@end

@implementation ZWDrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //1.默认左边控制器的view向左偏移self.leftWidth
    self.leftMenuVC.view.transform = CGAffineTransformMakeTranslation(-self.leftWidth , 0);
    //2.给mainVC的view设置阴影效果
    self.mainVC.view.layer.shadowColor = [UIColor redColor].CGColor;
    self.mainVC.view.layer.shadowOffset = CGSizeMake(-3, -3);
    self.mainVC.view.layer.shadowOpacity = 0.2;
    self.mainVC.view.layer.shadowRadius = 5;
    /*****************************************/
    //3.给mainVC的子控制器添加边缘拖拽手势
    for (UIViewController *chidVC in self.mainVC.childViewControllers) {
        [self addScreenEdgePanGestureRecognizierForView:chidVC.view];
    }
}
+(instancetype)shareDrawer{
    //通过目前显示的根控制器获取实例对象
    return (ZWDrawerViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
}

+(instancetype)drawerVCWithMainVC:(UIViewController *)mainVC leftMenuVC:(UIViewController *)leftMenuVC leftWidth:(CGFloat)leftWidth{
    
    ZWDrawerViewController *drawerVC = [[ZWDrawerViewController alloc]init];
    //赋值要在添加子控制器之前
    drawerVC.mainVC = mainVC;
    drawerVC.leftMenuVC = leftMenuVC;
    drawerVC.leftWidth = leftWidth;
    
    //顺序不能乱
    [drawerVC.view addSubview:leftMenuVC.view];
    [drawerVC.view addSubview:mainVC.view];
    //注意点：苹果规定，如果两个控制器的view护卫父子关系，则这两个控制器也必须为父子关系。否则会出现意想不到的错误。
    [drawerVC addChildViewController:leftMenuVC];
    [drawerVC addChildViewController:leftMenuVC];
    
    return drawerVC;
}

#pragma mark -边缘手势拖动事件
- (void)edgePanGestureRecognizer:(UIScreenEdgePanGestureRecognizer*)pan{
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    //获得x方向拖拽的距离
    CGFloat offsetX = [pan translationInView:pan.view].x;
    //手势是否结束或被取消了
    if(pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled){
        //判断是否超过屏幕宽度的一般
        if (self.mainVC.view.frame.origin.x > screenW *0.5) {
            [self openLeftMenu];
        }else{
            [self coverBtnClick];
        }
    }else if (pan.state == UIGestureRecognizerStateChanged){//拖动中
        if (offsetX > self.leftWidth) {return;}
        self.mainVC.view.transform = CGAffineTransformMakeTranslation(offsetX, 0);
        self.leftMenuVC.view.transform = CGAffineTransformMakeTranslation(-self.leftWidth + offsetX, 0);
    }
}

#pragma mark-遮盖按钮的拖拽手势
- (void)panCoverBtn:(UIPanGestureRecognizer *)pan{
    CGFloat offsetX = [pan translationInView:pan.view].x;
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    //向右拖动，什么都不做
    if (offsetX > 0) {return;}
    CGFloat distance = self.leftWidth-ABS(offsetX);//ABS是绝对值
    if(pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled){
        //判断是否超过屏幕宽度的一般
        if (self.mainVC.view.frame.origin.x > screenW *0.5) {
            [self openLeftMenu];
        }else{
            [self coverBtnClick];
        }
    }else if (pan.state == UIGestureRecognizerStateChanged){//拖动中
        //MAX(0,distance)获取两者中最大的，防止distance为负数
        self.mainVC.view.transform = CGAffineTransformMakeTranslation(MAX(0,distance), 0);
        self.leftMenuVC.view.transform = CGAffineTransformMakeTranslation(-self.leftWidth + distance, 0);
    }
    
}
#pragma mark -覆盖按钮点击事件，主要是关闭抽屉效果
-(void)coverBtnClick{
    [UIView animateKeyframesWithDuration:0.25 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        //还原view的transform
        self.mainVC.view.transform = CGAffineTransformIdentity;
        self.leftMenuVC.view.transform = CGAffineTransformMakeTranslation(-self.leftWidth, 0);    } completion:^(BOOL finished) {
            //移除遮盖按钮
            [self.coverBtn removeFromSuperview];
            self.coverBtn = nil;
        }];
}

#pragma mark-外部调用，打开抽屉效果
/**打开抽屉效果*/
- (void)openLeftMenu{
    [UIView animateKeyframesWithDuration:0.25 delay:0
 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
     self.mainVC.view.transform = CGAffineTransformMakeTranslation(self.leftWidth, 0);
    self.leftMenuVC.view.transform = CGAffineTransformIdentity;
 } completion:^(BOOL finished) {
     //添加遮盖按钮
     [self.mainVC.view addSubview:self.coverBtn];
 }];
}

#pragma mark-添加边缘拖拽手势
- (void)addScreenEdgePanGestureRecognizierForView:(UIView *)view{
    //创建边缘拖拽手势
    UIScreenEdgePanGestureRecognizer *pan = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(edgePanGestureRecognizer:)];
    //左边缘添加手势
    pan.edges = UIRectEdgeLeft;
    //添加手势
    [view addGestureRecognizer:pan];
}
//切换到目标控制器
-(void)switchViewController:(UIViewController *)destVC{
    self.showingVC = destVC;
    //给showingVC添加边缘拖拽返回手势
    UIScreenEdgePanGestureRecognizer *pan = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(edgePanGestureRecognizerForShowingVC:)];
    //左边缘添加手势
    pan.edges = UIRectEdgeLeft;
    //添加手势
    [self.showingVC.view addGestureRecognizer:pan];
    //****要设置颜色，否则显示为透明色，下面的mainVC依然可见
    //说明：实际开发中有时视觉上会出现卡顿的效果，实际上可能不是卡顿，是因为没有设置背景颜色，默认是透明色，所以会出现视觉上的卡顿。
    destVC.view.backgroundColor = [UIColor whiteColor];
    destVC.view.frame = self.mainVC.view.bounds;
    destVC.view.transform = self.mainVC.view.transform;
    [self.view addSubview:destVC.view];
    [self addChildViewController:destVC];
    [self.view bringSubviewToFront:destVC.view];
    
    //以动画形式让控制器回到最初状态
    [self coverBtnClick];
    [UIView animateWithDuration:0.25 animations:^{
        destVC.view.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
    }];
}
- (void)edgePanGestureRecognizerForShowingVC:(UIScreenEdgePanGestureRecognizer *)pan{
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    //获得x方向拖拽的距离
    CGFloat offsetX = [pan translationInView:pan.view].x;
    //手势是否结束或被取消了
    if(pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled){
        //判断是否超过屏幕宽度的一般
        if (self.showingVC.view.frame.origin.x > screenW *0.5) {
            self.showingVC.view.transform = CGAffineTransformMakeTranslation(self.view.frame.size.width, 0);
            [self.showingVC removeFromParentViewController];
            [self.showingVC.view removeFromSuperview];
            self.showingVC = nil;
        }else{
           self.showingVC.view.transform = CGAffineTransformIdentity;
        }
    }else if (pan.state == UIGestureRecognizerStateChanged){//拖动中
        if (offsetX > self.leftWidth) {return;}
        self.showingVC.view.transform = CGAffineTransformMakeTranslation(offsetX, 0);
    }

}

/**
 外部调用，从showingVC返回到最初界面
 */
- (void)backHome{
    [UIView animateWithDuration:0.25 animations:^{
       //动画将菜单控制器进入的界面移动,模拟返回的状态
        self.showingVC.view.transform = CGAffineTransformMakeTranslation(self.view.frame.size.width, 0);
    } completion:^(BOOL finished) {
        [self.showingVC removeFromParentViewController];
        [self.showingVC.view removeFromSuperview];
        self.showingVC = nil;
    }];
}

#pragma mark -懒加载
- (UIButton *)coverBtn{
    if (_coverBtn == nil) {
        _coverBtn = [[UIButton alloc]init];
        [_coverBtn addTarget:self action:@selector(coverBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _coverBtn.backgroundColor = [UIColor lightGrayColor];
        _coverBtn.alpha = 0.3;
        _coverBtn.frame = self.mainVC.view.bounds;
        
        //创建一个拖拽手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panCoverBtn:)];
        [_coverBtn addGestureRecognizer:pan];
    }
    return _coverBtn;
}


@end
