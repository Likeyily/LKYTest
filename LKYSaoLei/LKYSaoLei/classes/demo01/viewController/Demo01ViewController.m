//
//  Demo01ViewController.m
//  项目模版
//
//  Created by song ce on 2019/2/14.
//  Copyright © 2019年 song ce. All rights reserved.
//

#import "Demo01ViewController.h"

#import "bk_slideShow.h"

#import "SDCycleScrollView.h"

@interface Demo01ViewController ()<protocol_slideShow,SDCycleScrollViewDelegate>

@property(nonatomic,strong)NSMutableArray *imageUrlArr;
@property(nonatomic,strong)NSMutableArray *imageArr;

@end

@implementation Demo01ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //请求图片
    [self getHeaderPic];
}
#pragma mark 请求顶部视图
-(void)getHeaderPic
{
    bk_slideShow *show = [[bk_slideShow alloc]init];
    show.delegate = self;
    [show getslideShow];
    //    [MBProgressHUD showLoadingGif];//不再添加防止与其他请求重复
    
}
- (void)slideShowSuccess:(NSArray *)result
{
    //    [MBProgressHUD dismissHUD];
    self.imageArr = [NSMutableArray arrayWithArray:result];
    for (NSDictionary *dic in result) {
        NSString *imageUrl = dic[@"url"];
        [self.imageUrlArr addObject:imageUrl];
    }
    
    //网络请求图片
    SDCycleScrollView *cycleScrollView3 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,H(325)) delegate:self placeholderImage:[UIImage imageNamed:@"noPic"]];
    cycleScrollView3.currentPageDotImage = [UIImage imageNamed:@"hong_hd"];
    cycleScrollView3.pageDotImage = [UIImage imageNamed:@"hui_hd"];
    cycleScrollView3.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
    cycleScrollView3.imageURLStringsGroup = self.imageUrlArr;
    cycleScrollView3.autoScrollTimeInterval = 10;
    cycleScrollView3.pageControlBottomOffset = -H(20);//原始位置向下
    cycleScrollView3.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:cycleScrollView3];
    
}
- (void)slideShowError:(NSString *)error
{
    [MBProgressHUD showError:error];
}
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
        NSLog(@"%ld",(long)index);
}
- (NSMutableArray *)imageUrlArr
{
    if (!_imageUrlArr) {
        _imageUrlArr = [NSMutableArray array];
    }
    return _imageUrlArr;
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
