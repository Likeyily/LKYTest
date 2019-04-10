//
//  LKYMask.m
//  timeshare
//
//  Created by song ce on 2018/6/16.
//  Copyright © 2018年 song ce. All rights reserved.
//

#import "LKYMask.h"

@interface LKYMask()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIView *backView;

@property(nonatomic,strong)NSArray *listArr;

@end

@implementation LKYMask

- (void)makeAMaskWithArr:(NSArray *)arr Frame:(CGRect)frame MyBlock:(selectedBlock)myblock
{
    _listArr = arr;
    if (!_fontSize) {
        _fontSize = FONT(14);
        
    }
    if (!_cellColor) {
        _cellColor = TextColor50;
    }
    if (!_maskAlph) {
        _maskAlph = 0.3;
    }
    _indexBlock = myblock;
    UIWindow *myWindow = [UIApplication sharedApplication].keyWindow;
    
    self.backView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.backView.backgroundColor = [UIColor colorWithWhite:0 alpha:_maskAlph];
    [myWindow addSubview:self.backView];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    tap.delegate = self;
    [tap addTarget:self action:@selector(returnView)];
    [self.backView addGestureRecognizer:tap];
    
    //添加列表
    self.tableView = [[UITableView alloc]initWithFrame:frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = H(45);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.backView addSubview:self.tableView];
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * lkyCell = @"lkyCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:lkyCell];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:lkyCell];
        
        UIView *fgx = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _tableView.width, 1)];
        fgx.backgroundColor = BackColor238;
        
        fgx.bottom = H(45);
        
        [cell.contentView addSubview:fgx];
    }
    

    cell.textLabel.text = _listArr[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = self.fontSize;
    cell.textLabel.textColor = self.cellColor;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.indexBlock((int)indexPath.row);
    
    [self returnView];
}

- (void)returnView
{
    [_backView removeFromSuperview];
    [_tableView removeFromSuperview];
    _tableView = nil;
    _backView = nil;
}
#pragma mark 解决手势冲突问题
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}



@end
