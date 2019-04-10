//
//  bk_slideShow.h
//  timeshare
//
//  Created by song ce on 2018/5/21.
//  Copyright © 2018年 song ce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "net_SendDataToServer.h"

@protocol protocol_slideShow <NSObject>

-(void)slideShowSuccess:(NSArray *)result;
-(void)slideShowError:(NSString *)error;

@end

@interface bk_slideShow : NSObject<net_OnSendDataComplete>

@property(nonatomic,weak)id<protocol_slideShow>delegate;

-(void)getslideShow;


@end
