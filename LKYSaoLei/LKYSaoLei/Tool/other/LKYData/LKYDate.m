//
//  LKYDate.m
//  timeshare
//
//  Created by song ce on 2018/5/24.
//  Copyright © 2018年 song ce. All rights reserved.
//

#import "LKYDate.h"

@implementation LKYDate

//获取当地时间
+ (NSString *)getCurrentTimewithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}
//将字符串转成NSDate类型
+ (NSDate *)dateFromString:(NSString *)dateString {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}
#pragma mark - 将某个时间转化成 时间戳

+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format{
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    
    
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    
    //时间转时间戳的方法:
    
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    
    
    
    NSLog(@"将某个时间转化成 时间戳&&&&&&&timeSp:%ld",(long)timeSp); //时间戳的值
    
    
    
    return timeSp;
    
}
//传入今天的时间，返回明天的时间
+ (NSString *)GetTomorrowDay:(NSDate *)aDate withFormat:(NSString *)format
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:aDate];
    [components setDay:([components day]+1)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:format];
    return [dateday stringFromDate:beginningOfWeek];
}
#pragma mark 根据当前日期计算星期几
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Beijing"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}
#pragma mark - 将某个时间转化成时间字符串
+(NSString *)timeMakeTimestamp:(NSDate *)date andFormatter:(NSString *)format{
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    
    
    //    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    
    //转字符串
    NSString *timeStr = [formatter stringFromDate:date];
    
    
    //时间转时间戳的方法:
    //    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    //
    //
    //    NSLog(@"将某个时间转化成 时间戳&&&&&&&timeSp:%ld",(long)timeSp); //时间戳的值
    
    return timeStr;
    
}
#pragma mark比较两个日期的大小  日期格式为2016-08-14
+ (NSInteger)compareStringDate:(NSString*)aDate withDate:(NSString*)bDate
{
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd"];
    NSDate *dta = [[NSDate alloc] init];
    NSDate *dtb = [[NSDate alloc] init];
    
    dta = [dateformater dateFromString:aDate];
    dtb = [dateformater dateFromString:bDate];
    NSComparisonResult result = [dta compare:dtb];

    if (result == NSOrderedDescending) {
        NSLog(@"oneDay比 anotherDay时间晚");
        return 1;
    }
    else if (result == NSOrderedAscending){
        NSLog(@"oneDay比 anotherDay时间早");
        return -1;
    }
    NSLog(@"两者时间是同一个时间");
    return 0;
  
}

#pragma mark比较两个日期的大小
+ (NSInteger)compareDate:(NSDate*)aDate withDate:(NSDate*)bDate
{
    NSInteger aa;
//    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
//    [dateformater setDateFormat:@"yyyy-MM-dd"];
//    NSDate *dta = [[NSDate alloc] init];
//    NSDate *dtb = [[NSDate alloc] init];
//
//    dta = [dateformater dateFromString:aDate];
//    dtb = [dateformater dateFromString:bDate];
    NSComparisonResult result = [aDate compare:bDate];
    if (result == NSOrderedDescending) {
        NSLog(@"oneDay比 anotherDay时间晚");
        return 1;
    }
    else if (result == NSOrderedAscending){
        NSLog(@"oneDay比 anotherDay时间早");
        return -1;
    }
    NSLog(@"两者时间是同一个时间");
    return 0;
    
    return aa;
}

#pragma mark 计算时间差
+(int)getTimebySubtracting:(NSDate*)Date1 andDate2:(NSDate*)Date2{
    
    //日期减
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    //    unsigned int unitFlags = NSHourCalendarUnit;//年、月、日、时、分、秒、周等等都可以
    
    unsigned int unitFlags = NSCalendarUnitDay;// 日 等等都可以
    
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:Date1 toDate:Date2 options:0];
    
//    int minute = (int)[comps minute];//时间差
    
    int days = (int)[comps day];//时间差(太精确了)
    
    
    NSLog(@"----days----%d",days);
    return days;
    
}


@end
