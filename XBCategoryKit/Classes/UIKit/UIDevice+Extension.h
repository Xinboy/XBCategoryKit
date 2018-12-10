//
//  UIDevice+Type.h
//  Pods-XBCategoryKit_Example
//
//  Created by Xinbo Hong on 2018/11/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, Device){
    DeviceiPodTouch5 = 1,
    DeviceiPodTouch6,
    DeviceiPhone4,
    DeviceiPhone4s,
    DeviceiPhone5,
    DeviceiPhone5c,
    DeviceiPhone5s,
    DeviceiPhone6,
    DeviceiPhone6Plus,
    DeviceiPhone6s,
    DeviceiPhone6sPlus,
    DeviceiPhone7,
    DeviceiPhone7Plus,
    DeviceiPhoneSE,
    DeviceiPhone8,
    DeviceiPhone8Plus,
    DeviceiPhoneX,
    DeviceiPhoneXs,
    DeviceiPhoneXsMax,
    DeviceiPhoneXr,
    DeviceiPad2,
    DeviceiPad3,
    DeviceiPad4,
    DeviceiPadAir,
    DeviceiPadAir2,
    DeviceiPad5,
    DeviceiPad6,
    DeviceiPadMini,
    DeviceiPadMini2,
    DeviceiPadMini3,
    DeviceiPadMini4,
    DeviceiPadPro9Inch,
    DeviceiPadPro12Inch,
    DeviceiPadPro12Inch2,
    DeviceiPadPro10Inch,
    DeviceSimulator,
    DeviceUnknown,
};

@interface UIDevice (Extension)

#pragma mark - --- Info With Difference Device ---
+ (Device)deviceFromDeviceIdentifier:(NSString *)platform;

+ (Device)currentDevice;

/**
 屏幕对角尺寸
 */
+ (CGFloat)diagonalWithDevice;

/**
 屏幕比例
 */
+ (CGSize)screenRatioWithDevice;

/**
 屏幕ppi
 */
+ (NSInteger)ppiWithDevice;

/**
 设备描述
 */
+ (NSString *)descriptionWithDevice;

/**
 是否是iPod
 */
+ (BOOL)isPod;

/**
 是否是iPhone
 */
+ (BOOL)isPhone;

/**
 是否是iPad
 */
+ (BOOL)isPad;

/**
 是否能够面部识别
 */
+ (BOOL)isCanFaceID;

/**
 是否能够指纹识别
 */
+ (BOOL)isCanTouchID;

/**
 是否是真机
 */
+ (BOOL)isRunningOniPhone;

/**
 是否是小尺寸设备（3.7/4）
 */
+ (BOOL)isSmallSizedDevice;

/**
 是否是普通设备（4.7）
 */
+ (BOOL)isDefaultSizedDevice;

/**
 是否是Plus系列设备（5.5）
 */
+ (BOOL)isPlusSizedDevice;

/**
 是否是iPhone X系列设备
 */
+ (BOOL)isXSeriesSizedDevice;

#pragma mark - --- 获取设备信息 ---
/**
 mac地址
 */
+ (NSString *)macAddress;

/**
 是否有摄像头
 */
+ (BOOL)hasCamera;

/**
 获取手机可用内存, 返回的是字节数
 */
+ (NSUInteger)freeMemoryBytes;

/**
 获取手机硬盘总空间, 返回的是字节数
 */
+ (NSUInteger)totalDiskSpaceBytes;

/**
 获取手机硬盘空闲空间, 返回的是字节数
 */
+ (NSUInteger)freeDiskSpaceBytes;

/**
 可用硬件容量
 */
+ (CGFloat)usableHardDriveCapacity;

/**
 硬件总容量

 */
+ (CGFloat)allHardDriveCapacity;
@end

NS_ASSUME_NONNULL_END
