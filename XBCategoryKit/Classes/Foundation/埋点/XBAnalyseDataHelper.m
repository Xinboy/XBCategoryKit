//
//  XBAnalyseDataHelper.m
//  XBCategoryKit_Example
//
//  Created by Xinbo Hong on 2019/9/16.
//  Copyright © 2019 Xinboy. All rights reserved.
//

#import "XBAnalyseDataHelper.h"

/* 视图统计停留时间相关 */
NSString *kViewControllerClassName = @"kViewControllerClassName";
NSString *kViewControllerName = @"kViewControllerName";
NSString *kViewControllerDuration = @"kViewControllerDuration";
NSString *kViewControllerAnalyseKey = @"VC_ANALYSE_KEY";

/* 事件触发次数相关 */
NSString *kEventClassName = @"kEventClassName";
NSString *kEventMethodName = @"kEventMethodName";
NSString *kEventCount = @"kEventCount";
NSString *kEventLastDate = @"kEventLastDate";
NSString *kEventName = @"kEventName";
NSString *kEventTag = @"kEventTag";
NSString *kEventAnalyseKey = @"EVENT_ANALYSE_KEY";

NSString *kIsGlobalHookKey = @"IS_GLOBAL_HOOK_KEY";

@implementation XBAnalyseDataHelper

+ (void)beginGlobalHook {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:[NSNumber numberWithBool:YES] forKey:kIsGlobalHookKey];
}


+ (void)cancelGlobalHook {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:[NSNumber numberWithBool:NO] forKey:kIsGlobalHookKey];
}


+ (BOOL)getGlobalHookStatus {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSNumber *isGlobal = [def objectForKey:kIsGlobalHookKey];
    if (isGlobal == nil || isGlobal.boolValue == NO) {
        return NO;
    } else {
        return YES;
    }
}

+ (void)analyseWithData:(NSDictionary *)data withType:(AnalyseType)type {
    
    switch (type) {
        case AnalyseTypeViewController:
            [XBAnalyseDataHelper analyseVCWithData:data];
            break;
        case AnalyseTypeEvent:
            [XBAnalyseDataHelper analyseEventWithData:data];
            break;
    }
}
/**
 分析统计页面
 */
+ (void)analyseVCWithData:(NSDictionary *)data{

    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    //数据在UserDefault中，获取原有数据
    NSMutableArray *list = [NSMutableArray arrayWithArray:[def objectForKey:kViewControllerAnalyseKey]];
    
    NSString *vcName = data[kViewControllerClassName];
    
    for (NSInteger i = 0; i < list.count; i++) {
        NSDictionary *dict = list[i];
        //说明有数据，更新时长数据
        if ([dict[kViewControllerClassName] isEqualToString:vcName]) {
            NSNumber *lastNumber = dict[kViewControllerDuration];
            NSNumber *nowNumber = data[kViewControllerDuration];
            
            NSMutableDictionary *final = dict.mutableCopy;
            final[kViewControllerDuration] = [NSNumber numberWithFloat:lastNumber.floatValue + nowNumber.floatValue];
            
            list[i] = final;
            
            [def setObject:list forKey:kViewControllerAnalyseKey];
            return;
        }
    }
    
    //新数据加入
    [list addObject:data];
    [def setObject:list forKey:kViewControllerAnalyseKey];

}

+ (void)analyseEventWithData:(NSDictionary *)data{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    //数据在UserDefault中，获取原有数据
    NSMutableArray *list = [NSMutableArray arrayWithArray:[def objectForKey:kEventAnalyseKey]];

    
    //创建对应的类
    NSString *eventName = data[kEventClassName];
    for (NSInteger i = 0; i < list.count; i++) {
        NSDictionary *dict = list[i];
        //说明有数据，更新触发次数
        if ([dict[kEventClassName] isEqualToString:eventName]) {
            
            
            NSMutableDictionary *final = dict.mutableCopy;
            NSNumber *lastCount = dict[kEventCount];
            final[kEventCount] = [NSNumber numberWithInteger:lastCount.integerValue + 1];
            list[i] = final;
            
            [def setObject:list forKey:kEventAnalyseKey];
            return;
        }
    }
    
    //新数据加入
    [list addObject:data];
    [def setObject:list forKey:kEventAnalyseKey];
}


+ (void)uploadBuriedPointData {
    
}


+ (NSDictionary *)getJsonData:(NSString *)key {
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"analyse" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    
    return dic[key];
}




@end
