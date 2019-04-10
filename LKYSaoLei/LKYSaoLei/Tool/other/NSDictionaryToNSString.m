//
//  NSDictionaryToNSString.m
//  ChlErpNormal
//
//  Created by Lky on 2017/11/2.
//  Copyright © 2017年 Chuanglian. All rights reserved.
//

#import "NSDictionaryToNSString.h"

@implementation NSDictionaryToNSString

+(NSString *)toNSStringWithDic:(NSDictionary *)dic
{
    NSArray* arr = [dic allKeys];
    NSString *str = @"{";
    for (int i = 0; i<arr.count; i++) {
        NSString *key = arr[i];
        id  value= [dic objectForKey:key];
        if ([value isKindOfClass:[NSDictionary class]]||[value isKindOfClass:[NSArray class]]) {
            NSString *vStr = @"";
            if ([value isKindOfClass:[NSArray class]]) {
                vStr = [[super class] toNSStringWithArr:value];
            }
            else
            {
                vStr = [[super class] toNSStringWithDic:value];
            }
            str = [NSString stringWithFormat:@"%@\"%@\":%@",str,key,vStr];
   
        }
        else
        {
        str = [NSString stringWithFormat:@"%@\"%@\":\"%@\"",str,key,value];
        }
        if (i!=arr.count-1) {
            str =[str stringByAppendingString:@","];
        }
    }
    str = [str stringByAppendingString:@"}"];
    
    return str;
}
+(NSString *)toNSStringWithArr:(NSArray *)arr
{
    NSMutableArray *zArr = [NSMutableArray array];

    for (id dic in arr) {
        if ([dic isKindOfClass:[NSDictionary class]]) {
            [zArr addObject:[NSDictionaryToNSString toNSStringWithDic:dic]];
        }
        else
        {
            [zArr addObject:dic];
        }
    }
    NSString *string = [zArr componentsJoinedByString:@","];
    NSString * zStr = [NSString stringWithFormat:@"[%@]",string];
    
    return zStr;
}
@end
