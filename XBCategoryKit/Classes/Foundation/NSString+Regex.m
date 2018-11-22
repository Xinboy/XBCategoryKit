//
//  NSString+Regex.m
//  XBProjectModule
//
//  Created by Xinbo Hong on 2018/1/2.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

#import "NSString+Regex.h"

@implementation NSString (Regex)

- (BOOL)isVerifyUserName {

    NSString *pattern = @"^[\u4E00-\u9FA5A-Za-z0-9]-$";
    return [self basePredicate:pattern];
}

- (BOOL)isVerifyPassword {
    NSString *pwdRegex = @"^[a-zA-Z][a-zA-Z0-9_]{5,15}$";
    return [self basePredicate:pwdRegex];
}

- (BOOL)isVerifyMainAddress {

    NSString *mailRegex = @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self basePredicate:mailRegex];
}


//车牌
- (BOOL)isCarNumber {
    //车牌号:湘K-DE829 香港车牌号码:粤Z-J499港
    NSString *carRegex = @"^[\u4e00-\u9fff]{1}[a-zA-Z]{1}[-][a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fff]$";
    //其中\u4e00-\u9fa5表示unicode编码中汉字已编码部分，\u9fa5-\u9fff是保留部分，将来可能会添加
    return [self basePredicate:carRegex];
}


- (BOOL)isPhoneNumber {
    NSString *phoneRegex = @"^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(17[0,3,5-8])|(18[0-9])|166|198|199|(147))\\d{8}$";
    return [self basePredicate:phoneRegex];
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
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
    BOOL isMatch1 = [pred1 evaluateWithObject:self];
    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
    BOOL isMatch2 = [pred2 evaluateWithObject:self];
    NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
    BOOL isMatch3 = [pred3 evaluateWithObject:self];
    
    if (isMatch1 || isMatch2 || isMatch3){
        return YES;
    }
    return NO;
}

- (BOOL)isIDCard {
    NSString *idRegex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    return [self basePredicate:idRegex];
    
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
    for (int i = forwardArray.count - 1; i > -1; i--) {
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
            NSInteger decadeNumber = (num * 2) / 10;
            NSInteger unitNumber = (num * 2) % 10;
            
            [oddNumberArray2 addObject:[NSNumber numberWithInteger:unitNumber]];
            [oddNumberArray2 addObject:[NSNumber numberWithInteger:decadeNumber]];
        }
    }
    
    __block NSInteger sumOddNumberTotal = 0;
    [oddNumberArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        sumOddNumberTotal += [obj intValue];
    }];
    
    __block NSInteger sumOddNumberTotal1 = 0;
    [oddNumberArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        sumOddNumberTotal1 += [obj intValue];
    }];
    
    __block NSInteger sumEvenNumberTotal = 0;
    [oddNumberArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        sumEvenNumberTotal += [obj intValue];
    }];
    
    NSInteger lastNumber = [lastNum integerValue];
    
    NSInteger luhmTotal = lastNumber + sumEvenNumberTotal + sumOddNumberTotal + sumOddNumberTotal1;
    
    return (luhmTotal % 10 == 0) ? YES : NO;
}

- (BOOL)isIPAddress {
    NSString *regex = [NSString stringWithFormat:@"^(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})$"];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
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
    NSString * macAddRegex = @"([A-Fa-f\\d]{2}:){5}[A-Fa-f\\d]{2}";
    return  [self basePredicate:macAddRegex];
}

- (BOOL)isValidUrl {
    NSString *regex = @"^((http)|(https))+:[^\\s]+\\.[^\\s]*$";
    return [self basePredicate:regex];
}

- (BOOL)isValidChinese {
    NSString *chineseRegex = @"^[\u4e00-\u9fa5]+$";
    return [self basePredicate:chineseRegex];
}

- (BOOL)isValidPostalcode {
    NSString *postalRegex = @"^[0-8]\\d{5}(?!\\d)$";
    return [self basePredicate:postalRegex];
}

- (BOOL)isValidTaxNo
{
    NSString *taxNoRegex = @"[0-9]\\d{13}([0-9]|X)$";
    return [self basePredicate:taxNoRegex];
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
