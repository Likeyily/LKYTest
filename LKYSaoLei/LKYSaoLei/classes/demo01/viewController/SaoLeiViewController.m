//
//  SaoLeiViewController.m
//  LKYSaoLei
//
//  Created by song ce on 2019/4/10.
//  Copyright © 2019年 song ce. All rights reserved.
//

#import "SaoLeiViewController.h"

#import "MButton.h"

@interface SaoLeiViewController ()

@property(nonatomic,strong)UIView *controlView;

@property(nonatomic,strong)UIView *saoLeiView;

/**创造数据数组*/
@property(nonatomic,strong)NSMutableArray *allArr;
/**按钮数组*/
@property(nonatomic,strong)NSMutableArray *buttonArr;
/**标出来雷的数组*/
@property(nonatomic,strong)NSMutableArray *showMArr;

/**总雷数*/
@property(nonatomic,assign)int MTotal;

/**是否可以表雷*/
@property(nonatomic,assign)BOOL isM;

/**定时器*/
@property(nonatomic,strong)NSTimer *gameTimer;

/**定时器显示*/
@property(nonatomic,strong)UILabel *timeLabel;

/**定时器计数*/
@property(nonatomic,assign)int timeNumber;

/**定时器是否开启*/
@property(nonatomic,assign) BOOL isOpen;

/**剩余雷的数量*/
@property(nonatomic,strong)UILabel *remainingMLabel;

@property(nonatomic,assign)int remainingNum;

/**最高分数*/
@property(nonatomic,strong)UILabel *highestScorelabel;

/**设置视图*/
@property(nonatomic,strong)UIView *maskSetView;

/**滑动条*/
@property(nonatomic,strong)UISlider *mNumSlider;
/**滑动条值*/
@property(nonatomic,strong)UILabel *sliderValueLabel;
/**每行多少格*/
@property(nonatomic,strong)UITextField *rowForLine;
@property(nonatomic,assign)int rowForLineNum;

@end

@implementation SaoLeiViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = arcColor;
    
    self.MTotal = 55;
    
    self.rowForLineNum = 12;
    
    self.timeNumber = 0;
    self.remainingNum = self.MTotal;
    
    //添加控制栏
    [self addControlView];
    
    //添加扫雷视图
    [self addSaoLeiView];
    
    //定时器
    
    self.gameTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.gameTimer forMode:NSRunLoopCommonModes];
    [self.gameTimer setFireDate:[NSDate distantFuture]];
    
    
}

-(void)timerMethod
{
    self.timeNumber++;
    self.timeLabel.text = [NSString stringWithFormat:@"%ds",self.timeNumber];

}

#pragma mark  添加控制视图
-(void)addControlView
{
    self.controlView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.controlView];
    
    [self.controlView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(W(10)+NAVH-64);
        make.height.equalTo(@(W(50)));
    }];
    
    NSArray *arr = @[@"正常",@"💣"];
    
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:arr];
    segment.frame = CGRectMake(15, W(10), W(100), W(40));
    [self.controlView addSubview:segment];
    segment.selectedSegmentIndex = 0;
//    segment.tintColor = [UIColor redColor];
    [segment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:(UIControlStateNormal)];
    [segment addTarget:self action:@selector(changeType:) forControlEvents:(UIControlEventValueChanged)];
    
    //时间
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, W(0), W(80), W(30))];
    self.timeLabel.text = [NSString stringWithFormat:@"%d s",self.timeNumber];
    //self.controlView.width 不能用是0
    self.timeLabel.centerX = (SCREEN_WIDTH-30)/2+15;
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.textColor = [UIColor redColor];
    [self.controlView addSubview:self.timeLabel];
    
    //最高分
    NSString *hsStr = @"--";
    NSDictionary *hsDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"highestScore"];
    
    if (hsDic) {
        if ([[hsDic allKeys] containsObject:[NSString stringWithFormat: @"%d%d",self.MTotal,self.rowForLineNum]]) {
            hsStr = hsDic[[NSString stringWithFormat: @"%d%d",self.MTotal,self.rowForLineNum]];
        }
    }
    
    self.highestScorelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, W(30), W(120), W(20))];
