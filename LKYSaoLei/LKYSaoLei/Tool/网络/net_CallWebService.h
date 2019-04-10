//
//  net_CallWebService.h
//  block
//
//  Created by song ce on 2018/11/26.
//  Copyright © 2018年 song ce. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol net_CallWebDelegate <NSObject>

- (void)requsetDataSuccess:(id)Request;

-(void)requestDataError:(NSString *)error;

@end

@interface net_CallWebService : NSObject

/**测试委托代理人，代理一般需使用弱引用(weak)
 *注意 因为弱引用 出方法体就死
 *不能在发送请求以后回调使用
 */
@property (nonatomic,strong)id<net_CallWebDelegate>delegate;

/**
 使用AFNetworking 发起网络请求
 该方法用于请求普通变量不含上传图片
 
 
 */

-(void)call_serviceDataDic:(NSDictionary *)JsonParameter andURL:(NSString *)URLString;

@end

NS_ASSUME_NONNULL_END
