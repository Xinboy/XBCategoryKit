//
//  NSData+AES256.h
//  ASEEncrypt
//
//  Created by 张心朝 on 16/6/28.
//  Copyright © 2016年 张心朝. All rights reserved.
//  数据加密

#import <Foundation/Foundation.h>
@class NSString;
@interface NSData (XB_Encryption)
//加密
- (NSData *)aes256_encrypt:(NSString *)key;
//解密
- (NSData *)aes256_decrypt:(NSString *)key;
@end
