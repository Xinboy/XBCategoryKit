//
//  NSDate+XBCategory.h
//  XBCodingRepo
//
//  Created by Xinbo Hong on 2018/4/28.
//  Copyright © 2018年 Xinbo Hong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSDate (Extension)

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

#pragma mark - --- 根据X（年/月/日/时/分/秒）后的日期,若X为负数,则为|X|天前的日期 ---
/**
 * 返回numYears年后的日期
 */
- (NSDate *)offsetYears:(int)numYears;
+ (NSDate *)offsetYears:(int)numYears fromDate:(NSDate *)fromDate;

/**
 * 返回numMonths月后的日期
 */
- (NSDate *)offsetMonths:(int)numMonths;
+ (NSDate *)offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate;

/**
 * 返回numDays天后的日期
 */
- (NSDate *)offsetDays:(int)numDays;
+ (NSDate *)offsetDays:(int)numDays fromDate:(NSDate *)fromDate;

/**
 * 返回numHours小时后的日期
 */
- (NSDate *)offsetHours:(int)hours;
+ (NSDate *)offsetHours:(int)numHours fromDate:(NSDate *)fromDate;

/**
 * 返回numMintue分钟后的日期
 */
- (NSDate *)offsetMintue:(int)mintue;
+ (NSDate *)offsetMintue:(int)numMintue fromDate:(NSDate *)fromDate;

/**
 * 返回numSecond秒后的日期
 */
- (NSDate *)offsetSecond:(int)second;
+ (NSDate *)offsetSecond:(int)numSecond fromDate:(NSDate *)fromDate;
#pragma mark - --- 根据当前月的第一天和最后一天 ---
/**
 * 获取该月的第一天的日期
 */
- (NSDate *)beginDayOfMonth;
+ (NSDate *)begindayOfMonth:(NSDate *)date;

/**
 * 获取该月的最后一天的日期
 */
- (NSDate *)lastDayOfMonth;
+ (NSDate *)lastDayOfMonth:(NSDate *)date;


#pragma mark - --- 获取年月日，时分秒---
/**
 * 获取日、月、年、小时、分钟、秒
 */
- (NSUInteger)day;
- (NSUInteger)month;
- (NSUInteger)year;
- (NSUInteger)hour;
- (NSUInteger)minute;
- (NSUInteger)second;
+ (NSUInteger)day:(NSDate *)date;
+ (NSUInteger)month:(NSDate *)date;
+ (NSUInteger)year:(NSDate *)date;
+ (NSUInteger)hour:(NSDate *)date;
+ (NSUInteger)minute:(NSDate *)date;
+ (NSUInteger)second:(NSDate *)date;

@end
