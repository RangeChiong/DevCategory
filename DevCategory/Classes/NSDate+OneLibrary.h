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
+ (NSString *)ol_stringFromTimeInterval:(NSTimeInterval)interval;

/** NSTimeInterval 转成string 按照format格式 */
+ (NSString *)ol_stringFromTimeInterval:(NSTimeInterval)interval
                          withFormat:(NSString *)format;

/** 获取当前时间 默认 yyyy-MM-dd HH:mm:ss */
+ (NSString *)ol_stringFromNow;

/** 获取当前时间 按照format格式 */
+ (NSString *)ol_stringFromNowWithFormat:(NSString *)format;

/** date转成string 默认格式 yyyy-MM-dd HH:mm:ss */
+ (NSString *)ol_stringFromDate:(NSDate *)date;

/** date转成string 依照 format格式 */
+ (NSString *)ol_stringFromDate:(NSDate *)date withFormat:(NSString *)format;

/** 1970年到现在的秒数 */
+ (NSString *)ol_stringOfTimeIntervalSince1970;

#pragma mark- 返回date

/** string转成date 默认格式 yyyy-MM-dd HH:mm:ss */
+ (NSDate *)ol_dateFromString:(NSString *)string;

/** string转成date 依照format格式 */
+ (NSDate *)ol_dateFromString:(NSString *)string withFormat:(NSString *)format;

#pragma mark-  返回 NSTimeInterval

/** 1970年到现在的秒数 */
+ (NSTimeInterval)ol_timeIntervalSince1970;

- (NSString *)ol_toString:(NSString *)format;
- (NSString *)ol_toYearMonthStringSinceNow;
- (BOOL)ol_isSameDayWith:(NSDate *)date;

+ (NSDate *)ol_dateFromString:(NSString *)dateString formmat:(NSString *)format;
+ (NSString *)ol_weekdayStringWithDate:(NSDate *)date;
+ (NSDate *)ol_beforeYear:(NSInteger)year month:(NSInteger)month;
+ (NSDate *)ol_beforeYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
+ (NSDate *)ol_year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

+ (NSString *)ol_fullWeekdayStringWithDate:(NSDate *)date;

+ (NSDate *)ol_dateFromComponent:(NSDateComponents *)components;
+ (NSDate *)ol_dateFromFullWeekdayString:(NSString *)dateString;

+ (NSString *)ol_dateStringFromComponent:(NSDateComponents *)components;

@end


@interface NSDateComponents (OLDateFormmat)

+ (NSDateComponents *)ol_fullComponentFromDate:(NSDate *)date;

@end


NS_ASSUME_NONNULL_END
