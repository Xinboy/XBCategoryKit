//
//  NSDate+XBCategory.m
//  XBCodingRepo
//
//  Created by Xinbo Hong on 2018/4/28.
//  Copyright © 2018年 Xinbo Hong. All rights reserved.
//

#import "NSDate+XB_Extension.h"

typedef NS_ENUM(NSInteger, AdjustingCalendar) {
    AdjustingCalendarYear = 0,
    AdjustingCalendarMonth,
    AdjustingCalendarDay,
    AdjustingCalendarHour,
    AdjustingCalendarMinute,
    AdjustingCalendarSecond,
};

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

+ (NSDate *)dateWithString:(NSString *)string Format:(NSString *)format {
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

- (NSDate *)dateFromUnixTimestamp:(NSTimeInterval)timestamp {
    return[NSDate dateWithTimeIntervalSince1970:timestamp];
}

#pragma mark - --- 给定日期/当前日期的X（年/月/日/时/分/秒）前后日期 ---
+ (NSDate *)dateWithTomorrow {
    return [NSDate dateWithDaysAfterNow:1];
}

+ (NSDate *)dateWithYesterday {
    return [NSDate dateWithDaysBeforeNow:1];
}
//-----
+ (NSDate *)dateWithYearsAfterNow:(NSInteger)dYears {
    return [NSDate dateByAddingTime:dYears FromDate:[NSDate date] AdjustingType:AdjustingCalendarYear];
}

+ (NSDate *)dateWithYears:(NSInteger)dYears AfterDate:(NSDate *)afterDate {
    return [NSDate dateByAddingTime:dYears FromDate:afterDate AdjustingType:AdjustingCalendarYear];
}

+ (NSDate *)dateWithYearsBefoerNow:(NSInteger)dYears {
    return [NSDate dateBySubtractingTime:dYears FromDate:[NSDate date] AdjustingType:AdjustingCalendarYear];
}

+ (NSDate *)dateWithYears:(NSInteger)dYears BefoerDate:(NSDate *)beforeDate {
    return [NSDate dateBySubtractingTime:dYears FromDate:beforeDate AdjustingType:AdjustingCalendarYear];
}
//-----
+ (NSDate *)dateWithMonthsAfterNow:(NSInteger)dMonths {
    return [NSDate dateByAddingTime:dMonths FromDate:[NSDate date] AdjustingType:AdjustingCalendarMonth];
}

+ (NSDate *)dateWithMonths:(NSInteger)dMonths AfterDate:(NSDate *)afterDate {
    return [NSDate dateByAddingTime:dMonths FromDate:afterDate AdjustingType:AdjustingCalendarMonth];
}

+ (NSDate *)dateWithMonthsBeforeNow:(NSInteger)dMonths {
    return [NSDate dateBySubtractingTime:dMonths FromDate:[NSDate date] AdjustingType:AdjustingCalendarMonth];
}

+ (NSDate *)dateWithMonths:(NSInteger)dMonths BeforeDate:(NSDate *)beforeDate {
    return [NSDate dateBySubtractingTime:dMonths FromDate:beforeDate AdjustingType:AdjustingCalendarMonth];
}
//-----
+ (NSDate *)dateWithDaysAfterNow:(NSInteger)dDays {
    return [NSDate dateByAddingTime:dDays FromDate:[NSDate date] AdjustingType:AdjustingCalendarDay];
}

+ (NSDate *)dateWithDays:(NSInteger)dDays AfterDate:(NSDate *)afterDate {
    return [NSDate dateByAddingTime:dDays FromDate:afterDate AdjustingType:AdjustingCalendarDay];
}

+ (NSDate *)dateWithDaysBeforeNow:(NSInteger)dDays {
    return [NSDate dateBySubtractingTime:dDays FromDate:[NSDate date] AdjustingType:AdjustingCalendarDay];
}

+ (NSDate *)dateWithDays:(NSInteger)dDays BeforeDate:(NSDate *)beforeDate {
    return [NSDate dateBySubtractingTime:dDays FromDate:beforeDate AdjustingType:AdjustingCalendarDay];
}
//-----
+ (NSDate *)dateWithHoursAfterNow:(NSInteger)dHours {
    return [NSDate dateByAddingTime:dHours FromDate:[NSDate date] AdjustingType:AdjustingCalendarHour];
}

+ (NSDate *)dateWithHours:(NSInteger)dHours AfterDate:(NSDate *)afterDate {
    return [NSDate dateByAddingTime:dHours FromDate:afterDate AdjustingType:AdjustingCalendarHour];
}

+ (NSDate *)dateWithHoursBeforeNow:(NSInteger)dHours {
    return [NSDate dateBySubtractingTime:dHours FromDate:[NSDate date] AdjustingType:AdjustingCalendarHour];
}

+ (NSDate *)dateWithHours:(NSInteger)dHours BeforeDate:(NSDate *)beforeDate {
    return [NSDate dateBySubtractingTime:dHours FromDate:beforeDate AdjustingType:AdjustingCalendarHour];
}
//-----
+ (NSDate *)dateWithMintuesAfterNow:(NSInteger)dMintues {
    return [NSDate dateByAddingTime:dMintues FromDate:[NSDate date] AdjustingType:AdjustingCalendarMinute];
}

+ (NSDate *)dateWithMintues:(NSInteger)dMintues AfterDate:(NSDate *)afterDate {
    return [NSDate dateByAddingTime:dMintues FromDate:afterDate AdjustingType:AdjustingCalendarMinute];
}

+ (NSDate *)dateWithMintuesBeforeNow:(NSInteger)dMintues {
    return [NSDate dateBySubtractingTime:dMintues FromDate:[NSDate date] AdjustingType:AdjustingCalendarMinute];
}

+ (NSDate *)dateWithMintues:(NSInteger)dMintues BeforeDate:(NSDate *)beforeDate {
    return [NSDate dateBySubtractingTime:dMintues FromDate:beforeDate AdjustingType:AdjustingCalendarMinute];
}
//-----
+ (NSDate *)dateWithSecondsAfterNow:(NSInteger)dSeconds {
    return [NSDate dateByAddingTime:dSeconds FromDate:[NSDate date] AdjustingType:AdjustingCalendarSecond];
}

+ (NSDate *)dateWithSeconds:(NSInteger)dSeconds AfterDate:(NSDate *)afterDate {
    return [NSDate dateByAddingTime:dSeconds FromDate:afterDate AdjustingType:AdjustingCalendarSecond];
}

+ (NSDate *)dateWithSecondsBeforeNow:(NSInteger)dSeconds {
    return [NSDate dateBySubtractingTime:dSeconds FromDate:[NSDate date] AdjustingType:AdjustingCalendarSecond];
}

+ (NSDate *)dateWithSeconds:(int)dSeconds BeforeDate:(NSDate *)beforeDate {
    return [NSDate dateBySubtractingTime:dSeconds FromDate:beforeDate AdjustingType:AdjustingCalendarSecond];
}


+ (NSDate *)dateByAddingTime:(NSInteger)time FromDate:(NSDate *)fromdate AdjustingType:(AdjustingCalendar)type {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    switch (type) {
        case AdjustingCalendarYear:
            components.year = time;
            break;
        case AdjustingCalendarMonth:
            components.month = time;
            break;
        case AdjustingCalendarDay:
            components.day = time;
            break;
        case AdjustingCalendarHour:
            components.hour = time;
            break;
        case AdjustingCalendarMinute:
            components.minute = time;
            break;
        case AdjustingCalendarSecond:
            components.second = time;
            break;
    }
    return [calender dateByAddingComponents:components toDate:fromdate options:0];
}

+ (NSDate *)dateBySubtractingTime:(NSInteger)time FromDate:(NSDate *)fromdate AdjustingType:(AdjustingCalendar)type {
    return [NSDate dateByAddingTime:-time FromDate:fromdate AdjustingType:type];
}
#pragma mark - --- 根据当前月的第一天和最后一天 ---
- (NSDate *)beginDayOfMonth {
    return [NSDate beginDayOfMonth:self];
}
+ (NSDate *)beginDayOfMonth:(NSDate *)date {
    return [self dateWithDays:date.day * -1 + 1 BeforeDate:date];
}


- (NSDate *)lastDayOfMonth {
    return [NSDate lastDayOfMonth:self];
}

//!!!!!!!
+ (NSDate *)lastDayOfMonth:(NSDate *)date {
    NSDate *lastDate = [self beginDayOfMonth:date];
    return [self dateWithDays:date.day * -1 + 1 AfterDate:lastDate];
}

#pragma mark - --- 比较日期 ---
- (BOOL)isEqualToDateIgnoringTime:(NSDate *)otherDate {
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSCalendarUnit unitFlags = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *components1 = [currentCalendar components:unitFlags fromDate:self];
    NSDateComponents *components2 = [currentCalendar components:unitFlags fromDate:otherDate];
    
    return (components1.era == components2.era) &&
            (components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day);
}


- (BOOL)isToday {
    return [self isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL)isTomorrow {
    return [self isEqualToDateIgnoringTime:[NSDate dateWithTomorrow]];
}

- (BOOL)isYesterday {
    return [self isEqualToDateIgnoringTime:[NSDate dateWithYesterday]];
}

- (BOOL)isSameWeekAsDate:(NSDate *)aDate {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *selfComponents = [calendar components:NSCalendarUnitWeekOfYear | NSCalendarUnitYearForWeekOfYear fromDate:self];
    NSDateComponents *aDateComponents = [calendar components:NSCalendarUnitWeekOfYear | NSCalendarUnitYearForWeekOfYear fromDate:aDate];
    
    return selfComponents.weekOfYear == aDateComponents.weekOfYear
    && selfComponents.yearForWeekOfYear == aDateComponents.yearForWeekOfYear;
}

- (BOOL)isThisWeek {
    return [self isSameWeekAsDate:[NSDate date]];
}

- (BOOL)isNextWeek {
    NSDate *nextWeek = [NSDate dateWithDaysAfterNow:self.weekday];
    return [self isSameWeekAsDate:nextWeek];
}

- (BOOL)isLastWeek {
    NSDate *lastWeek = [NSDate dateWithDaysBeforeNow:self.weekday];
    return [self isSameMonthAsDate:lastWeek];
}


- (BOOL)isSameMonthAsDate:(NSDate *)aDate {
    NSDate *startDate = [[self dateAtStartOfMonth] dateAtStartOfDay];
    NSDate *currentDate = [[aDate dateAtStartOfMonth] dateAtStartOfDay];
    return [startDate isEqualToDate:currentDate];
}


- (BOOL)isThisMonth {
    return [self isSameMonthAsDate:[NSDate date]];
}


- (BOOL)isNextMonth {
    NSDate *nextMonth = [NSDate dateByAddingTime:1 FromDate:[NSDate date] AdjustingType:AdjustingCalendarMonth];
    return [self isSameMonthAsDate:nextMonth];
}

- (BOOL)isLastMonth {
    NSDate *lastMonth = [NSDate dateBySubtractingTime:1 FromDate:[NSDate date] AdjustingType:AdjustingCalendarMonth];
    return [self isSameMonthAsDate:lastMonth];
}

- (BOOL)isSameYearAsDate:(NSDate *)aDate {
    NSDate *startDate = [[self dateAtStartOfYear] dateAtStartOfDay];
    NSDate *currentDate = [[aDate dateAtStartOfYear] dateAtStartOfDay];
    return [startDate isEqualToDate:currentDate];
}


- (BOOL)isThisYear {
    return [self isSameYearAsDate:[NSDate date]];
}


- (BOOL)isNextYear {
    NSDate *nextYear = [NSDate dateByAddingTime:1 FromDate:[NSDate date] AdjustingType:AdjustingCalendarYear];
    return [self isSameYearAsDate:nextYear];
}

- (BOOL)isLastYear {
    NSDate *lastYear = [NSDate dateBySubtractingTime:1 FromDate:[NSDate date] AdjustingType:AdjustingCalendarYear];
    return [self isSameYearAsDate:lastYear];
}


- (BOOL)isEarlierThanDate:(NSDate *)aDate {
    return ([self compare:aDate] == NSOrderedAscending);
}


- (BOOL)isLaterThanDate:(NSDate *)aDate {
    return ([self compare:aDate] == NSOrderedDescending);
}


- (BOOL)isEarlierThanOrEqualDate:(NSDate *)aDate {
    NSComparisonResult result = [self compare:aDate];
    return (result == NSOrderedAscending) || (result == NSOrderedSame);
}


- (BOOL)isLaterThanOrEqualDate:(NSDate *)aDate {
    NSComparisonResult result = [self compare:aDate];
    return (result == NSOrderedDescending) || (result == NSOrderedSame);
}


- (BOOL)isInFuture {
    return [self isEarlierThanDate:[NSDate date]];
}


- (BOOL)isInPast {
    return [self isLaterThanDate:[NSDate date]];
}

#pragma mark - --- 比较日期，根据需要获得值（） ---
- (NSInteger)secondsAfterDate:(NSDate *)aDate {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitSecond fromDate:aDate toDate:self options:0];
    return [components second];
}

- (NSInteger)secondsBeforeDate:(NSDate *)aDate {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitSecond fromDate:self toDate:aDate options:0];
    return [components second];
}

