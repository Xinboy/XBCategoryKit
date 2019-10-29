//
//  NSObject+XBPrivate.m
//  XBCategoryKit_Example
//
//  Created by Xinbo Hong on 2019/3/9.
//  Copyright © 2019年 Xinboy. All rights reserved.
//

#import "NSObject+XBPrivate.h"
#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UserNotifications/UserNotifications.h>

typedef void (^ PrivacyCancelBlock)(void);


@implementation NSObject (XBPrivate)

- (void)checkPrivacyEnable:(SystemPrivacy)type
            resultCallBack:(void (^)(BOOL isResult))resultBlock {
    
    [self checkPrivacyisShowAlert:NO
                systemPrivacyType:type
                   resultCallBack:resultBlock
                   cancelCallBack:nil];
}

- (void)checkPrivacyEnableWithAlert:(SystemPrivacy)type
                     resultCallBack:(void (^)(BOOL))resultBlock {
    
    [self checkPrivacyisShowAlert:YES
                systemPrivacyType:type
                   resultCallBack:resultBlock
                   cancelCallBack:nil];
}

- (void)checkPrivacyEnableWithAlert:(SystemPrivacy)type
                         resultCallBack:(void (^)(BOOL))resultBlock
                         cancelCallBack:(void (^)(void))cancelBlock {
    
    [self checkPrivacyisShowAlert:YES
                systemPrivacyType:type
                   resultCallBack:resultBlock
                   cancelCallBack:cancelBlock];
}

#pragma mark - --- Private Function ---
- (void)checkPrivacyisShowAlert:(BOOL)isAlert
              systemPrivacyType:(SystemPrivacy)type
                 resultCallBack:(void (^)(BOOL result))resultBlock
                 cancelCallBack:(void (^)(void))cancelBlock {
    switch (type) {
        case SystemPrivacyCamera:
            resultBlock([self checkCameraPrivateWithIsAlert:isAlert cancelCallBack:cancelBlock]);
            break;
        case SystemPrivacyPhotoLibrary:
            resultBlock([self checkPhotoLibraryPrivateWithIsAlert:isAlert cancelCallBack:cancelBlock]);
            break;
        case SystemPrivacyMicrophone:
            resultBlock([self checkMicrophonePrivateWithIsAlert:isAlert cancelCallBack:cancelBlock]);
            break;
        case SystemPrivacyLocation:
            resultBlock([self checkLocatioPrivateWithIsAlert:isAlert cancelCallBack:cancelBlock]);
            break;
        case SystemPrivacyUserNotification:
            resultBlock([self checkUserNotificationPrivateWithIsAlert:isAlert cancelCallBack:cancelBlock]);
            break;
    }
}


/**
 验证相机是否可用

 @param isAlert 是否弹出提示框
 @param cancelBlock 提示框弹出的取消按钮事件
 @return 是否可用情况
 */
- (BOOL)checkCameraPrivateWithIsAlert:(BOOL)isAlert
                       cancelCallBack:(PrivacyCancelBlock)cancelBlock {
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if (authStatus == AVAuthorizationStatusDenied || authStatus == AVAuthorizationStatusRestricted) {
        if (isAlert) {
            [self showAlertControllerWithTitle:@"开启相册权限"
                                       Message:[NSString stringWithFormat:@"相机权限未开启，请进入系统【设置】>【隐私】>【相机】中打开开关，并允许%@使用相机",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]]
                            confirmActionTitle:@"立即前往"
                             cancelActionTitle:@"取消" cancelBlock:^{
                                 if (cancelBlock) {
                                     cancelBlock();
                                 }
                             }];
        }
        return NO;
    } else {
        return YES;
    }
}

/**
 验证相册是否可用
 
 @param isAlert 是否弹出提示框
 @param cancelBlock 提示框弹出的取消按钮事件
 @return 是否可用情况
 */
- (BOOL)checkPhotoLibraryPrivateWithIsAlert:(BOOL)isAlert
                             cancelCallBack:(PrivacyCancelBlock)cancelBlock {
    
    PHAuthorizationStatus author = [PHPhotoLibrary authorizationStatus];
    if (author == PHAuthorizationStatusRestricted || author == PHAuthorizationStatusDenied) {
        //无权限
        if (isAlert) {
            [self showAlertControllerWithTitle:@"开启照片权限"
                                       Message:[NSString stringWithFormat:@"照片权限未开启，请进入系统【设置】>【隐私】>【照片】中打开开关，并允许%@使用照片",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]]
                            confirmActionTitle:@"立即前往"
                             cancelActionTitle:@"取消" cancelBlock:^{
                                 if (cancelBlock) {
                                     cancelBlock();
                                 }
                                 
                             }];
        }
        
        return NO;
    }else {
        return YES;
    }
}

/**
 验证麦克风是否可用
 
 @param isAlert 是否弹出提示框
 @param cancelBlock 提示框弹出的取消按钮事件
 @return 是否可用情况
 */
