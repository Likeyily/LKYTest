//
//  UserManager.h
//  项目框架结构
//
//  Created by song ce on 2018/11/13.
//  Copyright © 2018年 song ce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserManager : NSObject

//当前用户账户信息
@property (nonatomic,strong) UserInfo *userInfo;

//判断是否登录
@property (nonatomic,strong) NSString * isLogined;

/**单利模式*/
+(UserManager *)shareUserManager;

@end

NS_ASSUME_NONNULL_END
