//
//  NSDate+OneLibrary.h
//  RPAntus
//
//  Created by Crz on 15/12/21.
//  Copyright © 2015年 Ranger. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (OneLibrary)

#pragma mark-   返回string

/** NSTimeInterval 转成string 默认 yyyy-MM-dd HH:mm:ss */
+ (NSString *)zy_stringFromTimeInterval:(NSTimeInterval)interval;

/** NSTimeInterval 转成string 按照format格式 */
+ (NSString *)zy_stringFromTimeInterval:(NSTimeInterval)interval
                          withFormat:(NSString *)format;

/** 获取当前时间 默认 yyyy-MM-dd HH:mm:ss */
+ (NSString *)zy_stringFromNow;

/** 获取当前时间 按照format格式 */
+ (NSString *)zy_stringFromNowWithFormat:(NSString *)format;

/** date转成string 默认格式 yyyy-MM-dd HH:mm:ss */
+ (NSString *)zy_stringFromDate:(NSDate *)date;

/** date转成string 依照 format格式 */
+ (NSString *)zy_stringFromDate:(NSDate *)date withFormat:(NSString *)format;

/** 1970年到现在的秒数 */
+ (NSString *)zy_stringOfTimeIntervalSince1970;

#pragma mark- 返回date

/** string转成date 默认格式 yyyy-MM-dd HH:mm:ss */
+ (NSDate *)zy_dateFromString:(NSString *)string;

/** string转成date 依照format格式 */
+ (NSDate *)zy_dateFromString:(NSString *)string withFormat:(NSString *)format;

#pragma mark-  返回 NSTimeInterval

/** 1970年到现在的秒数 */
+ (NSTimeInterval)zy_timeIntervalSince1970;

- (NSString *)zy_toString:(NSString *)format;
- (NSString *)zy_toYearMonthStringSinceNow;
- (BOOL)zy_isSameDayWith:(NSDate *)date;

+ (NSDate *)zy_dateFromString:(NSString *)dateString formmat:(NSString *)format;
+ (NSString *)zy_weekdayStringWithDate:(NSDate *)date;
+ (NSDate *)zy_beforeYear:(NSInteger)year month:(NSInteger)month;
+ (NSDate *)zy_beforeYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
+ (NSDate *)zy_year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

+ (NSString *)zy_fullWeekdayStringWithDate:(NSDate *)date;

+ (NSDate *)zy_dateFromComponent:(NSDateComponents *)components;
+ (NSDate *)zy_dateFromFullWeekdayString:(NSString *)dateString;

+ (NSString *)zy_dateStringFromComponent:(NSDateComponents *)components;

@end


@interface NSDateComponents (OLDateFormmat)

+ (NSDateComponents *)zy_fullComponentFromDate:(NSDate *)date;

@end


NS_ASSUME_NONNULL_END
