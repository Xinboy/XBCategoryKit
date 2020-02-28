//
//  UIControl+XB_Hook.m
//  XBCategoryKit_Example
//
//  Created by Xinbo Hong on 2019/9/16.
//  Copyright © 2019 Xinboy. All rights reserved.
//

#import "UIControl+XB_Hook.h"
#import <objc/runtime.h>

#import "XBAnalyseDataHelper.h"



@implementation UIControl (XB_Hook)

+ (void)load {
    
    //页面进入Hook方法
    Method fromMethod = class_getInstanceMethod([self class], @selector(sendAction:to:forEvent:));
    Method toMethod = class_getInstanceMethod([self class], @selector(hook_sendAction:to:forEvent:));
    
    if (!class_addMethod([self class], @selector(hook_sendAction:to:forEvent:), method_getImplementation(toMethod), method_getTypeEncoding(toMethod))) {
        method_exchangeImplementations(fromMethod, toMethod);
    }

}

- (void)hook_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    NSString *methodName = NSStringFromSelector(action);
    NSString *className = [NSString stringWithUTF8String:object_getClassName(target)];
    UIControl *sender = (UIControl *)self;
    
    
    BOOL isGlobal = [XBAnalyseDataHelper getGlobalHookStatus];
    if (isGlobal) {
        NSLog(@"事件触发-方法: %@, 位于: %@, tag: %ld",methodName, className, (long)sender.tag);
        
        //使用当前时间表示最后操作时间
        NSDate *date = [NSDate date];
        NSTimeZone *zone = [NSTimeZone systemTimeZone];
        NSInteger interval = [zone secondsFromGMTForDate: date];
        NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
        
        //组合数据并存入数据库
        NSDictionary *eventDic = @{kEventClassName:className,
                                   kEventMethodName:methodName,
                                   kEventCount: [NSNumber numberWithInteger:1],
                                   kEventLastDate:[NSString stringWithFormat:@"%@",localeDate],
                                   kEventName: @"未知",
                                   kEventTag:[NSString stringWithFormat:@"%ld",(long)sender.tag],
                                   };
        [XBAnalyseDataHelper analyseWithData:eventDic withType:AnalyseTypeEvent];
    } else {
        //第一层，视图ClassName
        NSDictionary *data = [XBAnalyseDataHelper getJsonData:@"event"];
        if ([[data allKeys] containsObject:className]) {
            //第二层，Action
            NSDictionary *class = data[className];
            if([[class allKeys] containsObject:methodName]){
                NSDictionary *action = class[methodName];
                
                NSString *tag = [NSString stringWithFormat:@"%ld",sender.tag];
                
                if([[action allKeys] containsObject:tag]){
                    NSDictionary *oneAction = action[tag];
                    NSLog(@"事件触发-方法: %@, 位于: %@,  %@, tag: %@",methodName, className, oneAction[@"name"], tag);
                    
                    //使用当前时间表示最后操作时间
                    NSDate *date = [NSDate date];
                    NSTimeZone *zone = [NSTimeZone systemTimeZone];
                    NSInteger interval = [zone secondsFromGMTForDate: date];
                    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
                    
                    //组合数据并存入数据库
                    NSDictionary *eventDic = @{kEventClassName:className,
                                               kEventMethodName:methodName,
                                               kEventCount: [NSNumber numberWithInteger:1],
                                               kEventLastDate:[NSString stringWithFormat:@"%@",localeDate],
                                               kEventName:oneAction[@"name"],
                                               kEventTag:tag,
                                               };
                    [XBAnalyseDataHelper analyseWithData:eventDic withType:AnalyseTypeEvent];
                }
            }
        }
    }
    
    [self hook_sendAction:action to:target forEvent:event];
}



@end
