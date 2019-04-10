//
//  net_sendDataToServer.h
//  block
//
//  Created by song ce on 2018/11/26.
//  Copyright © 2018年 song ce. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "net_CallWebservice.h"

/**解析完成后的代理方法*/
@protocol net_OnSendDataComplete <NSObject>

//必须实现的方法
@required
//可选择实现的方法
@optional

/**
 请求失败错误处理
 error 失败信息
 mark 0直接显示错误信息 1数据请求失败 2网络异常
*/

- (void)sendDataError:(NSString *)error andMark:(int)mark;

/**
 请求成功
 */
-(void)sendDataSuccess:(id)result;


@end

NS_ASSUME_NONNULL_BEGIN

@interface net_sendDataToServer : NSObject<net_CallWebDelegate>

//weak 不可以用的原因
@property(nonatomic,strong)id<net_OnSendDataComplete>delegate;

/**发送请求*/
-(void)setSendDataToServer:(NSDictionary *)serverDic AndAddress:(NSString *)address;

/**
 发送数据请求
 mark 有特殊需要时候使用
 */

- (void)setSendDataToServer:(NSDictionary *)serverDic AndAddress:(NSString *)address andForMark:(NSString *)mark;

/**再次进行请求*/

@end

NS_ASSUME_NONNULL_END
