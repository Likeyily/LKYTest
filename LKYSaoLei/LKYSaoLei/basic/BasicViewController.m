//
//  BasicViewController.m
//  timeshare
//
//  Created by song ce on 2018/5/22.
//  Copyright © 2018年 song ce. All rights reserved.
//

#import "BasicViewController.h"

@interface BasicViewController ()

@end

@implementation BasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建一个表格
    [self makeATableView];
}
#pragma mark 创建一个表格
-(void)makeATableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.top.equalTo(self.view);
    }];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (@available(iOS 11.0,*)) {
        
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.additionalSafeAreaInsets = UIEdgeInsetsMake(-20, 0, 0, 0);
        
    }
    else
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
