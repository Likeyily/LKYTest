//
//  LKYButton.h
//  常用第三方与工具类
//
//  Created by song ce on 2018/11/15.
//  Copyright © 2018年 song ce. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,LKYButtonType) {
    
    buttonTypeEdge,
    buttonTypeHome,
    buttontypeArrow,
    
    
};

@interface LKYButton : UIButton


@property(nonatomic,assign)LKYButtonType bType;

@property(nonatomic,assign)IBInspectable CGFloat fitFont;

/**上边距*/
@property(nonatomic,assign)CGFloat edgeTop;
/**左边距*/
@property(nonatomic,assign)CGFloat edgeLeft;
/**下边距*/
@property(nonatomic,assign)CGFloat edgeBottom;
/**右边距*/
@property(nonatomic,assign)CGFloat edgeRight;
/**图片的宽度*/
@property(nonatomic,assign)CGFloat imageW;

-(instancetype)initWithFrame:(CGRect)frame andButton:(LKYButtonType )buttonType;

@end

NS_ASSUME_NONNULL_END
