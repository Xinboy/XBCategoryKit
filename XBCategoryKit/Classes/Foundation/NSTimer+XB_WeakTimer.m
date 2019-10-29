//
//  NSTimer+XB_WeakTimer.m
//  XBCategoryKit_Tests
//
//  Created by Xinbo Hong on 2019/10/28.
//  Copyright © 2019 Xinboy. All rights reserved.
//

#import "NSTimer+XB_WeakTimer.h"

@interface TimerWeakObject: NSObject

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, weak) NSTimer *timer;

- (void)fire:(NSTimer *)timer;
@end

@implementation TimerWeakObject

- (void)fire:(NSTimer *)timer {
    if (self.target) {
        [self.target performSelector:self.selector withObject:timer.userInfo];
    } else {
        [self.timer invalidate];
    }
}

@end




@implementation NSTimer (XB_WeakTimer)


+ (NSTimer *)scheduledWeakTimerWithTimeInterval:(NSTimeInterval)ti
                                         target:(id)aTarget
                                       selector:(SEL)aSelector
                                       userInfo:(id)userInfo
                                        repeats:(BOOL)yesOrNo {
    
    TimerWeakObject *obj = [[TimerWeakObject alloc] init];
    obj.target = aTarget;
    obj.selector = aSelector;
    
    //会调用TimerWeakObject中的fire方法，在fire进行实际的具体方法
    obj.timer = [NSTimer scheduledTimerWithTimeInterval:ti target:obj selector:@selector(fire:) userInfo:userInfo repeats:yesOrNo];
    
    return obj.timer;
}

@end
