//
//  NSString+Regex.m
//  XBProjectModule
//
//  Created by Xinbo Hong on 2018/1/2.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

#import "NSString+XB_Regex.h"

static NSString *const kValidationUserName = @"^[\u4E00-\u9FA5A-Za-z0-9]-$";
static NSString *const kValidationPassword = @"^[a-zA-Z][a-zA-Z0-9_]{5,15}$";
static NSString *const kValidationMainAddress = @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
static NSString *const kValidationCarNumber = @"^[\u4e00-\u9fff]{1}[a-zA-Z]{1}[-][a-zA-Z_0-9]{4,5}[a-zA-Z_0-9_\u4e00-\u9fff]$";
static NSString *const kValidationPhoneNumber = @"^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(17[0,3,5-8])|(18[0-9])|166|198|199|(147))\\d{8}$";
static NSString *const kValidationIDCard = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
static NSString *const kValidationIpv4Address = @"^(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})$";
static NSString *const kValidationMacAddress = @"([A-Fa-f\\d]{2}:){5}[A-Fa-f\\d]{2}";
static NSString *const kValidationUrl = @"^((http)|(https))+:[^\\s]+\\.[^\\s]*$";
static NSString *const kValidationChinese = @"^[\u4e00-\u9fa5]+$";
static NSString *const kValidationPostalcode = @"^[\u4e00-\u9fa5]+$";
static NSString *const kValidationTaxNo = @"[0-9]\\d{13}([0-9]|X)$";

@implementation NSString (XB_Regex)

- (BOOL)isVerifyUserName {
    return [self basePredicate:kValidationUserName];
}

- (BOOL)isVerifyPassword {
    return [self basePredicate:kValidationPassword];
}

- (BOOL)isVerifyMainAddress {
    return [self basePredicate:kValidationMainAddress];
}

//车牌
- (BOOL)isCarNumber {
    //车牌号:湘K-DE829 新能源车牌:浙A-F92320 香港车牌号码:粤Z-J499港
    //其中\u4e00-\u9fa5表示unicode编码中汉字已编码部分，\u9fa5-\u9fff是保留部分，将来可能会添加
    return [self basePredicate:kValidationCarNumber];
}


- (BOOL)isPhoneNumber {
    return [self basePredicate:kValidationPhoneNumber];
}


- (BOOL)isVerifyPhoneNumber {
    /**
     * 移动号段正则表达式
     */
    NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
    /**
     * 联通号段正则表达式
     */
    NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
    /**
     * 电信号段正则表达式
     */
    NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
    
    BOOL isMatch1 = [self basePredicate:CM_NUM];
    BOOL isMatch2 = [self basePredicate:CU_NUM];
    BOOL isMatch3 = [self basePredicate:CT_NUM];
    
    if (isMatch1 || isMatch2 || isMatch3){
        return YES;
    }
    return NO;
}

- (BOOL)isIDCard {
    return [self basePredicate:kValidationIDCard];
}

- (BOOL)isVerifyIDCard {
    //长度不为18的都排除掉
    if (self.length!=18) {
        return NO;
    }
    
    //校验格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    BOOL flag = [identityCardPredicate evaluateWithObject:self];
    
    if (!flag) {
        return flag;    //格式错误
    } else {
        //格式正确在判断是否合法
        
        //将前17位加权因子保存在数组里
        NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
        
        //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
        
        //用来保存前17位各自乖以加权因子后的总和
        NSInteger idCardWiSum = 0;
        for(int i = 0;i < 17;i++) {
            NSInteger subStrIndex = [[self substringWithRange:NSMakeRange(i, 1)] integerValue];
            NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
            
            idCardWiSum+= subStrIndex * idCardWiIndex;
            
        }
        
        //计算出校验码所在数组的位置
        NSInteger idCardMod=idCardWiSum%11;
        
        //得到最后一位身份证号码
        NSString * idCardLast= [self substringWithRange:NSMakeRange(17, 1)];
        
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if (idCardMod==2) {
            if ([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
                return YES;
            } else {
                return NO;
            }
        } else {
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if ([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
                return YES;
            } else {
                return NO;
            }
        }
    }
    
}


- (BOOL)isBankCardID {
    NSString *lastNum = [self substringFromIndex:(self.length - 1)].copy;
    NSString *forwardNum = [self substringToIndex:(self.length - 1)].copy;
    
    NSMutableArray *forwardArray = [NSMutableArray array];
    for (int i = 0; i < forwardNum.length; i++) {
        NSString *subStr = [forwardNum substringWithRange:NSMakeRange(i, i)];
        [forwardArray addObject:subStr];
    }
    
    NSMutableArray *forwardDescArray = [NSMutableArray array];
    for (NSInteger i = forwardArray.count - 1; i > -1; i--) {
        [forwardDescArray addObject:forwardArray[i]];
    }
    
    NSMutableArray *oddNumberArray = [NSMutableArray array];
    NSMutableArray *oddNumberArray2 = [NSMutableArray array];
    NSMutableArray *evenNumberArray = [NSMutableArray array];
    
    for (int i = 0; i < forwardDescArray.count; i++) {
        NSInteger num = [forwardDescArray[i] integerValue];
        
        if (i % 2) {
            //偶数
            [evenNumberArray addObject:[NSNumber numberWithInteger:num]];
        } else {
            //奇数
            if (num * 2 < 9) {
                [oddNumberArray addObject:[NSNumber numberWithInteger:num * 2]];
            } else {
                NSInteger decadeNumber = (num * 2) / 10;
                NSInteger unitNumber = (num * 2) % 10;
                
                [oddNumberArray2 addObject:[NSNumber numberWithInteger:unitNumber]];
                [oddNumberArray2 addObject:[NSNumber numberWithInteger:decadeNumber]];
            }
        }
    }
    
    __block NSInteger sumOddNumberTotal = 0;
    [oddNumberArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        sumOddNumberTotal += [obj intValue];
    }];
    
    __block NSInteger sumOddNumberTotal1 = 0;
    [oddNumberArray2 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        sumOddNumberTotal1 += [obj intValue];
    }];
    
    __block NSInteger sumEvenNumberTotal = 0;
    [evenNumberArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        sumEvenNumberTotal += [obj intValue];
    }];
    
    NSInteger lastNumber = [lastNum integerValue];
    
    NSInteger luhmTotal = lastNumber + sumEvenNumberTotal + sumOddNumberTotal + sumOddNumberTotal1;
    
    return (luhmTotal % 10 == 0) ? YES : NO;
}

- (BOOL)isIpv4Address {
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",kValidationIpv4Address];
    BOOL rc = [pre evaluateWithObject:self];
    
    if (rc) {
        NSArray *componds = [self componentsSeparatedByString:@","];
        
        BOOL v = YES;
        for (NSString *s in componds) {
            if (s.integerValue > 255) {
                v = NO;
                break;
            }
        }
        return v;
    }
    
    return NO;
}


- (BOOL)isMacAddress {
    return  [self basePredicate:kValidationMacAddress];
}


- (BOOL)isValidUrl {
    return [self basePredicate:kValidationUrl];
}

- (BOOL)isValidChinese {
    return [self basePredicate:kValidationChinese];
}

- (BOOL)isValidPostalcode {
    return [self basePredicate:kValidationPostalcode];
}

- (BOOL)isValidTaxNo {
    return [self basePredicate:kValidationTaxNo];
}

- (BOOL)basePredicate:(NSString *)regex {
    if (self != nil) {
        BOOL isLegal = NO;
        isLegal = [[NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex] evaluateWithObject:self];
        return isLegal;
    } else {
        return NO;
    }
}

@end
