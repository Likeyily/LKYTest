//
//  NSDictionaryToNSString.h
//  ChlErpNormal
//
//  Created by Lky on 2017/11/2.
//  Copyright © 2017年 Chuanglian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionaryToNSString : NSObject

/**字典转数组*/
+(NSString *)toNSStringWithDic:(NSDictionary *)dic;
/**字典数组转字符串*/
+(NSString *)toNSStringWithArr:(NSArray *)arr;

@end