//    NSLog(@"%f>>>%f",F(100),SCREEN_WIDTH);
    self.highestScorelabel.text = [NSString stringWithFormat:@"时间记录：%@",hsStr];
    //self.controlView.width 不能用是0
    self.highestScorelabel.font = [UIFont systemFontOfSize:12];
    self.highestScorelabel.textColor = TextColor50;
    self.highestScorelabel.centerX = (SCREEN_WIDTH-30)/2+15;
    self.highestScorelabel.textAlignment = NSTextAlignmentCenter;
    [self.controlView addSubview:self.highestScorelabel];
    
    //剩余雷数
    self.remainingMLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, W(10), W(50), W(40))];
    self.remainingMLabel.text = [NSString stringWithFormat:@"%d",self.remainingNum];
    self.remainingMLabel.right = SCREEN_WIDTH-30-W(60);
    self.remainingMLabel.textAlignment = NSTextAlignmentRight;
    [self.controlView addSubview:self.remainingMLabel];
    
    //设置按钮
    UIButton *setButton = [[UIButton alloc]initWithFrame:CGRectMake(0, W(20), W(60), W(20))];
    [setButton setImage:[UIImage imageNamed:@"设置"] forState:(UIControlStateNormal)];
    [setButton addTarget:self action:@selector(setSetting:) forControlEvents:(UIControlEventTouchUpInside)];
    setButton.right = SCREEN_WIDTH-30;
    setButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.controlView addSubview:setButton];
}
#pragma mark 设置
-(void)setSetting:(UIButton *)button
{
    self.maskSetView.hidden = NO;
}
-(void)changeType:(UISegmentedControl *)seg
{
    if (seg.selectedSegmentIndex == 0) {
        self.isM = NO;
    }
    else if (seg.selectedSegmentIndex == 1)
    {
        self.isM = YES;
    }
}
#pragma mark 添加扫雷视图
-(void)addSaoLeiView
{
    self.saoLeiView = [[UIView alloc]initWithFrame:CGRectZero];
//    self.saoLeiView.backgroundColor = BackColor238;//不重新设置约束会留边，去掉底部颜色
    [self.view addSubview:self.saoLeiView];
    
    CGFloat ww = (SCREEN_WIDTH-30)/self.rowForLineNum;
    
    int hLine = self.rowForLineNum*3/2;
    
    [self.saoLeiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.equalTo(@(ww*hLine));
        make.centerY.equalTo(self.view).offset((NAVH-64+W(30))/2);
    }];
    
    //添加雷
    [self addMines];
    //添加按钮
    [self addButtons];
}

