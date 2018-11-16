//
//  NSDate+XBCategory.m
//  XBCodingRepo
//
//  Created by Xinbo Hong on 2018/4/28.
//  Copyright © 2018年 Xinbo Hong. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

/**
 * 根据日期返回字符串
 */
+ (NSString *)stringWithFormat:(NSString *)format InDate:(NSDate *)inDate {
    return [inDate stringWithFormat:format];
}

- (NSString *)stringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *string = [formatter stringFromDate:self];
    
    return string;
}

+ (NSDate *)dateWithString:(NSString *)string format:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    
    return [formatter dateFromString:string];
}

/**
 获取阴历
 */
- (NSString*)lunar {
    NSArray *chineseYears = [NSArray arrayWithObjects:@"甲子", @"乙丑", @"丙寅", @"丁卯", @"戊辰", @"己巳", @"庚午", @"辛未", @"壬申", @"癸酉",@"甲戌", @"乙亥", @"丙子", @"丁丑", @"戊寅", @"己卯", @"庚辰", @"辛己", @"壬午", @"癸未",@"甲申", @"乙酉", @"丙戌", @"丁亥", @"戊子", @"己丑", @"庚寅", @"辛卯", @"壬辰", @"癸巳",@"甲午", @"乙未", @"丙申", @"丁酉", @"戊戌", @"己亥", @"庚子", @"辛丑", @"壬寅", @"癸丑",@"甲辰", @"乙巳", @"丙午", @"丁未", @"戊申", @"己酉", @"庚戌", @"辛亥", @"壬子", @"癸丑",@"甲寅", @"乙卯", @"丙辰", @"丁巳", @"戊午", @"己未", @"庚申", @"辛酉", @"壬戌", @"癸亥", nil];
    NSArray *chineseMonths = [NSArray arrayWithObjects:@"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",@"九月", @"十月", @"冬月", @"腊月", nil];
    NSArray *chineseDays = [NSArray arrayWithObjects:@"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",@"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",@"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *localeComp = [calendar components:unitFlags fromDate:self];
    NSString *yearString = chineseYears[localeComp.year];
    NSString *monthString = chineseMonths[localeComp.month];
    NSString *dayString = chineseDays[localeComp.day];
    
    NSString *lunarString = [NSString stringWithFormat:@"%@年%@%@", yearString, monthString, dayString];
    return lunarString;
    
}

#pragma mark - --- 时间戳 ---
/**
 * 时间戳：将当前时间转换为时间戳
 */
+ (NSString *)stringWithNowTimeStamp {
    NSDate *date = [NSDate date];
    return [NSString stringWithFormat:@"%ld",(NSInteger)[date timeIntervalSince1970]];
}

/**
 * 时间戳：根据传入时间字符串转换为时间戳
 */
+ (NSString *)timeStampWithTimeString:(NSString *)timeString {
    if (timeString.length > 0) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *versionData = [formatter dateFromString:timeString];
        return [NSString stringWithFormat:@"%ld",(NSInteger)[versionData timeIntervalSince1970]];
    } else {
        return @"";
    }
}

/**
 * 时间戳：根据传入时间戳字符串转换为时间字符串（格式：yyyy-MM-dd HH:mm:ss）
 */
+ (NSString *)timeStringWithTimeStmap:(NSString *)timeStamp {
    if (timeStamp.length > 0) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp.integerValue];
        return [formatter stringFromDate:date];
    } else {
        return @"";
    }
}


#pragma mark - --- 根据X（年/月/日/时/分/秒）后的日期,若X为负数,则为|X|天前的日期 ---

- (NSDate *)offsetYears:(int)numYears {
    return [NSDate offsetYears:numYears fromDate:self];
}

+ (NSDate *)offsetYears:(int)numYears fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:numYears];
    
    return [gregorian dateByAddingComponents:components toDate:fromDate options:0];
}


- (NSDate *)offsetMonths:(int)numMonths {
    return [NSDate offsetMonths:numMonths fromDate:self];
}
+ (NSDate *)offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:numMonths];
    
    return [gregorian dateByAddingComponents:components toDate:fromDate options:0];
}


- (NSDate *)offsetDays:(int)numDays {
    return [NSDate offsetDays:numDays fromDate:self];
}
+ (NSDate *)offsetDays:(int)numDays fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:numDays];
    
    return [gregorian dateByAddingComponents:components
                                      toDate:fromDate
                                     options:0];
}


- (NSDate *)offsetHours:(int)hours {
    return [NSDate offsetHours:hours fromDate:self];
}
+ (NSDate *)offsetHours:(int)numHours fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setHour:numHours];
    return [gregorian dateByAddingComponents:components toDate:fromDate options:0];
}

- (NSDate *)offsetMinute:(int)minute {
    return [NSDate offsetHours:minute fromDate:self];
}
+ (NSDate *)offsetMinute:(int)numMinute fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setHour:numMinute];
    return [gregorian dateByAddingComponents:components toDate:fromDate options:0];
}


- (NSDate *)offsetSecond:(int)second {
    return [NSDate offsetHours:second fromDate:self];
}
+ (NSDate *)offsetSecond:(int)numSecond fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setHour:numSecond];
    return [gregorian dateByAddingComponents:components toDate:fromDate options:0];
}

#pragma mark - --- 根据当前月的第一天和最后一天 ---
- (NSDate *)beginDayOfMonth {
    return [NSDate begindayOfMonth:self];
}
+ (NSDate *)beginDayOfMonth:(NSDate *)date {
    return [self offsetDays:((int)date.day * -1 + 1) fromDate:date];
}


- (NSDate *)lastDayOfMonth {
    return [NSDate lastDayOfMonth:self];
}
+ (NSDate *)lastDayOfMonth:(NSDate *)date {
    NSDate *lastDate = [self beginDayOfMonth:date];
    return [[lastDate offsetMonths:1] offsetDays:-1];
}


#pragma mark - --- 获取年月日，时分秒---
- (NSUInteger)day {
    return [NSDate day:self];
}

- (NSUInteger)month {
    return [NSDate month:self];
}

- (NSUInteger)year {
    return [NSDate year:self];
}

- (NSUInteger)hour {
    return [NSDate hour:self];
}

- (NSUInteger)minute {
    return [NSDate minute:self];
}

- (NSUInteger)second {
    return [NSDate second:self];
}

+ (NSUInteger)day:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay) fromDate:date];
    return [components day];
}

+ (NSUInteger)month:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitMonth) fromDate:date];
    return [components month];
}

+ (NSUInteger)year:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear) fromDate:date];
    return [components year];
}

+ (NSUInteger)hour:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour) fromDate:date];
    return [components hour];
}

+ (NSUInteger)minute:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitMinute) fromDate:date];
    return [components minute];
}

+ (NSUInteger)second:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitSecond) fromDate:date];
    return [components second];
}


@end
