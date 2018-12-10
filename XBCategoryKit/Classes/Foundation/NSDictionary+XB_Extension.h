//
//  NSDictionary+XB_Extension.h
//  XBCategoryKit_Example
//
//  Created by Xinbo Hong on 2018/12/10.
//  Copyright © 2018年 Xinboy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (XB_Extension)

/**
 *  字典转成JSON字符串数据
 */
@property (nonatomic, copy, readonly) NSString *JSONString;

// 打印Model所需要的属性代码
- (void)propertyCode;

@end

NS_ASSUME_NONNULL_END
