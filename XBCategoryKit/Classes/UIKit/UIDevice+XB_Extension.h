//
//  UIDevice+Type.h
//  Pods-XBCategoryKit_Example
//
//  Created by Xinbo Hong on 2018/11/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger, Phone){
    PhoneUnknown,
    Phone4,
    Phone4s,
    Phone5,
    Phone5c,
    Phone5s,
    Phone6,
    Phone6Plus,
    Phone6s,
    Phone6sPlus,
    Phone7,
    Phone7Plus,
    PhoneSE,
    //2017年9月发布，更新三种机型：iPhone 8、iPhone 8 Plus、iPhone X
    Phone8,
    Phone8Plus,
    PhoneX,
    //2018年10月发布，更新三种机型：iPhone XR、iPhone XS、iPhone XS Max
    PhoneXs,
    PhoneXsMax,
    PhoneXr,
    //2019年9月发布，更新三种机型：iPhone 11、iPhone 11 Pro、iPhone 11 Pro Max
    Phone11,
    Phone11Pro,
    Phone11ProMax,
};

typedef NS_ENUM(NSInteger, Pad){
    PadUnknown,
    Pad2,
    PadMini,
    Pad3,
    Pad4,
    PadAir,
    PadMini2,
    PadMini3,
    PadMini4,
    PadAir2,
    PadPro9Inch,
    PadPro12Inch,
    Pad5,
    PadPro12Inch2,
    PadPro10Inch,
    Pad6,
    //2019年3月发布，更新二种机型：iPad mini5、iPad Air3
    PadMini5,
    PadAir3,

};

typedef NS_ENUM(NSInteger, Pod){
    PodUnknown,
    Pod1,
    Pod2,
    Pod3,
    Pod4,
    Pod5,
    Pod6,
    Pod7,
};




@interface UIDevice (XB_Extension)

#pragma mark - --- Info With Difference Device ---

//返回设备的详情，比如iPhone 7，iPad Mini 3
+ (NSString *)platformString;

/// 是否是模拟器
+ (BOOL)isRunningOnSimulator;

#pragma mark - --- iPhone ---
/// 是否是iPhone
+ (BOOL)isPhone;


/// 是否能够面部识别
+ (BOOL)hasFaceIDInPhone;


/// 是否能够指纹识别

+ (BOOL)hasTouchIDInPhone;


/// 是否是iPhone真机
+ (BOOL)isRunningOnPhone;


/// 是否是小尺寸设备（3.7/4）
+ (BOOL)isSmallSizedPhone;


/// 是否是普通设备（4.7）
+ (BOOL)isDefaultSizedPhone;


/// 是否是Plus或大尺寸系列设备(>4.7）
+ (BOOL)isPlusSizedPhone;

/// 是否是iPhone X系列设备
+ (BOOL)isXSeriesSizedPhone;

/// 屏幕对角尺寸
+ (CGFloat)diagonalWithPhone;

/// 屏幕比例
+ (CGSize)screenRatioWithPhone;

/// 屏幕ppi
+ (NSInteger)ppiWithPhone;

#pragma mark - --- iPad ---
/// 是否是iPad
+ (BOOL)isPad;

/// 是否是iPad真机
+ (BOOL)isRunningOnPad;

/// 屏幕对角尺寸
+ (CGFloat)diagonalWithPad;

/// 屏幕比例
+ (CGSize)screenRatioWithPad;

/// 屏幕ppi
+ (NSInteger)ppiWithPad;
#pragma mark - --- iTouch ---

/// 是否是iPod
+ (BOOL)isPod;

/// 是否是iPod真机
+ (BOOL)isRunningOnPod;
#pragma mark - --- 获取设备信息 ---
/// mac地址
+ (NSString *)macAddress;


/// 是否有摄像头
+ (BOOL)hasCamera;


/// 获取手机可用内存, 返回的是字节数
+ (NSUInteger)freeMemoryBytes;


/// 获取手机硬盘总空间, 返回的是字节数
+ (NSUInteger)totalDiskSpaceBytes;


/// 获取手机硬盘空闲空间, 返回的是字节数
+ (NSUInteger)freeDiskSpaceBytes;


/// 可用硬件容量
+ (CGFloat)usableHardDriveCapacity;


/// 硬件总容量
+ (CGFloat)allHardDriveCapacity;
@end

NS_ASSUME_NONNULL_END
