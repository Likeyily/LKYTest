//
//  GlobalClass.m
//  block
//
//  Created by song ce on 2018/11/26.
//  Copyright © 2018年 song ce. All rights reserved.
//

#import "GlobalClass.h"
#import "Reachability.h"

@implementation GlobalClass

//检测网络
- (BOOL)isExistenceNetwork
{
    BOOL isExistenceNetwork;
    Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = FALSE;
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = TRUE;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = TRUE;
            isExistenceNetwork = TRUE;
            break;
        default:
            break;
    }
    
    return isExistenceNetwork;
}

@end
