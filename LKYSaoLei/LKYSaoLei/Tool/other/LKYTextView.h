//
//  LKYTextView.h
//  timeshare
//
//  Created by song ce on 2018/9/19.
//  Copyright © 2018年 song ce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LKYTextView : UITextView

@property(nonatomic,assign)IBInspectable CGFloat fitFont;

-(CGSize)setAttributeWithStr:(NSString *)str andFontName:(UIFont *)font andFontColor:(UIColor *)color andIsCenter:(BOOL)isCenter;
// 是否显示完成
@property(nonatomic,assign) BOOL isHiddenComplete;
@end
