//
//  LKYDatePicker.h
//  timeshare
//
//  Created by song ce on 2018/6/30.
//  Copyright © 2018年 song ce. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LKYDateBlock)(NSDate *date,NSString *dateStr,NSString *timeStr);

@interface LKYDatePicker : UIView

@property(nonatomic,copy) LKYDateBlock block;

@property(nonatomic,assign)CGFloat rowH;

//传入最新的开始时间跟新弹框时间减小误差
@property(nonatomic,strong)NSDate *starDate;

+(LKYDatePicker *)shareView;

-(void)selectDateTitle:(NSString *)title BackBlock:(LKYDateBlock)block;


@end
