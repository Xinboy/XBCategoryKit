//
//  NSObject+Properties.m
//  XBKit
//
//  Created by Xinbo Hong on 2018/10/10.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

#import "NSObject+XB_Properties.h"
#import <objc/runtime.h>

@implementation NSObject (XB_Properties)

//类名
- (NSString *)className {
    return NSStringFromClass([self class]);
}
+ (NSString *)className {
    return NSStringFromClass([self class]);
}

//父类名称
- (NSString *)superClassName {
    return NSStringFromClass([self superclass]);
}
+ (NSString *)superClassName {
    return NSStringFromClass([self superclass]);
}

//属性名称列表
- (NSArray *)propertyKeys {
    return [[self class] propertyKeys];
}
+ (NSArray *)propertyKeys {
    NSMutableArray *propertyKeys = [NSMutableArray array];
    unsigned propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList(self, &propertyCount);
    
    for (unsigned int i = 0; i < propertyCount; i++) {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        [propertyKeys addObject:[NSString stringWithUTF8String:name]];
    }
    return propertyKeys;
}

//属性参数列表（Key: Value）
- (NSDictionary *)propertiesValues {
    return [[self class] propertiesValues];
}

+ (NSDictionary *)propertiesValues {
    
    NSMutableDictionary *propertiesValuesDict = [NSMutableDictionary dictionary];
    unsigned int count;
    objc_property_t *propertys = class_copyPropertyList([self class], &count);
    for(int i = 0; i < count; i++){
        objc_property_t property = propertys[i];
        NSString *propertyName = [[NSString alloc]initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        id propertyValue = [self valueForKey:propertyName]? : @"nil";
        [propertiesValuesDict setObject:propertyValue?:[NSNull null] forKey:propertyName];
    }
    free(propertys);
    return propertiesValuesDict;
}

//方法列表
- (NSArray *)methodList {
    return [[self class] methodList];
}
+ (NSArray *)methodList {
    u_int count;
    NSMutableArray *methodList = [NSMutableArray array];
    Method *methods = class_copyMethodList([self class], &count);
    for (int i = 0; i < count; i++) {
        SEL name = method_getName(methods[i]);
        NSString *selName = [NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
        [methodList addObject:selName];
    }
    return methodList;
}


- (NSString *)debugDescription {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    uint count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        NSString *name = @(property_getName(property));
        id value = [self valueForKey:name] ? : @"nil";
        [dictionary setObject:value forKey:name];
    }
    free(properties);
    return [NSString stringWithFormat:@"<%@: %p>\n%@",[self class], self, dictionary];
}

@end
