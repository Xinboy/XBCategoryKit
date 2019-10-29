//
//  NSTimer+XB_WeakTimer.h
//  XBCategoryKit_Tests
//
//  Created by Xinbo Hong on 2019/10/28.
//  Copyright © 2019 Xinboy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (XB_WeakTimer)

+ (NSTimer *)scheduledWeakTimerWithTimeInterval:(NSTimeInterval)ti
                                         target:(id)aTarget
                                       selector:(SEL)aSelector
                                       userInfo:(id)userInfo
                                        repeats:(BOOL)yesOrNo;


@end

NS_ASSUME_NONNULL_END
