//
//  USMacros.h
//  项目框架结构
//
//  Created by song ce on 2018/11/13.
//  Copyright © 2018年 song ce. All rights reserved.
//

#ifndef USMacros_h
#define USMacros_h

#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height
#define H(b) SCREEN_HEIGHT * b / 667
#define W(a) SCREEN_WIDTH * a / 375
#define F(c) (SCREEN_WIDTH>375)?SCREEN_WIDTH:((SCREEN_WIDTH+375)/2)*c/375

/**
 判断机型是否是iPhoneX
 */

#define kStatusBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height)
#define IsiPhoneX (kStatusBarHeight > 20.0f)


/**
 适配导航栏
 */
#define NAVH (IsiPhoneX ? 88 : 64)
#define TABBH (IsiPhoneX ? 34 : 0)


//主题颜色
#define Themecolor [UIColor colorWithRed:130/255.0 green:174/255.0 blue:49/255.0 alpha:1]

#define BackColor238 [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]
#define LightBackColor249 [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1]

#define TextColor50 [UIColor colorWithRed:50/255.0 green:40/255.0 blue:40/255.0 alpha:1]
#define TextColor34 [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1]
#define TextColor93 [UIColor colorWithRed:93/255.0 green:93/255.0 blue:93/255.0 alpha:1]
#define TextColor153 [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1]
#define TextColor170 [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1]
#define TextColor190 [UIColor colorWithRed:190/255.0 green:190/255.0 blue:190/255.0 alpha:1]

#define arcColor [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1]

/**
 字体大小
 */
#define FONT(a) [UIFont systemFontOfSize:F(a)]

#endif /* USMacros_h */
