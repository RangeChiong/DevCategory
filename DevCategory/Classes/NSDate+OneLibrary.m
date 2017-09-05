//
//  NSDate+OneLibrary.m
//  RPAntus
//
//  Created by Crz on 15/12/21.
//  Copyright © 2015年 Ranger. All rights reserved.
//

#import "NSDate+OneLibrary.h"

@implementation NSDate (OneLibrary)

#pragma mark-   返回格式化后的日期字符串

+ (NSString *)ol_stringFromTimeInterval:(NSTimeInterval)interval {
    //  处理时间
    NSDate *receivedDate = [NSDate dateWithTimeIntervalSince1970:interval];
    return [self ol_stringFromDate:receivedDate];
}

+ (NSString *)ol_stringFromTimeInterval:(NSTimeInterval)interval
                             withFormat:(NSString *)format {
    //  处理时间
    NSDate *receivedDate = [NSDate dateWithTimeIntervalSince1970:interval];
    return [self ol_stringFromDate:receivedDate withFormat:format];
}

+ (NSString *)ol_stringFromNow {

    return [self ol_stringFromNowWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSString *)ol_stringFromNowWithFormat:(NSString *)format {

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];

    return [dateFormatter stringFromDate:[NSDate date]];
}

+ (NSString *)ol_stringFromDate:(NSDate *)date {

    return [self ol_stringFromDate:date withFormat:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSString *)ol_stringFromDate:(NSDate *)date withFormat:(NSString *)format {

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];

    return [dateFormatter stringFromDate:date];
}

+ (NSString *)ol_stringOfTimeIntervalSince1970 {
    return [NSString stringWithFormat:@"%.lf", [self ol_timeIntervalSince1970]];
}

#pragma mark-   返回格式化后的日期字符串

+ (NSDate *)ol_dateFromString:(NSString *)string {

    return [self ol_dateFromString:string withFormat:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSDate *)ol_dateFromString:(NSString *)string withFormat:(NSString *)format {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    NSDate *date = [inputFormatter dateFromString:string];
    return date;
}

+ (NSTimeInterval)ol_timeIntervalSince1970 {

    return [[NSDate date] timeIntervalSince1970];
}

- (NSString *)ol_toString:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.timeZone      = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    dateFormatter.dateFormat    = format;
    
    return [dateFormatter stringFromDate:self];
}

- (NSString *)ol_toYearMonthStringSinceNow {
    NSDate *now     = [NSDate date];
    NSCalendar *cal = [NSDate currentCalendar];
    
    NSDateComponents *comBefore = [cal components:NSCalendarUnitMonth|NSCalendarUnitYear fromDate:self];
    NSDateComponents *comNow    = [cal components:NSCalendarUnitMonth|NSCalendarUnitYear fromDate:now];
    NSInteger monthAll          = (comNow.year-comBefore.year)*12 + (comNow.month-comBefore.month);
    
    NSInteger year        = monthAll/12;
    NSInteger month      = monthAll%12;
    
    NSString *retString;
    
    if (year > 0) {
        retString = [NSString stringWithFormat:@"%ld年", (long)year];
    }
    if (month > 0) {
        if (retString) {
            retString = [NSString stringWithFormat:@"%@%ld月", retString, (long)month];
        } else {
            retString = [NSString stringWithFormat:@"%ld月", (long)month];
        }
    }
    
    return retString;
}

- (BOOL)ol_isSameDayWith:(NSDate *)date {
    double timezoneFix = [NSTimeZone localTimeZone].secondsFromGMT;
    return (int)(([self timeIntervalSince1970] + timezoneFix)/(24*3600)) -
    (int)(([date timeIntervalSince1970] + timezoneFix)/(24*3600))
    == 0;
}

//
+ (NSDate *)ol_dateFromString:(NSString *)dateString formmat:(NSString *)format {
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    
    formatter.timeZone      = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];;
    formatter.dateFormat    = format;
    
    return [formatter dateFromString:dateString];
}

