//
//  NSObject+MyKeyValue.m
//  常用第三方与工具类
//
//  Created by song ce on 2018/10/11.
//  Copyright © 2018年 song ce. All rights reserved.
//

#import "NSObject+MyKeyValue.h"
#import "NSObject+MJKeyValue.h"

@implementation NSObject (MyKeyValue)

/**
 *  将属性名换为其他key去字典中取值
 *
 *  @return 字典中的key是属性名，value是从字典中取值用的key
 
 注：在作用类里实现该方法，返回键值对
 + (NSDictionary *)mj_replacedKeyFromPropertyName
 {
 return @{@"ID": @"id"};
 }
 */
+ (NSDictionary *)my_replacedKeyFromPropertyName
{
   return [self mj_replacedKeyFromPropertyName];
}
/**
 *  将模型转成字典
 *  @return 字典
 */
- (NSMutableDictionary *)my_keyValues
{
    return [self mj_keyValues];
}
- (NSMutableDictionary *)my_keyValuesWithKeys:(NSArray *)keys
{
    return [self mj_keyValuesWithKeys:keys];
}
- (NSMutableDictionary *)my_keyValuesWithIgnoredKeys:(NSArray *)ignoredKeys
{
    return [self mj_keyValuesWithIgnoredKeys:ignoredKeys];
}
#pragma mark 字典转模型
/**
 *  通过字典来创建一个模型
 *  @param keyValues 字典(可以是NSDictionary、NSData、NSString)
 *  @return 新建的对象
 */
+ (instancetype)my_objectWithKeyValues:(id)keyValues
{
    return [self mj_objectWithKeyValues:keyValues];
}

/**
 *  通过字典来创建一个CoreData模型
 *  @param keyValues 字典(可以是NSDictionary、NSData、NSString)
 *  @param context   CoreData上下文
 *  @return 新建的对象
 */
+ (instancetype)my_objectWithKeyValues:(id)keyValues context:(NSManagedObjectContext *)context
{
    return [self mj_objectWithKeyValues:keyValues context:context];
}

/**
 *  通过plist来创建一个模型
 *  param filename 文件名(仅限于mainBundle中的文件)
 *  return 新建的对象
 */
+ (instancetype)my_objectWithFilename:(NSString *)filename
{
    return [self mj_objectWithFilename:filename];
}

/**
 *  通过plist来创建一个模型
 *  param  file 文件全路径
 *  return  新建的对象
 */
+ (instancetype)my_objectWithFile:(NSString *)file
{
    return [self mj_objectArrayWithFile:file];
}
#pragma mark - 字典数组转模型数组
/**
 *  通过字典数组来创建一个模型数组
 *  @param keyValuesArray 字典数组(可以是NSDictionary、NSData、NSString)
 *  @return 模型数组
 */
+ (NSMutableArray *)my_objectArrayWithKeyValuesArray:(id)keyValuesArray
{
    return [self mj_objectArrayWithKeyValuesArray:keyValuesArray];
}

/**
 *  通过字典数组来创建一个模型数组
 *  @param keyValuesArray 字典数组(可以是NSDictionary、NSData、NSString)
 *  @param context        CoreData上下文
 *  @return 模型数组
 */
+ (NSMutableArray *)my_objectArrayWithKeyValuesArray:(id)keyValuesArray context:(NSManagedObjectContext *)context
{
    return [self mj_objectArrayWithKeyValuesArray:keyValuesArray context:context];
}

/**
 *  通过plist来创建一个模型数组
 *  @param filename 文件名(仅限于mainBundle中的文件)
 *  @return 模型数组
 */
+ (NSMutableArray *)my_objectArrayWithFilename:(NSString *)filename
{
    return [self mj_objectArrayWithFilename:filename];
}

/**
 *  通过plist来创建一个模型数组
 *  @param file 文件全路径
 *  @return 模型数组
 */
+ (NSMutableArray *)my_objectArrayWithFile:(NSString *)file
{
    return [self mj_objectArrayWithFile:file];
}
#pragma mark - 转换为JSON
/**
 *  转换为JSON Data
 */
- (NSData *)my_JSONData
{
    return [self my_JSONData];
}
/**
 *  转换为字典或者数组
 */
- (id)my_JSONObject
{
    return [self my_JSONObject];
}
/**
 *  转换为JSON 字符串
 */
- (NSString *)my_JSONString
{
    return [self my_JSONString];
}

@end
