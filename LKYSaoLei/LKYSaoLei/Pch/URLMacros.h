//
//  URLMacros.h
//  项目框架结构
//
//  Created by song ce on 2018/11/13.
//  Copyright © 2018年 song ce. All rights reserved.
//

#ifndef URLMacros_h
#define URLMacros_h

//------------通知相关------------
//登录状态改变通知
#define NLoginStateChange @"loginStateChange"
//打包版本信息
#define app_build [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]


#define SERVICEIP @"http://www.cfkjltd.cn/TimeSharePlatform/"

//#define SERVICEIP @"http://192.168.0.20:8081/TimeSharePlatform/"

#define PICURL @"http://cfkjcommon1.oss-cn-beijing.aliyuncs.com/timeshare/"

/**房屋预订主页轮播图*/
#define URL_slideShow @"slideShow"

#endif /* URLMacros_h */