+ (NSDate *)ol_beforeYear:(NSInteger)year month:(NSInteger)month {
    //计算生日
    NSDate *now     = [NSDate date];
    NSDateComponents *com = [[self currentCalendar] components:NSCalendarUnitMonth fromDate:now];
    
    com.month   = -(year*12+month);
    
    return [[self currentCalendar] dateByAddingComponents:com toDate:now options:NSCalendarMatchFirst];
}

+ (NSDate *)ol_beforeYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    NSDate *now     = [NSDate date];
    NSDateComponents *com = [[self currentCalendar] components:NSCalendarUnitMonth | NSCalendarUnitDay fromDate:now];
    
    com.month   = -(year*12+month);
    com.day     = day;
    
    return [[self currentCalendar] dateByAddingComponents:com toDate:now options:NSCalendarMatchFirst];
}

+ (NSDate *)ol_year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.timeZone      = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    dateFormatter.dateFormat    = @"yyyy-MM-dd HH:mm:ss";
    
    NSString *dateString = [[NSString alloc] initWithFormat:@"%zi-%2zi-%2zi 12:00:00", year, month, day];
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    return date;
}

+ (NSString *)ol_weekdayStringWithDate:(NSDate *)date {
    static NSDateFormatter *formatter1;
    static dispatch_once_t onceToken1;

    dispatch_once(&onceToken1, ^{
        formatter1 = [[NSDateFormatter alloc]init];
        [formatter1 setDateFormat:@"EEEE"];
        [formatter1 setWeekdaySymbols:@[@"周日",
                                              @"周一",
                                              @"周二",
                                              @"周三",
                                              @"周四",
                                              @"周五",
                                              @"周六"]];
    });
    return [formatter1 stringFromDate:date];
}

+ (NSString *)ol_fullWeekdayStringWithDate:(NSDate *)date {
    static NSDateFormatter *formatter2;
    static dispatch_once_t onceToken2;
    dispatch_once(&onceToken2, ^{
        formatter2 = [[NSDateFormatter alloc]init];
        [formatter2 setDateFormat:@"yyyy-MM-dd EEEE HH:mm"];
        [formatter2 setWeekdaySymbols:@[@"周日",
                                               @"周一",
                                               @"周二",
                                               @"周三",
                                               @"周四",
                                               @"周五",
                                               @"周六"]];
    });
    
    return [formatter2 stringFromDate:date];
}

+ (NSDate *)ol_dateFromFullWeekdayString:(NSString *)dateString {
    static NSDateFormatter *formatter3;
    static dispatch_once_t onceToken3;
    dispatch_once(&onceToken3, ^{
        formatter3 = [[NSDateFormatter alloc]init];
        formatter3.timeZone  = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        [formatter3 setDateFormat:@"yyyy-MM-dd EEEE HH:mm"];
        [formatter3 setWeekdaySymbols:@[@"周日",
                                               @"周一",
                                               @"周二",
                                               @"周三",
                                               @"周四",
                                               @"周五",
                                               @"周六"]];
    });
    return [formatter3 dateFromString:dateString];
}

+ (NSDate *)ol_dateFromComponent:(NSDateComponents *)components {
    return [[self currentCalendar] dateFromComponents:components];
}

+ (NSString *)ol_dateStringFromComponent:(NSDateComponents *)components {
    NSDate *date =[self ol_dateFromComponent:components];
    return [self ol_fullWeekdayStringWithDate:date];
}

+ (NSCalendar *)currentCalendar {
    static NSCalendar *calendar;
    static dispatch_once_t onceToken4;
    dispatch_once(&onceToken4, ^{
        calendar            = [NSCalendar currentCalendar];
        calendar.timeZone   = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    });
    
    return calendar;
}


@end


@implementation NSDateComponents (OLSDateFormmat)

+ (NSDateComponents *)ol_fullComponentFromDate:(NSDate *)date {
    NSCalendar *calendar =[NSCalendar currentCalendar];
    return [calendar components:NSCalendarUnitYear |
            NSCalendarUnitMonth |
            NSCalendarUnitDay |
            NSCalendarUnitHour |
            NSCalendarUnitMinute
                       fromDate:date];
}

@end
