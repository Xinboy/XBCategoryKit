//
//  NSObject+Properties.h
//  XBKit
//
//  Created by Xinbo Hong on 2018/10/10.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (XB_Properties)


//类名
- (NSString *)className;
+ (NSString *)className;

//父类名称
- (NSString *)superClassName;
+ (NSString *)superClassName;

//实例属性字典
- (NSDictionary *)propertiesValues;
+ (NSDictionary *)propertiesValues;

//属性名称列表
- (NSArray *)propertyKeys;
+ (NSArray *)propertyKeys;

//方法列表
-(NSArray *)methodList;
+(NSArray *)methodList;
@end

NS_ASSUME_NONNULL_END
