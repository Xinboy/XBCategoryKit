//
//  NSString+Encryption.m
//  XBProjectModule
//
//  Created by Xinbo Hong on 2018/1/2.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

#import "NSString+XB_Encryption.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

#import "NSData+XB_Encryption.h"

@implementation NSString (XB_Encryption)

#pragma mark --- AES256 ---
- (NSString *)aes256_encrypt:(NSString *)key {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    //对数据进行加密
    NSData *result = [data aes256_encrypt:key];
    
    //转换为2进制字符串
    if (result && result.length > 0) {
        Byte *datas = (Byte*)[result bytes];
        NSMutableString *output = [NSMutableString stringWithCapacity:result.length * 2];
        for(int i = 0; i < result.length; i++) {
            [output appendFormat:@"%02x", datas[i]];
        }
        return output;
    }
    return nil;
}

- (NSString *)aes256_decrypt:(NSString *)key {
    //转换为2进制Data
    NSMutableData *data = [NSMutableData dataWithCapacity:self.length / 2];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i;
    for (i=0; i < [self length] / 2; i++) {
        byte_chars[0] = [self characterAtIndex:i*2];
        byte_chars[1] = [self characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_byte length:1];
    }
    NSLog(@"%@",data);
    //对数据进行解密
    NSData* result = [data aes256_decrypt:key];
    if (result && result.length > 0) {
        return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    }
    return nil;
}

/*CC_MD5_DIGEST_LENGTH*/
#define  MD5_LENGTH   32
+ (NSString *)md5:(NSString *)inPutText {
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    
    return ret;
}

#pragma mark --- Base64 ---
//加密
+ (NSString *)base64_encrypt:(NSString *)encryptString {
    NSData *encodeData = [encryptString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [encodeData base64EncodedStringWithOptions:0];
    return base64String;
}
//解密
+ (NSString *)base64_decrypt:(NSString *)decryptString {
    NSData *decodeData = [[NSData alloc] initWithBase64EncodedString:decryptString options:0];
    NSString *decodedString = [[NSString alloc] initWithData:decodeData encoding:NSUTF8StringEncoding];
    return decodedString;
}
@end
