//
//  NSTimer+XB_Extension.h
//  XBCategoryKit_Example
//
//  Created by Xinbo Hong on 2019/9/7.
//  Copyright © 2019 Xinboy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (XB_Extension)

/**
 *  创建一个不会造成循环引用的循环执行的Timer
 *  解决NSTimer 使用导致的内存泄漏
 */
+ (instancetype)xb_ScheduledTimerWithTimeInterval:(NSTimeInterval)ti
                                           target:(id)aTarget
                                         selector:(SEL)aSelector
                                         userInfo:(id)userInfo;

@end

NS_ASSUME_NONNULL_END