- (NSInteger)minutesAfterDate:(NSDate *)aDate {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitMinute fromDate:aDate toDate:self options:0];
    return [components minute];
}

- (NSInteger)minutesBeforeDate:(NSDate *)aDate {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitMinute fromDate:self toDate:aDate options:0];
    return [components minute];
}

- (NSInteger)hoursAfterDate:(NSDate *)aDate {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitHour fromDate:aDate toDate:self options:0];
    return [components hour];
}

- (NSInteger)hoursBeforeDate:(NSDate *)aDate {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitHour fromDate:self toDate:aDate options:0];
    return [components hour];
}

- (NSInteger)daysAfterDate:(NSDate *)aDate {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitDay fromDate:aDate toDate:self options:0];
    return [components day];
}

- (NSInteger)daysBeforeDate:(NSDate *)aDate {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitDay fromDate:self toDate:aDate options:0];
    return [components day];
}

- (NSInteger)monthsAfterDate:(NSDate *)aDate {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth fromDate:aDate toDate:self options:0];
    return [components month];
}

- (NSInteger)monthsBeforeDate:(NSDate *)aDate {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth fromDate:self toDate:aDate options:0];
    return [components month];
}

- (NSInteger)yearsAfterDate:(NSDate *)aDate {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:aDate toDate:self options:0];
    return [components year];
}

