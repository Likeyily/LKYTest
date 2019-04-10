//
//  AdapterLabel.h
//  ChlErpNormal
//
//  Created by Mac01 on 2018/3/5.
//  Copyright © 2018年 Chuanglian. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    VerticalAlignmentMiddle =0,// default
    VerticalAlignmentTop,
    VerticalAlignmentBottom,
    
} VerticalAlignment;

@interface AdapterLabel : UILabel

{
@private
    VerticalAlignment _verticalAlignment;
}

@property (nonatomic) VerticalAlignment verticalAlignment;

@property(nonatomic,assign)IBInspectable CGFloat fitFont;

/**两边对齐*/
-(void)labelAlightLeftAndRightWithWidth:(CGFloat)labelWidth;
/**将html转为富文本*/
-(CGSize)setAttributeWithStr:(NSString *)str andFontName:(UIFont *)font andFontColor:(UIColor *)color andIsCenter:(BOOL)isCenter;
/**设置行间距*/
-(void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing;

@end
