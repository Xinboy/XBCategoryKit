//
//  NSTimer+XB_Extension.m
//  XBCategoryKit_Example
//
//  Created by Xinbo Hong on 2019/9/7.
//  Copyright © 2019 Xinboy. All rights reserved.
//

#import "NSTimer+XB_Extension.h"

@interface TimerTarget: NSObject

@property (nonatomic, weak) id target;

@property (nonatomic, assign) SEL selector;

@property (nonatomic, weak) NSTimer *timer;

@end


@implementation TimerTarget

- (void)timerTargetAction:(NSTimer *)timer {
    if (self.target) {
        IMP imp = [self.target methodForSelector:self.selector];
        void (*func)(id, SEL, NSTimer*) = (void *)imp;
        func(self.target, self.selector, timer);
    } else {
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end

@implementation NSTimer (XB_Extension)

+ (instancetype)xb_ScheduledTimerWithTimeInterval:(NSTimeInterval)time
                                           target:(id)aTarget
                                         selector:(SEL)aSelector
                                         userInfo:(id)userInfo {
    
    TimerTarget *tt = [[TimerTarget alloc] init];
    tt.target = aTarget;
    tt.selector = aSelector;
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:time target:tt selector:@selector(timerTargetAction:)  userInfo:userInfo repeats:YES];
    
    tt.timer = timer;
    
    return timer;
}

@end
