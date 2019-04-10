//
//  UITextFieldW.m
//  ChlErpNormal
//
//  Created by Lky on 2017/12/22.
//  Copyright © 2017年 Chuanglian. All rights reserved.
//

#import "UITextFieldW.h"
#import "TregularexpressionNSObjec.h"

@interface UITextFieldW()

/**记录上一步编辑后的内容*/
@property(nonatomic,strong)NSString *oldStr;

@end

@implementation UITextFieldW

- (void)drawRect:(CGRect)rect {
    // Drawing code

    
    UIToolbar *bar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,44)];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 7,50, 30)];
    [button setTitle:@"完成"forState:UIControlStateNormal];
    [button setTitleColor:Themecolor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(print) forControlEvents:UIControlEventTouchUpInside];
    //
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem *flexibleitem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemFlexibleSpace) target:self action:nil];
    NSArray *items = @[flexibleitem,flexibleitem,item];
    [bar setItems:items animated:YES];
    self.inputAccessoryView= bar;
    
    self.oldStr = self.text;
    
    //添加方法
    [self addTarget:self action:@selector(EditingChanged:) forControlEvents:(UIControlEventEditingChanged)];
    
}
-(void)print
{
    [[self superview]endEditing:YES];
}
#pragma mark 过滤表情
-(void)EditingChanged:(UITextFieldW *)textField
{
    
    if ([TregularexpressionNSObjec stringContainsEmoji:textField.text]) {
        textField.text = self.oldStr;
    }
    else
    {
        self.oldStr = textField.text;
    }
}
#pragma mark 设置自适应字体
- (void)setFitFont:(CGFloat)fitFont
{
    self.font = [UIFont systemFontOfSize:W(fitFont)];
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    //修改占位符文字颜色
    [self setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}
@end