- (NSInteger)yearsBeforeDate:(NSDate *)aDate {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:self toDate:aDate options:0];
    return [components year];
}


#pragma mark - --- 获取某天/月/年的开始或结束日期 ---
+ (NSCalendarUnit)unitsWithYMDHMS {
    return NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ;
}

- (NSDate *)dateAtStartOfDay {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:[NSDate unitsWithYMDHMS]  fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    components.timeZone = calendar.timeZone;
    
    return [calendar dateFromComponents:components];
}

- (NSDate *)dateAtStartOfNextDay {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:[NSDate unitsWithYMDHMS]  fromDate:self];
    components.day += 1;
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    components.timeZone = calendar.timeZone;
    
    return [calendar dateFromComponents:components];
}

- (NSDate *)dateAtEndOfDay NS_DEPRECATED(10_0, 10_12, 10_0, 11_0, "Use dateAtStartOfNextDay instead") {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:[NSDate unitsWithYMDHMS]  fromDate:self];
    components.hour = 23;
    components.minute = 59;
    components.second = 59;
    components.timeZone = calendar.timeZone;
    
    return [calendar dateFromComponents:components];
}

- (NSDate *)dateAtStartOfWeek {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDate *startWeek = nil;
    [calendar rangeOfUnit:NSCalendarUnitWeekOfMonth startDate:&startWeek interval:NULL forDate:self];
    
    return startWeek;
}