- (NSMutableArray *)allArr
{
    if (!_allArr) {
        
        //初始化allArr;
        [self initAllArr];
        
    }
    return _allArr;
}
#pragma mark z初始化总数组
-(void)initAllArr
{
    _allArr = [NSMutableArray array];
    for (int i = 0; i<self.rowForLineNum*3/2; i++) {
        NSMutableArray *unitArr = [NSMutableArray array];
        for (int j=0; j<self.rowForLineNum; j++) {
            [unitArr addObject:@""];
        }
        [_allArr addObject:unitArr];
    }
}
#pragma mark 添加所有雷
-(void)addMines
{
    for (int i= 0; i<self.MTotal; i++) {
        
        [self addM];
    }
}
#pragma mark 添加雷
-(void)addM
{
    int arcLine = arc4random()%self.rowForLineNum*3/2;
    int arcRow = arc4random()%self.rowForLineNum;
    
    NSArray *unitArr = self.allArr[arcLine];
    NSString *resultStr = unitArr[arcRow];
    
    if ([resultStr isEqualToString:@"💣"]) {
        [self addM];
    }
    else
    {
        self.allArr[arcLine][arcRow] = @"💣";
    }
    
    
}
#pragma mark 添加按钮
-(void)addButtons
{
    
    for (int i = 0; i<self.rowForLineNum*3/2; i++) {
        NSMutableArray *unitArr = [NSMutableArray array];
        for (int j=0; j<self.rowForLineNum; j++) {
            [unitArr addObject:@""];
        }
        [_allArr addObject:unitArr];
    }
    
    self.buttonArr = [NSMutableArray array];
    CGFloat ww = (SCREEN_WIDTH-30)/self.rowForLineNum;
    for (int i = 0; i<self.rowForLineNum*3/2; i++) {
        
        NSMutableArray *unitArr = [NSMutableArray array];
        
        for (int j=0; j<self.rowForLineNum; j++) {

            MButton *button = [[MButton alloc]initWithFrame:CGRectMake(j*ww, i*ww, ww, ww)];
            [button setTitle:@" " forState:(UIControlStateNormal)];
            
            [button setTitle:@"🚩" forState:(UIControlStateSelected)];
            button.backgroundColor = [UIColor colorWithRed:133/255.0 green:181/255.0 blue:255/255.0 alpha:1];
            button.layer.borderColor = BackColor238.CGColor;
            button.layer.borderWidth = 1;
            button.line = i;
            button.row = j;
            [button addTarget:self action:@selector(clicpM:) forControlEvents:(UIControlEventTouchUpInside)];

            [self.saoLeiView addSubview:button];
            
            [unitArr addObject:button];

        }
        [self.buttonArr addObject:unitArr];
    }
}
#pragma mark 点击
-(void)clicpM:(MButton *)button
{
    //定时器是否开启
    if (!self.isOpen) {
        [self.gameTimer setFireDate:[NSDate distantPast]];
        self.isOpen = YES;
    }
    //是否处于表雷状态
    if (self.isM) {
        if (button.selected) {
            button.selected = NO;
            self.remainingNum++;
            [self.showMArr removeObject:button];
        }
        else
        {
            button.selected = YES;
            self.remainingNum--;
            [self.showMArr addObject:button];
        }
        self.remainingMLabel.text = [NSString stringWithFormat:@"%d",self.remainingNum];
        
        if (self.remainingNum ==0) {
            [self isSuccess];
        }
        return;
    }
    
    NSString *Str = self.allArr[button.line][button.row];
  
    if ([Str isEqualToString:@"💣"]) {
        
        [self.gameTimer setFireDate:[NSDate distantFuture]];
        [self gameOver];
        
    }
    else
    {
        //判断雷的数量
        [self getRoundMNum:button];
        
    }
    
    
}
#pragma mark 判断雷的数量
-(void)getRoundMNum:(MButton *)button
{
    button.userInteractionEnabled = NO;
    int line = button.line;
    int row = button.row;
    int total = 0;
    
    NSMutableArray *rButtonArr = [NSMutableArray array];
    
    //上
    if (line>0) {
        
        MButton *mButton = self.buttonArr[line-1][row];
        [rButtonArr addObject:mButton];
        
        NSString *round = self.allArr[line-1][row];

        if ([round isEqualToString:@"💣"]) {
            total++;
        }
    }
    //下
    if(line<self.rowForLineNum*3/2-1)
    {
        MButton *mButton = self.buttonArr[line+1][row];
        [rButtonArr addObject:mButton];
        
        NSString *round = self.allArr[line+1][row];
        
        if ([round isEqualToString:@"💣"]) {
            total++;
        }
    }
    //左
    if(row>0)
    {
        MButton *mButton = self.buttonArr[line][row-1];
        [rButtonArr addObject:mButton];
        
        NSString *round = self.allArr[line][row-1];
        if ([round isEqualToString:@"💣"]) {
            total++;
        }
    }
    //右
    if(row<self.rowForLineNum-1)
    {
        MButton *mButton = self.buttonArr[line][row+1];
        [rButtonArr addObject:mButton];
        
        NSString *round = self.allArr[line][row+1];
        if ([round isEqualToString:@"💣"]) {
            total++;
        }
    }
    //左上
    if(line>0&&row>0)
    {
        MButton *mButton = self.buttonArr[line-1][row-1];
        [rButtonArr addObject:mButton];
        
        NSString *round = self.allArr[line-1][row-1];
        if ([round isEqualToString:@"💣"]) {
            total++;
        }
    }
    //右上
    if(line>0&&row<self.rowForLineNum-1)
    {
        MButton *mButton = self.buttonArr[line-1][row+1];
        [rButtonArr addObject:mButton];
        
        NSString *round = self.allArr[line-1][row+1];
        if ([round isEqualToString:@"💣"]) {
            total++;
        }
    }
    //左下
    if(row>0&&line<self.rowForLineNum*3/2-1)
    {
        MButton *mButton = self.buttonArr[line+1][row-1];
        [rButtonArr addObject:mButton];
        
        NSString *round = self.allArr[line+1][row-1];
        if ([round isEqualToString:@"💣"]) {
            total++;
        }
    }
    //右下
    if(line<self.rowForLineNum*3/2-1&&row<self.rowForLineNum-1)
    {
        MButton *mButton = self.buttonArr[line+1][row+1];
        [rButtonArr addObject:mButton];
        
        NSString *round = self.allArr[line+1][row+1];
        if ([round isEqualToString:@"💣"]) {
            total++;
        }
    }
    
    if (total>0) {
        [button setTitle:[NSString stringWithFormat:@"%d",total] forState:(UIControlStateNormal)];
    }
    else
    {
        //@“” 用于button再取出来会变成null，有时候又会是@“ ”，分不清 button 的初始状态时@“ ”
        [button setTitle:@"V" forState:(UIControlStateNormal)];
        button.backgroundColor = BackColor238;
        for (MButton *bt in rButtonArr) {

            NSLog(@"按钮内容%@。",bt.titleLabel.text);
            
            if ([bt.titleLabel.text isEqualToString:@" "]&&(bt.selected==NO)) {

                [self getRoundMNum:bt];

            }
            
        }
    }
}
#pragma mark  判断是否胜利
-(void)isSuccess
{
    
    BOOL isSuccess = YES;
    
    for (MButton *bt in self.showMArr) {
        NSString *str = self.allArr[bt.line][bt.row];
        if (![str isEqualToString:@"💣"]) {
            isSuccess = NO;
        }
    }
    
    if (isSuccess) {
        
        //成功
        [self.gameTimer setFireDate:[NSDate distantFuture]];
        
        //储存最高记录
        NSDictionary *hsDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"highestScore"];
        if (!hsDic) {
            hsDic = @{@"highestScore":@"--"};
            
        }
        
        NSString * oldHighestStr = [hsDic objectForKey:@"highestScore"];
        
        int nHs = self.timeNumber;
        
        if (![oldHighestStr isEqualToString:@"--"]) {
            if (nHs<[oldHighestStr intValue]) {
                NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithDictionary:hsDic];
                
                [mdic setValue:[NSString stringWithFormat:@"%d",self.timeNumber] forKey:[NSString stringWithFormat: @"%d%d",self.MTotal,self.rowForLineNum]];
                [[NSUserDefaults standardUserDefaults] setObject:mdic forKey:@"highestScore"];
            }
        }
        else
        {
            NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithDictionary:hsDic];
            
            [mdic setValue:[NSString stringWithFormat:@"%d",self.timeNumber] forKey:[NSString stringWithFormat: @"%d%d",self.MTotal,self.rowForLineNum]];
            [[NSUserDefaults standardUserDefaults] setObject:mdic forKey:@"highestScore"];
        }
        
        
        
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"成功" message:@"您已成功拆除所有雷" preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
            [self startAgain];
        }];
        
        
        [alert addAction:sureAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
}
#pragma mark 游戏结束
-(void)gameOver
{
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"gameOver" message:@"是否重新开始游戏" preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        [self startAgain];
    }];
    
    [alert addAction:sureAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

#pragma mark 重新开始游戏
-(void)startAgain
{
    self.remainingNum = self.MTotal;
    self.timeNumber = 0;
    self.remainingMLabel.text = [NSString stringWithFormat:@"%d",self.remainingNum];
    self.timeLabel.text = [NSString stringWithFormat:@"%ds",self.timeNumber];
    self.isOpen = NO;
    
    //重新初始化总数组
    [self initAllArr];
    
    //已标雷
    self.showMArr = [NSMutableArray array];
    
    //添加雷
    [self addMines];
    
    //最高分
    NSString *hsStr = @"--";
    NSDictionary *hsDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"highestScore"];
    
    if (hsDic) {
        if ([[hsDic allKeys] containsObject:[NSString stringWithFormat: @"%d%d",self.MTotal,self.rowForLineNum]]) {
            hsStr = hsDic[[NSString stringWithFormat: @"%d%d",self.MTotal,self.rowForLineNum]];
        }
    }
    self.highestScorelabel.text = [NSString stringWithFormat:@"最高分数：%@",hsStr];
    
    //所有按钮返回初始状态
    for (id bt in self.saoLeiView.subviews) {
        if ([bt isKindOfClass:[MButton class]]) {
            MButton *button = (MButton *)bt;
            
            [button setTitle:@" " forState:(UIControlStateNormal)];
            button.selected = NO;
            button.backgroundColor = [UIColor colorWithRed:133/255.0 green:181/255.0 blue:255/255.0 alpha:1];
            button.userInteractionEnabled = YES;
            
        }
    }
}

