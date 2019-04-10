//
//  LKYDatePicker.m
//  timeshare
//
//  Created by song ce on 2018/6/30.
//  Copyright © 2018年 song ce. All rights reserved.
//

#import "LKYDatePicker.h"
#import "LKYButton.h"

@interface LKYDatePicker()<UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,strong)LKYDatePicker *pickerView;


@property(nonatomic,strong)UIPickerView *myPickerView;

@property(nonatomic,strong)NSMutableArray *oneArr;
@property(nonatomic,strong)NSMutableArray *oneTextArr;
@property(nonatomic,strong)NSArray *twoArr;

@property(nonatomic,strong)NSDate *date;
@property(nonatomic,strong)NSString *dateStr;
@property(nonatomic,strong)NSString *timeStr;

@end;

@implementation LKYDatePicker

+(LKYDatePicker *)shareView
{
    static LKYDatePicker *dateView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateView = [[[self class] alloc] init];
    });
    
    return dateView;
    
}
- (void)selectDateTitle:(NSString *)title BackBlock:(LKYDateBlock)block
{
    _block = block;
    

    /**
     获取主窗口
     */
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    _pickerView = [LKYDatePicker shareView];
    _pickerView.frame = [UIScreen mainScreen].bounds;
    _pickerView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [keyWindow addSubview:_pickerView];
    
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    [tap addTarget:self action:@selector(returnView:)];
    [_pickerView addGestureRecognizer:tap];
    if (!self.myPickerView) {
        self.twoArr = @[@"01:00",@"02:00",@"03:00",@"04:00",@"05:00",@"06:00",@"07:00",@"08:00",@"09:00",@"10:00",@"11:00",@"12:00",@"13:00",@"14:00",@"15:00",@"16:00",@"17:00",@"18:00",@"19:00",@"20:00",@"21:00",@"22:00",@"23:00",@"00:00"];
        
        self.myPickerView =[[UIPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-H(180), SCREEN_WIDTH, H(180))];
        self.myPickerView.backgroundColor = [UIColor whiteColor];
        [_pickerView addSubview:_myPickerView];
        
        self.myPickerView.delegate = self;
        self.myPickerView.dataSource = self;
        [_pickerView addSubview:self.myPickerView];
    }
    
    self.date = self.oneArr[1];
    self.dateStr = self.oneTextArr[1];
    self.timeStr = self.twoArr[7];
    
    [self.myPickerView selectRow:1 inComponent:0 animated:YES];
    
    [self.myPickerView selectRow:7 inComponent:1 animated:YES];
    
    //上方选择按钮
    UIView *view = [self makeATopViewWithTitle:title];
    view.bottom = self.myPickerView.y;
    [_pickerView addSubview:view];
    
    
    
}
#pragma mark 上方选择部分视图
-(UIView *)makeATopViewWithTitle:(NSString *)title
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, H(40))];
    view.backgroundColor = [UIColor whiteColor];
    
    LKYButton *cancle = [[LKYButton alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH/2, H(40)) andButton:buttonTypeEdge];
    [cancle setTitle:@"取消" forState:(UIControlStateNormal)];
    [cancle setTitleColor:TextColor153 forState:UIControlStateNormal];
    cancle.titleLabel.font = FONT(16);
    CGSize sizeCancle = [cancle sizeThatFits:CGSizeMake(SCREEN_WIDTH/2, H(10))];
    cancle.width = sizeCancle.width+W(30);
    cancle.edgeRight = W(30);
    [cancle addTarget:self action:@selector(backView) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:cancle];
    
    //确定
    LKYButton *sure = [[LKYButton alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH/2, H(40)) andButton:buttonTypeEdge];
    [sure setTitle:@"确定" forState:(UIControlStateNormal)];
    [sure setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    sure.titleLabel.font = FONT(16);
    CGSize sizesure = [cancle sizeThatFits:CGSizeMake(SCREEN_WIDTH/2, H(40))];
    sure.width = sizesure.width+W(30);
    sure.edgeLeft = W(30);
    sure.right = SCREEN_WIDTH-15;
    [sure addTarget:self action:@selector(backViewWithSure:) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:sure];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(cancle.right, 0, SCREEN_WIDTH-30-(sure.width*2), H(40))];
