//
//  LKYButton.m
//  常用第三方与工具类
//
//  Created by song ce on 2018/11/15.
//  Copyright © 2018年 song ce. All rights reserved.
//

#import "LKYButton.h"

@implementation LKYButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame andButton:(LKYButtonType)buttonType
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bType = buttonType;
        if (buttonType == buttonTypeEdge) {
            _edgeTop = 0;
            _edgeLeft =0;
            _edgeBottom = 0;
            _edgeRight = 0;
        }
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.bType==buttonTypeEdge) {
        
        if (self.titleLabel.text.length>0) {
            
            self.titleLabel.frame = CGRectMake(0, _edgeTop, self.width-_edgeLeft-_edgeRight, self.height-_edgeTop-_edgeBottom);
            self.titleLabel.right = self.width-_edgeRight;
        }
        else
        {
            self.imageView.frame = CGRectMake(_edgeLeft,_edgeTop, self.width-_edgeLeft-_edgeRight,self.height-_edgeTop-_edgeBottom);
        }
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    else if (self.bType==buttonTypeHome)
    {
        CGFloat BUT = self.height/(H(85));
        
        self.imageView.frame = CGRectMake(0, H(12)*BUT, H(43), H(35)*BUT);
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        self.titleLabel.frame = CGRectMake(0,H(58)*BUT, self.width,H(24)*BUT);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        //    self.titleLabel.font = FONT14;
        self.imageView.centerX = self.titleLabel.centerX;
    }
    else if (self.bType==buttontypeArrow)
    {
        if (self.imageW>0) {
            self.imageView.width = self.imageW;
        }
        else
        {
            self.imageView.width = W(10);
        }
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.imageView.image.size.width-W(5),0, self.imageView.image.size.width+W(5))];
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, self.titleLabel.bounds.size.width,0, -self.titleLabel.bounds.size.width)];
    }
}
#pragma mark 设置自适应字体
- (void)setFitFont:(CGFloat)fitFont
{
    //    self.fitFont = fitFont;
    self.titleLabel.font = [UIFont systemFontOfSize:W(fitFont)];
}
@end
