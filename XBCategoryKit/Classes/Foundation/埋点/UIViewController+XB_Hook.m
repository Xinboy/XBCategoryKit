//
//  UIViewController+XB_Hook.m
//  XBCategoryKit_Example
//
//  Created by Xinbo Hong on 2019/9/16.
//  Copyright © 2019 Xinboy. All rights reserved.
//

#import "UIViewController+XB_Hook.h"
#import <objc/runtime.h>
#import "XBAnalyseDataHelper.h"
static NSDate *startDate;



/*
 视图类名：ChangePwdViewController
 视图名称：修改密码
 视图位置：登陆-忘记密码-修改密码，设置-修改密码
 */
@implementation UIViewController (XB_Hook)

+ (void)load {
    
    //页面进入Hook方法
    Method fromMethod = class_getInstanceMethod([self class], @selector(viewDidAppear:));
    Method toMethod = class_getInstanceMethod([self class], @selector(hook_viewDidAppear));
    
    if (!class_addMethod([self class], @selector(hook_viewDidAppear), method_getImplementation(toMethod), method_getTypeEncoding(toMethod))) {
        method_exchangeImplementations(fromMethod, toMethod);
    }
    
    //页面离开Hook方法
    Method fromMethodDis = class_getInstanceMethod([self class], @selector(viewDidDisappear:));
    Method toMethodDis = class_getInstanceMethod([self class], @selector(hook_viewDidDisappear));
    
    if (!class_addMethod([self class], @selector(hook_viewDidDisappear), method_getImplementation(toMethodDis), method_getTypeEncoding(toMethodDis))) {
        method_exchangeImplementations(fromMethodDis, toMethodDis);
    }
    
}


- (void)hook_viewDidAppear {
    
    [self configEnterMethod];
    
    [self hook_viewDidAppear];
}

//自己的离开方法
- (void)hook_viewDidDisappear {

    
    [self configLeaveMethod];
    
    [self hook_viewDidDisappear];
}

/// 进入界面开始打点
- (void)configEnterMethod {
    NSString *vcName = [NSString stringWithFormat:@"%@", self.class];
    
    BOOL isGlobal = [XBAnalyseDataHelper getGlobalHookStatus];
    if (isGlobal) {
    
        // 剔除掉系统的UIViewController的对象
        if(![vcName containsString:@"UI"]){
            startDate = [NSDate  date];
            NSLog(@"统计打点-页面进入%@, 进入时间: %@",vcName ,startDate);
        }
        
    } else {
        NSDictionary *data = [XBAnalyseDataHelper getJsonData:@"viewController"];
        if ([[data allKeys] containsObject:vcName]) {
            // 剔除掉系统的UIViewController的对象
            if(![vcName containsString:@"UI"]){
                startDate = [NSDate  date];
                NSLog(@"统计打点-页面进入%@, %@, 进入时间: %@",vcName, data[vcName] ,startDate);
            }
        }
    }
    
}

/// 离开界面保存数据
- (void)configLeaveMethod {
    NSString *vcName = [NSString stringWithFormat:@"%@", self.class];
    
    BOOL isGlobal = [XBAnalyseDataHelper getGlobalHookStatus];
    if (isGlobal) {
        
        //计算时间差
        NSDate *endDate = [NSDate date];
        NSTimeInterval duration = [endDate timeIntervalSinceDate:startDate];
        NSLog(@"统计打点-页面离开%@, 离开时间: %@, 持续时间: %.2f",vcName ,startDate, duration);
        
        NSDictionary *vcDict = @{kViewControllerClassName: vcName,
                                 kViewControllerName: @"未知",
                                 kViewControllerDuration: [NSNumber numberWithFloat:duration],
                                 };
        
        [XBAnalyseDataHelper analyseWithData:vcDict withType:AnalyseTypeViewController];
        
    } else {
        
        NSDictionary *data = [XBAnalyseDataHelper getJsonData:@"viewController"];
        if ([[data allKeys] containsObject:vcName]) {
            if (![vcName containsString:@"UI"]) {
                //计算时间差
                NSDate *endDate = [NSDate date];
                NSTimeInterval duration = [endDate timeIntervalSinceDate:startDate];
                NSLog(@"统计打点-页面离开%@, %@, 离开时间: %@, 持续时间: %.2f",vcName, data[vcName] ,startDate, duration);
                
                NSDictionary *vcDict = @{kViewControllerClassName: vcName,
                                         kViewControllerName: data[vcName],
                                         kViewControllerDuration: [NSNumber numberWithFloat:duration],
                                         };
                
                [XBAnalyseDataHelper analyseWithData:vcDict withType:AnalyseTypeViewController];
            }
        }
    }
    
    
}

@end