- (NSDate *)dateAtStartOfNextWeek {
    NSDate *startOfWeek = nil;
    NSTimeInterval interval = 0;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [calendar rangeOfUnit:NSCalendarUnitWeekOfMonth startDate:&startOfWeek interval:&interval forDate:self];
    
    return [startOfWeek dateByAddingTimeInterval:interval];
}

- (NSDate *)dateAtEndOfWeek NS_DEPRECATED(10_0, 10_12, 10_0, 11_0, "Use dateAtStartOfNextWeek instead") {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:[NSDate unitsWithYMDHMS] | NSCalendarUnitEra | NSCalendarUnitWeekday  fromDate:self];
    components.day += [NSDate weekday] -components.weekday;
    return [calendar dateFromComponents:components];
}

- (NSDate *)dateAtStartOfMonth {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:[NSDate unitsWithYMDHMS] | NSCalendarUnitEra  fromDate:self];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    components.day = range.location;
    return [calendar dateFromComponents:components];
    
}

- (NSDate *)dateAtStartOfNextMonth {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:[NSDate unitsWithYMDHMS] | NSCalendarUnitEra fromDate:self];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    components.month += 1;
    components.day = range.location;
    return [calendar dateFromComponents:components];
    
}

- (NSDate *)dateAtEndOfMonth NS_DEPRECATED(10_0, 10_12, 10_0, 11_0, "Use dateAtStartOfNextMonth instead") {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:[NSDate unitsWithYMDHMS] | NSCalendarUnitEra fromDate:self];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    components.day = range.length;
    return [calendar dateFromComponents:components];
    
}

