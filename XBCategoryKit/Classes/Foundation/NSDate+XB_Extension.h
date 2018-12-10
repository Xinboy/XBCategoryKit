//
//  NSDate+XBCategory.h
//  XBCodingRepo
//
//  Created by Xinbo Hong on 2018/4/28.
//  Copyright © 2018年 Xinbo Hong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSDate (XB_Extension)

/**
 * 根据日期返回字符串
 */
+ (NSString *)stringWithFormat:(NSString *)format InDate:(NSDate *)inDate;
- (NSString *)stringWithFormat:(NSString *)format;
+ (NSDate *)dateWithString:(NSString *)string format:(NSString *)format;

/**
 获取阴历
 */
- (NSString*)lunar;
#pragma mark - --- 时间戳 ---
/**
 * 时间戳：将当前时间转换为时间戳
 */
+ (NSString *)stringWithNowTimeStamp;

/**
 * 时间戳：根据传入时间字符串转换为时间戳
 */
+ (NSString *)timeStampWithTimeString:(NSString *)timeString;

/**
 * 时间戳：根据传入时间戳字符串转换为时间字符串（格式：yyyy-MM-dd HH:mm:ss）
 */
+ (NSString *)timeStringWithTimeStmap:(NSString *)timeStamp;

#pragma mark - --- 给定日期/当前日期的X（年/月/日/时/分/秒）前后日期 ---

+ (NSDate *)dateWithTomorrow;

+ (NSDate *)dateWithYesterday;

/**
 * 返回 给定日期/当前日期的dYears年后的日期
 */
+ (NSDate *)dateWithYearsAfterNow:(NSInteger)dYears;
+ (NSDate *)dateWithYears:(NSInteger)dYears AfterDate:(NSDate *)afterDate;

/**
 * 返回 给定日期/当前日期的dYears年前的日期
 */
+ (NSDate *)dateWithYearsBefoerNow:(NSInteger)dYears;
+ (NSDate *)dateWithYears:(NSInteger)dYears BefoerDate:(NSDate *)beforeDate;

/**
 * 返回 给定日期/当前日期的dMonths年后日期
 */
+ (NSDate *)dateWithMonthsAfterNow:(NSInteger)dMonths;
+ (NSDate *)dateWithMonths:(NSInteger)dMonths AfterDate:(NSDate *)afterDate;

/**
 * 返回 给定日期/当前日期的dMonths年前的日期
 */
+ (NSDate *)dateWithMonthsBeforeNow:(NSInteger)dMonths;
+ (NSDate *)dateWithMonths:(NSInteger)dMonths BeforeDate:(NSDate *)beforeDate;

/**
 * 返回 给定日期/当前日期的dDays年后日期
 */
+ (NSDate *)dateWithDaysAfterNow:(NSInteger)dDays;
+ (NSDate *)dateWithDays:(NSInteger)dDays AfterDate:(NSDate *)afterDate;

/**
 * 返回 给定日期/当前日期的dDays年前的日期
 */
+ (NSDate *)dateWithDaysBeforeNow:(NSInteger)dDays;
+ (NSDate *)dateWithDays:(NSInteger)dDays BeforeDate:(NSDate *)beforeDate;

/**
 * 返回 给定日期/当前日期的dHours年后日期
 */
+ (NSDate *)dateWithHoursAfterNow:(NSInteger)dHours;
+ (NSDate *)dateWithHours:(NSInteger)dHours AfterDate:(NSDate *)afterDate;

/**
 * 返回 给定日期/当前日期的dHours年前的日期
 */
+ (NSDate *)dateWithHoursBeforeNow:(NSInteger)dHours;
+ (NSDate *)dateWithHours:(NSInteger)dHours BeforeDate:(NSDate *)beforeDate;

/**
 * 返回 给定日期/当前日期的dMintues年后日期
 */
+ (NSDate *)dateWithMintuesAfterNow:(NSInteger)dMintues;
+ (NSDate *)dateWithMintues:(NSInteger)dMintues AfterDate:(NSDate *)afterDate;

/**
 * 返回 给定日期/当前日期的dMintues年前的日期
 */
+ (NSDate *)dateWithMintuesBeforeNow:(NSInteger)dMintues;
+ (NSDate *)dateWithMintues:(NSInteger)dMintues BeforeDate:(NSDate *)beforeDate;

/**
 * 返回 给定日期/当前日期的dSeconds年后日期
 */