- (BOOL)checkMicrophonePrivateWithIsAlert:(BOOL)isAlert
                           cancelCallBack:(PrivacyCancelBlock)cancelBlock {
    
    AVAudioSessionRecordPermission permissionStatus = [[AVAudioSession sharedInstance] recordPermission];
    switch (permissionStatus) {
        case AVAudioSessionRecordPermissionUndetermined: {
            //第一次调用
            __block BOOL isGranted = NO;
            [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
                if (granted) {
                    isGranted = NO;
                } else {
                    isGranted = NO;
                }
            }];
            return isGranted;
        }
        case AVAudioSessionRecordPermissionDenied:
            //已经拒绝麦克风k弹框
            if (isAlert) {
                [self showAlertControllerWithTitle:@"开启麦克风权限"
                                           Message:[NSString stringWithFormat:@"麦克风权限未开启，请进入系统【设置】>【隐私】>【麦克风】中打开开关，并允许%@使用麦克风",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]]
                                confirmActionTitle:@"立即前往"
                                 cancelActionTitle:@"取消" cancelBlock:^{
                                     if (cancelBlock) {
                                         cancelBlock();
                                     }
                                 }];
            }
            return NO;
        case AVAudioSessionRecordPermissionGranted:
            //已允许
            return YES;
        default:
            return YES;
    }
    
}

/**
 验证定位是否可用
 
 @param isAlert 是否弹出提示框
 @param cancelBlock 提示框弹出的取消按钮事件
 @return 是否可用情况
 */
- (BOOL)checkLocatioPrivateWithIsAlert:(BOOL)isAlert
                        cancelCallBack:(PrivacyCancelBlock)cancelBlock {
    BOOL isEnable = [CLLocationManager locationServicesEnabled];
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (!isEnable || status == kCLAuthorizationStatusRestricted || status == kCLAuthorizationStatusDenied) {
        if (isAlert) {
            [self showAlertControllerWithTitle:@"开启定位权限"
                                       Message:[NSString stringWithFormat:@"麦克风权限未开启，请进入系统【设置】>【隐私】>【定位服务】中打开开关，并允许%@使用定位服务",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]]
                            confirmActionTitle:@"立即前往"
                             cancelActionTitle:@"取消" cancelBlock:^{
                                 if (cancelBlock) {
                                     cancelBlock();
                                 }
                             }];
        }
        
        return NO;
    } else {
        return YES;
    }
}

/**
 验证通知是否可用
 
 @param isAlert 是否弹出提示框
 @param cancelBlock 提示框弹出的取消按钮事件
 @return 是否可用情况
 */
- (BOOL)checkUserNotificationPrivateWithIsAlert:(BOOL)isAlert
                                 cancelCallBack:(PrivacyCancelBlock)cancelBlock {
    __block BOOL isGranted = NO;
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                isGranted = YES;
            } else {
                if (isAlert) {
                    [self showAlertControllerWithTitle:@"开启定位权限"
                                               Message:[NSString stringWithFormat:@"麦克风权限未开启，请进入系统【设置】>【隐私】>【定位服务】中打开开关，并允许%@使用定位服务",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]]
                                    confirmActionTitle:@"立即前往"
                                     cancelActionTitle:@"取消" cancelBlock:^{
                                         if (cancelBlock) {
                                             cancelBlock();
                                         }
                                     }];
                }
                
                isGranted = NO;
            }
        }];
    } else {
        if ([[UIApplication sharedApplication] currentUserNotificationSettings].types <= UIUserNotificationTypeNone) {
            if (isAlert) {
                [self showAlertControllerWithTitle:@"开启定位权限"
                                           Message:[NSString stringWithFormat:@"麦克风权限未开启，请进入系统【设置】>【隐私】>【定位服务】中打开开关，并允许%@使用定位服务",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]]
                                confirmActionTitle:@"立即前往"
                                 cancelActionTitle:@"取消" cancelBlock:^{
                                     if (cancelBlock) {
                                         cancelBlock();
                                     }
                                 }];
            }
            isGranted = NO;
        } else {
            isGranted = YES;
        }
    }
    return isGranted;
}


- (void)showAlertControllerWithTitle:(NSString *)title
                             Message:(NSString *)message
                  confirmActionTitle:(NSString *)confirmTitle
                   cancelActionTitle:(NSString *)cancelTitle
                         cancelBlock:(PrivacyCancelBlock)cancelBlock {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle.length > 0 ? cancelTitle : @"拒绝" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancelBlock) {
            cancelBlock();
        }
    }];
    [alert addAction:cancelAction];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:confirmTitle.length > 0 ? confirmTitle : @"允许" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
    }];
    [alert addAction:alertAction];
    
    UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    [rootViewController presentViewController:alert animated:YES completion:nil];
}

@end
