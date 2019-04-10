//
//  net_sendDataToServer.m
//  block
//
//  Created by song ce on 2018/11/26.
//  Copyright © 2018年 song ce. All rights reserved.
//

#import "net_sendDataToServer.h"

#import "GlobalClass.h"
#import "NSDictionary+NoNull.h"

@interface net_sendDataToServer()

@property(nonatomic,strong)NSString *mMark;

@property(nonatomic,strong)NSDictionary *mServerDic;

@property(nonatomic,strong)NSString *mAddress;


@end

@implementation net_sendDataToServer

- (void)setSendDataToServer:(NSDictionary *)serverDic AndAddress:(NSString *)address
{
    //打印请求地址
    NSLog(@"请求地址%@",address);
    
    self.mServerDic = serverDic;
    self.mAddress = address;
    
    //判断是否有网络
    GlobalClass *GClass = [[GlobalClass alloc]init];
    
    if ([GClass isExistenceNetwork]) {
        //正式开始网络请求
        
        net_CallWebService *service = [[net_CallWebService alloc]init];
        service.delegate = self;
        [service call_serviceDataDic:serverDic andURL:address];
        
    }
    else
    {
        [self.delegate sendDataError:@"网络链接异常,请重试!!!" andMark:2];
    }
    
}
- (void)setSendDataToServer:(NSDictionary *)serverDic AndAddress:(NSString *)address andForMark:(NSString *)mark
{
    self.mMark = mark;
    [self setSendDataToServer:serverDic AndAddress:address];
}

/**再次进行请求*/

- (void)requsetDataSuccess:(id)Request
{
    NSString *result = [[NSString alloc]initWithData:Request encoding:NSUTF8StringEncoding];
    NSLog(@"data:%@",result);
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:Request options:NSJSONReadingAllowFragments error:nil];
    dict = [NSDictionary changeType:dict];
    
    //根据实际情况具体设置
    if ([dict[@"flag"] isEqualToString:@"true"]) {
        [self.delegate sendDataSuccess:dict[@"data"]];
    }
    else
    {
        [self.delegate sendDataError:dict[@"errorString"] andMark:0];
    }
    
}
- (void)requestDataError:(NSString *)error
{
    [self.delegate sendDataError:error andMark:1];
}

@end
