//
//  NSObject+Invocation.h
//  XBKit
//
//  Created by Xinbo Hong on 2018/10/16.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Invocation)

/**
 * 基于NSObject封装一个可用于JS调用OC方法的分类，适用于参数可有可无，可有多个
 
 @param selector 方法名
 @param parameters 参数
 @return 返回值
 */
- (id)performSelector:(SEL)selector withParameters:(NSArray *)parameters;

@end

NS_ASSUME_NONNULL_END
