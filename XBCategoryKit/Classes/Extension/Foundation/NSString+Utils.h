//
//  NSString+Attributed.h
//  XBKit
//
//  Created by Xinbo Hong on 2018/5/29.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Utils)
#pragma mark - --- 数字字符串格式化 ---
//千分位+ 保留两位小数点
+ (NSString *)positiveFloatFormat:(NSString *)text;
//千分位 整数
+ (NSString *)positiveIntFormat:(NSString *)text;

#pragma mark - --- 清除内容 ---
- (NSString *)stringByRemoveHTML;

- (NSString *)stringByRemoveJSScript;

- (NSString *)stringByRemoveSpace;

- (NSString *)stringByRemoveEnterAndSpace;

#pragma mark - --- String与Data转换 ---
- (NSData *)toData;

+ (NSString *)toStringFromData:(NSData *)data;

@end
