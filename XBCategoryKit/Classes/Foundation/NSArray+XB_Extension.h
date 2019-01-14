//
//  NSArray+XB_Extension.h
//  XBCategoryKit_Example
//
//  Created by Xinbo Hong on 2018/12/28.
//  Copyright © 2018年 Xinboy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (XB_Extension)

/**
 删除数组中重复的数据
 
 @param array 需要删除的数组
 @return 删除完成的数组
 */
+ (NSArray *)arrayWithRemoveDuplicateObjects:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
