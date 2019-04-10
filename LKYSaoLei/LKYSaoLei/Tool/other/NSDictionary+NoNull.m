//
//  NSDictionary+NoNull.m
//  ChlNewHouse
//
//  Created by 晨创科技 on 2017/8/21.
//  Copyright © 2017年 Chuanglian. All rights reserved.
//

#import "NSDictionary+NoNull.h"

@implementation NSDictionary (NoNull)

//将NSDictionary中的Null类型的项目转化成@""

+(NSDictionary *)nullDic:(NSDictionary *)myDic

{
    
    NSArray *keyArr = [myDic allKeys];
    
    NSMutableDictionary *resDic = [[NSMutableDictionary alloc]init];
    
    for (int i = 0; i < keyArr.count; i ++)
        
    {
        
        id obj = [myDic objectForKey:keyArr[i]];
        
        
        
        obj = [self changeType:obj];
        
        
        
        [resDic setObject:obj forKey:keyArr[i]];
        
    }
    
    return resDic;
    
}

//将NSDictionary中的Null类型的项目转化成@""

+(NSArray *)nullArr:(NSArray *)myArr

{
    
    NSMutableArray *resArr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < myArr.count; i ++)
        
    {
        
        id obj = myArr[i];
        
        
        
        obj = [self changeType:obj];
        
        
        
        [resArr addObject:obj];
        
    }
    
    return resArr;
    
}
//将NSString类型的原路返回

+(NSString *)stringToString:(NSString *)string

{
    
    return string;
    
}



//将Null类型的项目转化成@""

+(NSString *)nullToString

{
    
    return @"";
    
}



#pragma mark - 公有方法

//类型识别:将所有的NSNull类型转化成@""

+(id)changeType:(id)myObj

{
    
    if ([myObj isKindOfClass:[NSDictionary class]])
        
    {
        
        return [self nullDic:myObj];
        
    }
    
    else if([myObj isKindOfClass:[NSArray class]])
        
    {
        
        return [self nullArr:myObj];
        
    }
    
    else if([myObj isKindOfClass:[NSString class]])
        
    {
        
        return [self stringToString:myObj];
        
    }
    
    else if([myObj isKindOfClass:[NSNull class]])
        
    {
        
        return [self nullToString];
        
    }
    else if (![myObj isKindOfClass:[NSString class]])
    {
        //最后结果仍不等于字符串，转成字符串后返回
        return [NSString stringWithFormat:@"%@",myObj];
    }
    else
        
    {
        
        return myObj;
        
    }
    
}

@end
