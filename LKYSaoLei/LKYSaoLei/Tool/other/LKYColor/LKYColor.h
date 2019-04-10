//
//  LKYColor.h
//  timeshare
//
//  Created by song ce on 2018/6/9.
//  Copyright © 2018年 song ce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKYColor : NSObject

+ (UIColor *)colorWithHexString:(NSString *)color;

+ (UIColor *)colorWithHexString:(NSString *)color andAlpha:(CGFloat)alpha;

@end
