//
//  moreButton.m
//  chlweb
//
//  Created by Mac01 on 2018/3/30.
//  Copyright © 2018年 Mac01. All rights reserved.
//

#import "moreButton.h"

@implementation moreButton


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = FONT(13);
        self.imageEdgeInsets = UIEdgeInsetsMake(0, -H(2), 0, H(2));
        [self setTitleColor:TextColor153 forState:(UIControlStateNormal)];
        [self setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];
        self.clipsToBounds = YES;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = frame.size.height/2;
        self.layer.borderColor = TextColor153.CGColor;
        self.layer.borderWidth = 1;
//        self.backgroundColor = BackColor242;
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected==YES) {

        self.backgroundColor = Themecolor;
        self.layer.borderWidth = 0;
        
    }
    else if (selected == NO)
    {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 1;
    }
}

@end
