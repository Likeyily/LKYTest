//
//  UserManager.m
//  项目框架结构
//
//  Created by song ce on 2018/11/13.
//  Copyright © 2018年 song ce. All rights reserved.
//

#import "UserManager.h"
static UserManager *shareUserManager = nil;

@interface UserManager()

@property(nonatomic,strong)NSString *str;

@end

@implementation UserManager

+ (UserManager *)shareUserManager
{
    //作用对代码加锁
    @synchronized (self) {
        if (shareUserManager == nil) {
            shareUserManager = [[self alloc]init];
            
            shareUserManager.userInfo.cId = [shareUserManager attributdNotNull:@"cId"];
            
        }
    }
    return shareUserManager;
}
#pragma mark 初始化数据
-(NSString *)attributdNotNull:(NSString *)key
{
    NSDictionary *accountInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"Myinformation"];
    
    NSString *str = accountInfo[key];
    if (!str) {
        str = @"";
    }
    return str;
}
#pragma mark get和set方法不能同时重写
- (NSString *)isLogined
{
    if (!_str) {
        _str = [[NSUserDefaults standardUserDefaults] objectForKey:@"isLogined"];
        if (!_str) {
            _str = @"";
        }
    }
    return _str;
}

- (void)setIsLogined:(NSString *)isLogined
{
    _str = isLogined;

    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setValue:isLogined forKey:@"isLogined"];

}

@end
