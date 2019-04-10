//
//  LKYFailView.m
//  extra.mall.merchant
//
//  Created by song ce on 2018/8/30.
//  Copyright © 2018年 song ce. All rights reserved.
//

#import "LKYFailView.h"


@interface LKYFailView ()

@property (nonatomic, strong, nullable) ButtonBlock block;
@property (nonatomic, strong, nullable) UIButton *button;
@property (nonatomic, strong)UILabel *titleLabel;

@end

@implementation LKYFailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(SCREEN_WIDTH*2/8, H(120), SCREEN_WIDTH *2/ 3, SCREEN_WIDTH / 2);
        [self addSubview:imageView];
        
//        NSMutableArray *imgArray = [NSMutableArray array];
//        for (int i=0; i<3; i++) {
//            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"netError%d.png",i]];
//            [imgArray addObject:image];
//        }
//        imageView.animationImages = imgArray;
//        imageView.animationDuration = 6*0.15;
//        imageView.animationRepeatCount = 0;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = [UIImage imageNamed:@"加载失败"];
        imageView.height = imageView.width/imageView.image.size.width*imageView.image.size.height;
        [imageView startAnimating];
        
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.frame = CGRectMake(0, imageView.bottom+10, SCREEN_WIDTH, 30);
        self.titleLabel.textColor = [UIColor redColor];
        self.titleLabel.text = @"网络连接不稳定";
        self.titleLabel.font = FONT(18);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.numberOfLines = 0;
        [self addSubview:self.titleLabel];
        
        UIButton *refreshBTN = [UIButton buttonWithType:UIButtonTypeCustom];
        [refreshBTN setTitle:@"刷新" forState:UIControlStateNormal];
        [refreshBTN setTitleColor:TextColor50 forState:UIControlStateNormal];
        refreshBTN.titleLabel.font = FONT(18);
//        refreshBTN.layer.masksToBounds = YES;
//        refreshBTN.layer.borderWidth = 1;
//        refreshBTN.layer.cornerRadius = 3;
//        refreshBTN.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        refreshBTN.frame = CGRectMake(SCREEN_WIDTH/2-50, self.titleLabel.frame.origin.y+30, 100, 30);
        [self addSubview:refreshBTN];
        [refreshBTN addTarget:self action:@selector(buttonAction) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return self;
}
//实现block回调的方法
- (void)addButtonAction:(ButtonBlock)block {
    
    
    self.block = block;
}
- (void)buttonAction {
    if (self.block) {
        self.block(self);
    }
}
- (void)setTitle:(NSString *)title
{
    if (title) {
        self.titleLabel.text = title;
    }
    else
    {
        self.titleLabel.text = @"网络连接不稳定";
    }
    
}


@end
