//
//  NSString+Attributed.h
//  XBKit
//
//  Created by Xinbo Hong on 2018/5/29.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (XB_Utils)
#pragma mark - --- 数字字符串格式化 ---


/// 数值转换成字符串，解决出现显示0.000...0001或者0.999...9999问题
/// @param doubleValue 数值
+ (NSString *)numberStringWithDouble:(double)doubleValue;

/// 千分位+ 保留两位小数点：##,###.00
/// @param text 整数字符串
+ (NSString *)positiveFloatFormat:(NSString *)text;


/// 千分位 整数：##,###
/// @param text 整数字符串
+ (NSString *)positiveIntFormat:(NSString *)text;



/// 隐藏电话号码中间4位数字
/// @param phoneNumber 手机字符串
+ (NSString *)phoneNumberFormat:(NSString *)phoneNumber;

/// 隐藏银行卡号中间8位数字
/// @param cardNumber 手机字符串
+ (NSString *)cardNumberFormat:(NSString *)cardNumber;


/// 手机号格式化, 默认: 138 0013 8000
/// @param phoneNumber 手机字符串
+ (NSString *)stringMobileFormat:(NSString *)phoneNumber;

#pragma mark - --- 清除内容 ---
- (NSString *)stringByRemoveHTML;

- (NSString *)stringByRemoveJSScript;

- (NSString *)stringByRemoveSpace;

- (NSString *)stringByRemoveEnterAndSpace;

#pragma mark - --- String与Data转换 ---
- (NSData *)toData;

+ (NSString *)toStringFromData:(NSData *)data;

@end
