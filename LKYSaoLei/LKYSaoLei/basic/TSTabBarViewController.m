//
//  TSTabBarViewController.m
//  timeshare
//
//  Created by song ce on 2018/5/21.
//  Copyright © 2018年 song ce. All rights reserved.
//

#import "TSTabBarViewController.h"
#import "TSNavViewController.h"

//#import "Demo01ViewController.h"
#import "SaoLeiViewController.h"

@interface TSTabBarViewController ()

@end

@implementation TSTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //添加子控件
    [self setchildren];
    //为保证不透明要设置image
    [[UITabBar appearance] setBackgroundImage:[self createImageWithColor:arcColor]];
    
   
}
#pragma mark 添加所有子控制器
-(void)setchildren
{
    
//    //工具类
//    [self addOneChildVc:[[ToolViewController alloc]init] Image:@"tab1(no)" SelectImage:@"tab1" Title:@"工具类"];
//    //第三方
//    [self addOneChildVc:[[ThirdPartyViewController alloc]init] Image:@"tab2(no)" SelectImage:@"tab2" Title:@"第三方"];
    
    [self addOneChildVc:[[SaoLeiViewController alloc]init] Image:@"tab1(no)" SelectImage:@"tab1" Title:@"轮播图"];

}
#pragma mark 添加一个子控制器
-(void)addOneChildVc:(UIViewController *)vc Image:(NSString *)image SelectImage:(NSString *)selectimage Title:(NSString *)title
{
    TSNavViewController *nvc = [[TSNavViewController alloc]initWithRootViewController:vc];
    vc.title = title;
    nvc.tabBarItem.title = title;
    
    
    //设置文字被选中后的颜色(不能统一设，只能一个一个设)
    //第一步 设置一个字典
    NSMutableDictionary*dic=[NSMutableDictionary dictionary];
    //第二步 将颜色放入字典
    dic[NSForegroundColorAttributeName]= arcColor;
    //第三步 调用字典
    [nvc.tabBarItem setTitleTextAttributes:dic forState:UIControlStateSelected];
    
    //设置文字未被选中的颜色
    //第一步 设置一个字典
    NSMutableDictionary*dicNor=[NSMutableDictionary dictionary];
    //第二步 将颜色放入字典
    dicNor[NSForegroundColorAttributeName]= [UIColor whiteColor];
    //第三步 调用字典
    [nvc.tabBarItem setTitleTextAttributes:dicNor forState:UIControlStateNormal];
    
    nvc.tabBarItem.image = [[UIImage imageNamed:image]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    nvc.tabBarItem.selectedImage = [[UIImage imageNamed:selectimage]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    //    nvc.tabBarItem.imageInsets= UIEdgeInsetsMake(H(-2), H(2),  H(2), H(-2));
    
    [self addChildViewController:nvc];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
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