- (NSDate *)dateAtStartOfYear {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:[NSDate unitsWithYMDHMS] | NSCalendarUnitEra fromDate:self];
    NSRange monthRange = [calendar rangeOfUnit:NSCalendarUnitMonth inUnit:NSCalendarUnitYear forDate:self];
    NSRange dayRange = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    components.month = monthRange.location;
    components.day = dayRange.location;
    
    return [calendar dateFromComponents:components];
}

- (NSDate *)dateAtStartOfNextYear {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:[NSDate unitsWithYMDHMS] | NSCalendarUnitEra fromDate:self];
    NSRange monthRange = [calendar rangeOfUnit:NSCalendarUnitMonth inUnit:NSCalendarUnitYear forDate:self];
    NSRange dayRange = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    components.year += 1;
    components.month = monthRange.location;
    components.day = dayRange.location;
    
    return [calendar dateFromComponents:components];
}

- (NSDate *)dateAtEndOfYear NS_DEPRECATED(10_0, 10_12, 10_0, 11_0, "Use dateAtStartOfNextYear instead") {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:[NSDate unitsWithYMDHMS] | NSCalendarUnitEra fromDate:self];
    NSRange monthRange = [calendar rangeOfUnit:NSCalendarUnitMonth inUnit:NSCalendarUnitYear forDate:self];
    components.month = monthRange.length;
    NSDate *endMonthOfYear = [calendar dateFromComponents:components];
    
    NSRange dayRange = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:endMonthOfYear];
    components.day = dayRange.length;
    NSDate *endOfYear = [calendar dateFromComponents:components];
    
    return endOfYear;
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

- (NSUInteger)weekday {
    return [NSDate weekday];
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

+ (NSUInteger)weekday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar maximumRangeOfUnit:NSCalendarUnitWeekday].length;
}

@end
