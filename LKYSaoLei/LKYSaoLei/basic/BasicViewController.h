//
//  BasicViewController.h
//  timeshare
//
//  Created by song ce on 2018/5/22.
//  Copyright © 2018年 song ce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;


@end
