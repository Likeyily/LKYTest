//
//  bk_slideShow.m
//  timeshare
//
//  Created by song ce on 2018/5/21.
//  Copyright © 2018年 song ce. All rights reserved.
//

#import "bk_slideShow.h"

@implementation bk_slideShow

- (void)getslideShow
{
    net_sendDataToServer *net = [[net_sendDataToServer alloc]init];
    net.delegate = self;
    [net setSendDataToServer:@{} AndAddress:[NSString stringWithFormat:@"%@%@",SERVICEIP,URL_slideShow]];
}
- (void)sendDataSuccess:(id)result
{
    [self.delegate slideShowSuccess:result];
}
- (void)sendDataError:(NSString *)errer andMark:(int)mark
{
    [self.delegate slideShowError:errer];
}
@end
