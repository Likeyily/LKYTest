//
//  UIImage+SDWGif.h
//  项目框架结构
//
//  Created by song ce on 2018/11/27.
//  Copyright © 2018年 song ce. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (SDWGif)
+ (UIImage *)sd_animatedGIFNamed:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
