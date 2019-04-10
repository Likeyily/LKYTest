//
//  net_CallWebService.m
//  block
//
//  Created by song ce on 2018/11/26.
//  Copyright © 2018年 song ce. All rights reserved.
//

#import "net_CallWebService.h"
#import "AFNetworking.h"

@implementation net_CallWebService

- (void)call_serviceDataDic:(NSDictionary *)JsonParameter andURL:(NSString *)URLString
{
    NSLog(@"入参：%@",JsonParameter);
    
    AFHTTPSessionManager *manager = [self getAFHTTPRequestInstall];
    
    //存储本地信息(或者在请求头里添加 密码账户信息等内容)
    
    [manager POST:URLString parameters:JsonParameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.delegate requsetDataSuccess:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [self.delegate requestDataError:@"网络异常"];
    }];
    
}
/**
 获取AFNetworking
 设置AFNetworking 的基本配置
 */
-(AFHTTPSessionManager *)getAFHTTPRequestInstall
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/xml",@"text/plain",@"image/png", nil];
    manager.requestSerializer.timeoutInterval = 60;
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    return manager;
}
@end