- (NSMutableArray *)buttonArr
{
    if (!_buttonArr) {
        _buttonArr = [NSMutableArray array];
    }
    
    return _buttonArr;
}
- (NSMutableArray *)showMArr
{
    if (!_showMArr) {
        _showMArr = [NSMutableArray array];
    }
    return _showMArr;
}
- (UIView *)maskSetView
{
    if (!_maskSetView) {
        _maskSetView = [[UIView alloc]initWithFrame:CGRectZero];
        _maskSetView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
        _maskSetView.hidden = YES;
        //添加到窗口
        UIWindow *myWindow = [UIApplication sharedApplication].keyWindow;
        [myWindow addSubview:_maskSetView];
        
        [_maskSetView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.equalTo(myWindow);
        }];
        
        
        //添加弹框内容
        [self addSetMaskContent];
    }
    
    return _maskSetView;
}
#pragma mark 添加蒙版内容
-(void)addSetMaskContent
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-W(60), (SCREEN_WIDTH-W(60))/16*9)];
    view.backgroundColor = [UIColor whiteColor];
    view.centerX = SCREEN_WIDTH/2;
    view.centerY = SCREEN_HEIGHT/2;
    view.clipsToBounds = YES;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = W(10);
    [self.maskSetView addSubview:view];
    
    self.mNumSlider = [[UISlider alloc]initWithFrame:CGRectMake(0, W(5), view.width-30-W(50), W(20))];
    self.mNumSlider.x = 15;
    self.mNumSlider.centerY = W(5)+view.height/6;
    self.mNumSlider.minimumValue = 30;
    self.mNumSlider.maximumValue = 60;
    self.mNumSlider.value = 55;
    self.mNumSlider.continuous = YES;//可连续设置
    [self.mNumSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [view addSubview:self.mNumSlider];
    
    self.sliderValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, W(5) , W(50),view.height/3)];
    self.sliderValueLabel.right = view.width-15;
    self.sliderValueLabel.text = [NSString stringWithFormat:@"%d",self.MTotal];
    self.sliderValueLabel.textAlignment = NSTextAlignmentCenter;
    
    [view addSubview:self.sliderValueLabel];
    
    self.rowForLine = [[UITextField alloc]initWithFrame:CGRectMake(0, W(5)+view.height/3, view.width, view.height/3)];
    self.rowForLine.placeholder = @"修改每行个数，默认12（7-15）";
    self.rowForLine.textAlignment = NSTextAlignmentCenter;
    self.rowForLine.keyboardType = UIKeyboardTypeNumberPad;
    [view addSubview:self.rowForLine];
    
    UIButton *sureButton = [[UIButton alloc]initWithFrame:CGRectMake(0, view.height/3*2, view.width, view.height/3)];
    [sureButton setTitle:@"确定" forState:(UIControlStateNormal)];
    [sureButton setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    [sureButton addTarget:self action:@selector(changeTotalM:) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:sureButton];
    
}
-(void)sliderValueChanged:(UISlider *)slider
{
    self.sliderValueLabel.text = [NSString stringWithFormat:@"%d",(int)slider.value];
}
#pragma mark 修改总雷数
-(void)changeTotalM:(UIButton *)button
{
    self.MTotal = (int)self.mNumSlider.value;
    
//    [self initAllArr];
 
    if (self.rowForLine.text.length>0) {
        int rn = [self.rowForLine.text intValue];
        if (rn>=7&&rn<=15) {
            for (id vv in self.saoLeiView.subviews) {
                if ([vv isKindOfClass:[MButton class]]) {
                    [vv removeFromSuperview];
                }
            }
            self.rowForLineNum = rn;
            [self addButtons];
        }
        else
        {
            [MBProgressHUD showError:@"输入错误"];
            return;
        }
    }
    //清空修改格数项
    self.rowForLine.text = @"";
    
    [self startAgain];
    [MBProgressHUD showError:@"开始新一局！"];
    [self.rowForLine resignFirstResponder];
    self.maskSetView.hidden = YES;
}
//#pragma mark 收回设置蒙版
//-(void)retureView:(UITapGestureRecognizer *)tap
//{
//    self.maskSetView.hidden = YES;
//}

@end
