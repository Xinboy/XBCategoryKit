//
//  NSString+Regex.h
//  XBProjectModule
//
//  Created by Xinbo Hong on 2018/1/2.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XB_Regex)

/**
 正则匹配字符：中文、英文、数字但不包括下划线等符号
 */
- (BOOL)isVerifyUserName;

/**
 正则匹配密码：英文、数字和下划线；长度6 - 16位
 */
- (BOOL)isVerifyPassword;

/**
 正则匹配邮箱
*/
- (BOOL)isVerifyMainAddress;

/**
 正则匹配车牌号：车牌号:湘K-DE829 香港车牌号码:粤Z-J499港
 */
- (BOOL)isCarNumber;

/**
 正则匹配手机号码：11位和所有运营商

 @return 是否匹配*/
- (BOOL)isPhoneNumber;

/**
 正则匹配手机号码：11位 三大运营商
*/
- (BOOL)isVerifyPhoneNumber;

/**
 正则匹配身份证号：身份证号
 */
- (BOOL)isIDCard;

/**
 正则精确匹配身份证号：身份证号
 */
- (BOOL)isVerifyIDCard;

/**
 *  正则匹配银行卡的有效性
 *  银行卡号有效性问题Luhn算法
 *  现行 16 位银联卡现行卡号开头 6 位是 622126～622925 之间的，7 到 15 位是银行自定义的，
 *  可能是发卡分行，发卡网点，发卡序号，第 16 位是校验码。
 *  16 位卡号校验位采用 Luhm 校验方法计算：
 *  1，将未带校验位的 15 位卡号从右依次编号 1 到 15，位于奇数位号上的数字乘以 2
 *  2，将奇位乘积的个十位全部相加，再加上所有偶数位上的数字
 *  3，将加法和加上校验位能被 10 整除。
 */
- (BOOL)isBankCardID;

/**
 *  正则匹配IP地址有效性
 */
- (BOOL)isIpv4Address;

/**
 *  正则匹配Mac地址有效性
 */
- (BOOL)isMacAddress;

/**
 *  正则匹配网址有效性
 */
- (BOOL)isValidUrl;

/**
 *  正则匹配纯汉字
 */
- (BOOL)isValidChinese;

/**
 *  正则匹配邮政编码
 */
- (BOOL)isValidPostalcode;

/**
 *  正则匹配工商税号
 */
- (BOOL)isValidTaxNo;
@end