+ (NSDate *)dateWithSecondsAfterNow:(NSInteger)dSeconds;
+ (NSDate *)dateWithSeconds:(NSInteger)dSeconds AfterDate:(NSDate *)afterDate;

/**
 * 返回 给定日期/当前日期的dSeconds年前的日期
 */
+ (NSDate *)dateWithSecondsBeforeNow:(NSInteger)dSeconds;
+ (NSDate *)dateWithSeconds:(int)dSeconds BeforeDate:(NSDate *)beforeDate;



#pragma mark - --- 比较日期，判断是否为某一特征 ---
- (BOOL)isEqualToDateIgnoringTime:(NSDate *)otherDate;

- (BOOL)isToday;

- (BOOL)isTomorrow;

- (BOOL)isYesterday;

- (BOOL)isSameWeekAsDate:(NSDate *)aDate;

- (BOOL)isThisWeek;

- (BOOL)isNextWeek;

- (BOOL)isLastWeek;

- (BOOL)isSameMonthAsDate:(NSDate *)aDate;

- (BOOL)isThisMonth;

- (BOOL)isNextMonth;

- (BOOL)isLastMonth;

- (BOOL)isSameYearAsDate:(NSDate *)aDate;

- (BOOL)isThisYear;

- (BOOL)isNextYear;

- (BOOL)isLastYear;

- (BOOL)isEarlierThanDate:(NSDate *)aDate;

- (BOOL)isLaterThanDate:(NSDate *)aDate;

- (BOOL)isEarlierThanOrEqualDate:(NSDate *)aDate;

- (BOOL)isLaterThanOrEqualDate:(NSDate *)aDate;

- (BOOL)isInFuture;

- (BOOL)isInPast;

#pragma mark - --- 比较日期，根据需要获得值（） ---
- (NSInteger)secondsAfterDate:(NSDate *)aDate;

- (NSInteger)secondsBeforeDate:(NSDate *)aDate;

- (NSInteger)minutesAfterDate:(NSDate *)aDate;

- (NSInteger)minutesBeforeDate:(NSDate *)aDate;

- (NSInteger)hoursAfterDate:(NSDate *)aDate;

- (NSInteger)hoursBeforeDate:(NSDate *)aDate;

- (NSInteger)daysAfterDate:(NSDate *)aDate;

- (NSInteger)daysBeforeDate:(NSDate *)aDate;

- (NSInteger)monthsAfterDate:(NSDate *)aDate;

- (NSInteger)monthsBeforeDate:(NSDate *)aDate;

- (NSInteger)yearsAfterDate:(NSDate *)aDate;

- (NSInteger)yearsBeforeDate:(NSDate *)aDate;
#pragma mark - --- 获取某天/月/年的开始或结束日期 ---

- (NSDate *)dateAtStartOfDay;

- (NSDate *)dateAtStartOfNextDay;

- (NSDate *)dateAtEndOfDay NS_DEPRECATED(10_0, 10_12, 10_0, 11_0, "Use dateAtStartOfNextDay instead");

- (NSDate *)dateAtStartOfWeek;

- (NSDate *)dateAtStartOfNextWeek;

- (NSDate *)dateAtEndOfWeek NS_DEPRECATED(10_0, 10_12, 10_0, 11_0, "Use dateAtStartOfNextWeek instead");

- (NSDate *)dateAtStartOfMonth;

- (NSDate *)dateAtStartOfNextMonth;

- (NSDate *)dateAtEndOfMonth NS_DEPRECATED(10_0, 10_12, 10_0, 11_0, "Use dateAtStartOfNextMonth instead");

- (NSDate *)dateAtStartOfYear;

- (NSDate *)dateAtStartOfNextYear;

- (NSDate *)dateAtEndOfYear NS_DEPRECATED(10_0, 10_12, 10_0, 11_0, "Use dateAtStartOfNextYear instead");

#pragma mark - --- 获取年月日，时分秒---
/**
 * 获取日、月、年、小时、分钟、秒、周的长度
 */
- (NSUInteger)day;
- (NSUInteger)month;
- (NSUInteger)year;
- (NSUInteger)hour;
- (NSUInteger)minute;
- (NSUInteger)second;
- (NSUInteger)weekday;
+ (NSUInteger)day:(NSDate *)date;
+ (NSUInteger)month:(NSDate *)date;
+ (NSUInteger)year:(NSDate *)date;
+ (NSUInteger)hour:(NSDate *)date;
+ (NSUInteger)minute:(NSDate *)date;
+ (NSUInteger)second:(NSDate *)date;
+ (NSUInteger)weekday;


@end
