//
//  LKYFailView.h
//  extra.mall.merchant
//
//  Created by song ce on 2018/8/30.
//  Copyright © 2018年 song ce. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ButtonBlock) (id sender);

@interface LKYFailView : UIView

- (void)addButtonAction:(ButtonBlock)block;

@property(nonatomic,strong)NSString *title;

@end
