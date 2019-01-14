//
//  NSDictionary+XB_Extension.m
//  XBCategoryKit_Example
//
//  Created by Xinbo Hong on 2018/12/10.
//  Copyright © 2018年 Xinboy. All rights reserved.
//

#import "NSDictionary+XB_Extension.h"

@implementation NSDictionary (XB_Extension)

- (NSString *)JSONString {
    
    NSData *JSONData = nil;
    
    JSONData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    
    return [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
}

// 打印Model所需要的属性代码
- (void)propertyCode {
    NSMutableString *codes = [NSMutableString string];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *code;
        if ([obj isKindOfClass:[NSString class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic ,strong) NSString *%@;",key];
        } else if ([obj isKindOfClass:NSClassFromString(@"__NSCFBoolean")]) {
            code = [NSString stringWithFormat:@"@property (nonatomic ,assign) BOOL %@;",key];
        } else if ([obj isKindOfClass:[NSNumber class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic ,assign) NSInteger %@;",key];
        } else if ([obj isKindOfClass:[NSArray class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic ,strong) NSArray *%@;",key];
        } else if ([obj isKindOfClass:[NSDictionary class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic ,strong) NSDictionary *%@;",key];
        }
        
        [codes appendFormat:@"\n%@\n",code];
    }];
    NSLog(@"%@",codes);
}

- (NSString *)descriptionWithLocale:(id)locale {
    if ([self count]) {
        return @"";
    }
    NSString *willDealStr = [[self description] stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    
    willDealStr = [willDealStr stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\""];
    willDealStr = [[@"\"" stringByAppendingString:willDealStr] stringByReplacingOccurrencesOfString:@"\"" withString:@"\""];
    NSData *data = [willDealStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *str = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:NULL];
    
    return str;
}

@end
