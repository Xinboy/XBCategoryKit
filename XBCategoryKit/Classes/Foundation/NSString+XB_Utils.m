//
//  NSString+Attributed.m
//  XBKit
//
//  Created by Xinbo Hong on 2018/5/29.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

#import "NSString+XB_Utils.h"
#include <unicode/utf8.h>
@implementation NSString (XB_Utils)


#pragma mark - --- 数字字符串格式化 ---
+ (NSString *)positiveFloatFormat:(NSString *)text {
    
    if(!text || [text floatValue] == 0){
        return @"0.00";
    }else{
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setPositiveFormat:@",###.00;"];
        return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[text doubleValue]]];
    }
    return @"";
}

+ (NSString *)positiveIntFormat:(NSString *)text {
    
    if(!text || [text floatValue] == 0){
        return @"0.00";
    }else{
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setPositiveFormat:@",###;"];
        return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[text doubleValue]]];
    }
    return @"";
}

+ (NSString *)numberStringWithDouble:(double)doubleValue {
    NSString *temp = [NSString stringWithFormat:@"%lf",doubleValue];
    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:temp];
    return [number stringValue];
}

/// 隐藏电话号码中间4位数字
/// @param phoneNumber 手机字符串
+ (NSString *)phoneNumberFormat:(NSString *)phoneNumber {
    return [phoneNumber stringByReplacingOccurrencesOfString:@"(\\d{3})(\\d{3})(\\d{4})"
                                                  withString:@"$1 **** $3"
                                                     options:NSRegularExpressionSearch
                                                       range:NSMakeRange(0, [phoneNumber length])];
    
}

/// 隐藏银行卡号中间8位数字
/// @param cardNumber 手机字符串
+ (NSString *)cardNumberFormat:(NSString *)cardNumber {
    return [cardNumber stringByReplacingCharactersInRange:NSMakeRange(5, 8) withString:@"********"];;
}


/// 手机号格式化, 默认: 138 0013 8000
/// @param phoneNumber 手机字符串
+ (NSString *)stringMobileFormat:(NSString *)phoneNumber {

    
    return [phoneNumber stringByReplacingOccurrencesOfString:@"(\\d{3})(\\d{3})(\\d{4})"
                                                  withString:@"$1 $2 $3"
                                                     options:NSRegularExpressionSearch
                                                       range:NSMakeRange(0, [phoneNumber length])];
}

#pragma mark - --- 清除内容 ---
/** 清除html标签 */
- (NSString *)stringByRemoveHTML {
    NSString *removeString = @"<[^>]+>";
    return [self stringByReplacingOccurrencesOfString:removeString withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, self.length)];
}

/** 清除js脚本 */
- (NSString *)stringByRemoveJSScript {
    NSMutableString *mString = [[NSMutableString alloc] init];
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<script[^>]*>[\\w\\w]*</script>" options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *matches = [regex matchesInString:mString options:NSMatchingReportProgress range:NSMakeRange(0, mString.length)];
    for (NSTextCheckingResult *match in [matches reverseObjectEnumerator]) {
        [mString replaceCharactersInRange:match.range withString:@""];
    }
    return [mString stringByRemoveHTML];
}

/** 清除空格 */
- (NSString *)stringByRemoveSpace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

/** 清除空格和换行 */
- (NSString *)stringByRemoveEnterAndSpace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)stringByRemoveEmoji {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
    if (!data) {
        return nil;
    }
    const char *buff = (char *)data.bytes;
    NSUInteger len = [data length];
    char *str = (char *)malloc(len);
    unsigned int inputIndex = 0, outputIndex = 0;
    int uc;
    while (inputIndex < len) {
        //一个一个字符遍历
        U8_NEXT_UNSAFE(buff, inputIndex, uc);
        //是emoji就放弃本轮循环
        if (0x2100 <= uc && uc <= 0x26ff) {
            continue;
        }
        if(0x1d000 <= uc && uc <= 0x1f77f) {
            continue;
        }
        //不是emoji表情，添加到str中
        U8_APPEND_UNSAFE(str, outputIndex, uc);
    }
    return [[NSString alloc] initWithBytesNoCopy:str length:outputIndex encoding:NSUTF8StringEncoding freeWhenDone:YES];
}

#pragma mark - --- String与Data转换 ---
- (NSData *)toData {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString *)toStringFromData:(NSData *)data {
    if (data && [data isKindOfClass:[NSData class]]) {
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}
@end