//    label.right = sure.x;
    label.text = title;
    label.font = FONT(18);
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
  
    return view;
}
#pragma mark - pickerView数据源协议方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2; //拨盘数量
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {//第一个拨盘
        return self.oneArr.count;
        
    } else {
        return self.twoArr.count;
    }
}
#pragma mark - pickerView代理协议方法
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    //为选择器中某个拨盘的行提供数据

    if (component == 0) {
        return self.oneTextArr[row];
    } else {
        return self.twoArr[row];
    }
}
#pragma mark 每行转盘的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    if (self.rowH) {
        return self.rowH;
    }
    return H(45);
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    //选中选择器的某个拨盘中的某行时调用

    if (component == 0) {
        
        self.date = self.oneArr[row];
        self.dateStr = self.oneTextArr[row];
        
    
    }
    else if (component==1)
    {
        self.timeStr = self.twoArr[row];
    }
}
#pragma mark 改变选择器的字体大小和颜色
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *lbl = (UILabel *)view;
    
    if (lbl == nil) {
        
        lbl = [[UILabel alloc]init];
        
        //在这里设置字体相关属性
        
        lbl.font = FONT(18);
        
//        lbl.textColor = [UIColor redColor];
        
        [lbl setTextAlignment:NSTextAlignmentCenter];
        
        [lbl setBackgroundColor:[UIColor clearColor]];
        
    }
    
    //重新加载lbl的文字内容
    
    lbl.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    return lbl;
}
#pragma mark 收回视图
-(void)returnView:(UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:_pickerView];
    if (point.y<SCREEN_HEIGHT-H(220)) {
        [self backView];
    }
}
-(void)backViewWithSure:(UIButton *)button
{
    self.block(self.date, self.dateStr, self.timeStr);
    [self backView];
}
-(void)backView
{
    [_pickerView removeFromSuperview];
    _pickerView = nil;
}
- (NSMutableArray *)oneArr
{

        
        _oneArr = [NSMutableArray array];
    
        NSDate *nowdate = _starDate;

    if (!nowdate) {
        nowdate = [NSDate date];
    }
    
        //加入开始时间
//    [_oneArr addObject:nowdate];
    //两天后可以租车
        for (int i=2; i<12; i++) {
            nowdate = [NSDate dateWithTimeInterval:24*60*60 sinceDate:nowdate];
            [_oneArr addObject:nowdate];
        }
    return _oneArr;
}

- (NSMutableArray *)oneTextArr
{
//    if (_oneTextArr) {
    
        _oneTextArr = [NSMutableArray array];
        for (NSDate *date in _oneArr) {
            NSString *timeStr = [self timeSwitchTimestamp:date andFormatter:@"MM月dd日"];
            
            NSString *weekStr = [self weekdayStringFromDate:date];
            
            NSString *str = [NSString stringWithFormat:@"%@ %@",timeStr,weekStr];
            NSLog(@"%@",str);
            [_oneTextArr addObject:str];
        }
//    }
    
    return _oneTextArr;
}
#pragma mark 根据当前日期计算星期几
- (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}
#pragma mark - 将某个时间转化成时间字符串
-(NSString *)timeSwitchTimestamp:(NSDate *)date andFormatter:(NSString *)format{
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    
    
    //    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    
    //转字符串
    NSString *timeStr = [formatter stringFromDate:date];
    
    
    //时间转时间戳的方法:
    //    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    //
    //
    //    NSLog(@"将某个时间转化成 时间戳&&&&&&&timeSp:%ld",(long)timeSp); //时间戳的值
    
    return timeStr;
    
}
@end
