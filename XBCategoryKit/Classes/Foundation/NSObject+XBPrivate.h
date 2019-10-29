//
//  NSObject+XBPrivate.h
//  XBCategoryKit_Example
//
//  Created by Xinbo Hong on 2019/3/9.
//  Copyright © 2019年 Xinboy. All rights reserved.
//  系统权限提醒，主要用于拒绝情况后跳转设置

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SystemPrivacy) {
    //相机权限
    SystemPrivacyCamera = 1,
    //相册权限
    SystemPrivacyPhotoLibrary,
    //麦克风权限
    SystemPrivacyMicrophone,
    //定位权限
    SystemPrivacyLocation,
    //通知权限
    SystemPrivacyUserNotification
};

@interface NSObject (XBPrivate)

/// 检查是否开启系统权限
- (void)checkPrivacyEnable:(SystemPrivacy)type
            resultCallBack:(void (^)(BOOL isResult))resultBlock;

/// 检查是否开启权限，未开启权限弹出提醒窗
- (void)checkPrivacyEnableWithAlert:(SystemPrivacy)type
                     resultCallBack:(void (^)(BOOL isResult))resultBlock;


/// 检查是否开启权限，未开启权限弹出提醒窗，并捕获用户不允许操作
- (void)checkPrivacyEnableWithAlert:(SystemPrivacy)type
                         resultCallBack:(void (^)(BOOL isResult))resultBlock
                         cancelCallBack:(void (^)(void))cancelBlock;




@end

NS_ASSUME_NONNULL_END


//可以直接复制下列内容到info.plist完成提示描述，

/*
 
<key>NSCameraUsageDescription</key>
<string>开启访问相机权限可以拍摄您喜欢的照片设置为菜品样照</string>
<key>NSPhotoLibraryAddUsageDescription</key>
<string>开启添加照片权限可以将您喜欢的图片保存在本地相册</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>开启访问相册权限可以选择您喜欢的照片设置为菜品样照</string>
<key>NSLocationUsageDescription</key>
<string>开启定位权限可以选择您的店铺位置</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>开启定位权限可以选择您的店铺位置</string>
 
*/
