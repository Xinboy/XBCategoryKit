//
//  XBAnalyseDataHelper.h
//  XBCategoryKit_Example
//
//  Created by Xinbo Hong on 2019/9/16.
//  Copyright © 2019 Xinboy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/* 视图统计停留时间相关 */
/// 视图类名：XBViewController - NSString
UIKIT_EXTERN NSString *kViewControllerClassName;
/// 视图中文名：我的视图 - NSString
UIKIT_EXTERN NSString *kViewControllerName;
/// 视图停留总时间：20.0 - NSNumber
UIKIT_EXTERN NSString *kViewControllerDuration;
/// 视图本地存储Key
UIKIT_EXTERN NSString *kViewControllerAnalyseKey;

/* 事件触发次数相关 */
/// 事件所在的类
UIKIT_EXTERN NSString *kEventClassName;
/// 事件的名称
UIKIT_EXTERN NSString *kEventMethodName;
/// 事件的触发次数
UIKIT_EXTERN NSString *kEventCount;
/// 事件的最后触发事件
UIKIT_EXTERN NSString *kEventLastDate;
/// 事件的中文名称
UIKIT_EXTERN NSString *kEventName;
/// 事件的Tag值
UIKIT_EXTERN NSString *kEventTag;
/// 事件本地存储Key
UIKIT_EXTERN NSString *kEventAnalyseKey;

typedef NS_ENUM(NSInteger, AnalyseType) {
    /// 视图停留时间
    AnalyseTypeViewController,
    /// 点击事件触发的次数（系统控件）
    AnalyseTypeEvent,
};

@interface XBAnalyseDataHelper : NSObject

/// 调用后改为全局埋点
+ (void)beginGlobalHook;

/// 采用根据analyse.json文件匹配
+ (void)cancelGlobalHook;

/// 获取是否全局埋点状态
+ (BOOL)getGlobalHookStatus;

/// 根据分析类型进行数据保存
+ (void)analyseWithData:(NSDictionary *)data withType:(AnalyseType)type;

/// 上传埋点统计信息
+ (void)uploadBuriedPointData;

/// 获取analyse.json的内容
+ (NSDictionary *)getJsonData:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
