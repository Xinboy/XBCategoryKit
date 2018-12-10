//
//  NSString+Attributed.m
//  XBKit
//
//  Created by Xinbo Hong on 2018/5/29.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

#import "NSString+XB_Utils.h"

@implementation NSString (XB_Utils)


#pragma mark - --- 数字字符串格式化 ---
+ (NSString *)positiveFloatFormat:(NSString *)text{
    
    if(!text                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    || [text floatValue] == 0){
        return @"0.00";
    }else{
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setPositiveFormat:@",###.00;"];
        return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[text doubleValue]]];
    }
    return @"";
}

+ (NSString *)positiveIntFormat:(NSString *)text{
    
    if(!text || [text floatValue] == 0){
        return @"0.00";
    }else{
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setPositiveFormat:@",###;"];
        return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[text doubleValue]]];
    }
    return @"";
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
