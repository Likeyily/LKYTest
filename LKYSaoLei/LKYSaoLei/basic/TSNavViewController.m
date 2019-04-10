//
//  TSNavViewController.m
//  timeshare
//
//  Created by song ce on 2018/5/22.
//  Copyright © 2018年 song ce. All rights reserved.
//

#import "TSNavViewController.h"

#import "LKYButton.h"

@interface TSNavViewController ()

@end

@implementation TSNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置导航栏颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
//    self.navigationBar.barTintColor = Themecolor;//设置导航栏背景
    self.navigationBar.translucent = NO;//关闭导航栏半透明化 否则颜色不准 影响tableView顶端的偏移
    
    /**设置导航栏自带控件颜色*/
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.barStyle = UIBarStyleBlack;//字体设为白色
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) { // 非根控制器
        
        // 设置返回按钮,只有非根控制器
        //左键
        LKYButton *leftBut = [[LKYButton alloc]initWithFrame:CGRectMake(0, 0, W(55), W(22)) andButton:(buttonTypeEdge)];
        [leftBut setImage:[UIImage imageNamed:@"icon-fh"] forState:(UIControlStateNormal)];
        leftBut.edgeRight = W(40);
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBut];
        [leftBut addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
        viewController.navigationItem.leftBarButtonItem = leftItem;
        if (SCREEN_WIDTH>375.0) {
            
            leftBut.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 5);
        }
        
    }
    
    // 真正在跳转
    [super pushViewController:viewController animated:animated];
    
}
- (void)back
{
    [self popViewControllerAnimated:YES];
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
