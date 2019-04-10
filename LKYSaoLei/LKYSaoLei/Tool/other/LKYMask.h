//
//  LKYMask.h
//  timeshare
//
//  Created by song ce on 2018/6/16.
//  Copyright © 2018年 song ce. All rights reserved.
//

#import <UIKit/UIKit.h>

//定义block块
typedef void (^selectedBlock)(int index);


@interface LKYMask : UIView

@property(nonatomic,copy)selectedBlock indexBlock;

@property(nonatomic,strong)UIFont *fontSize;

@property(nonatomic,strong)UIColor *cellColor;

/**背景的透明度*/
@property(nonatomic,assign)CGFloat maskAlph;

/**最简单版*/
-(void)makeAMaskWithArr:(NSArray *)arr Frame:(CGRect)frame MyBlock:(selectedBlock)myblock;

-(void)returnView;

@end
