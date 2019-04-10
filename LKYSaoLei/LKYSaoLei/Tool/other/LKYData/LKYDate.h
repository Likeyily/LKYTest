//
//  LKYDate.h
//  timeshare
//
//  Created by song ce on 2018/5/24.
//  Copyright © 2018年 song ce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKYDate : NSObject

//pragma mark 获取当前时间
+ (NSString *)getCurrentTimewithFormat:(NSString *)format;
//pragma mark 将字符串转成NSDate类型
+ (NSDate *)dateFromString:(NSString *)dateString;
//pragma mark - 将某个时间转化成 时间戳
-(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;
//pragma mark 传入今天的时间，返回明天的时间
+ (NSString *)GetTomorrowDay:(NSDate *)aDate withFormat:(NSString *)format;
//pragma mark 获取星期
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;
//根据日期获取时间字符串
+(NSString *)timeMakeTimestamp:(NSDate *)date andFormatter:(NSString *)forma;
//pragma mark 比较两个日期字符串的大小
+ (NSInteger)compareStringDate:(NSString*)aDate withDate:(NSString*)bDate;
//pragma mark 比较两个日期的大小
+ (NSInteger)compareDate:(NSDate*)aDate withDate:(NSDate*)bDate;
//pragma mark 计算时间差
+ (int)getTimebySubtracting:(NSDate*)Date1 andDate2:(NSDate*)Date2;



@end
