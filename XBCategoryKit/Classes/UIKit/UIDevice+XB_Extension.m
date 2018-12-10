//
//  UIDevice+Type.m
//  Pods-XBCategoryKit_Example
//
//  Created by Xinbo Hong on 2018/11/9.
//

#import "UIDevice+XB_Extension.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import <sys/socket.h>
#import <sys/param.h>
#import <sys/mount.h>
#import <sys/stat.h>
#import <sys/utsname.h>
#import <net/if.h>
#import <net/if_dl.h>
#import <mach/mach.h>
#import <mach/mach_host.h>
#import <mach/processor_info.h>
#import <DeviceCheck/DeviceCheck.h>
@implementation UIDevice (XB_Extension)


#pragma mark --- Info With Difference Device ---

+ (Device)deviceFromDeviceIdentifier:(NSString *)platform {
    /** iPod*/
    if ([@[@"iPod5,1"] containsObject:platform])  return DeviceiPodTouch5;
    if ([@[@"iPod7,1"] containsObject:platform])  return DeviceiPodTouch6;
    /** iPhone*/
    if ([@[@"iPhone3,1", @"iPhone3,2", @"iPhone3,3"] containsObject:platform]) return DeviceiPhone4;
    if ([@[@"iPhone4,1"] containsObject:platform])  return DeviceiPhone4s;
    if ([@[@"iPhone5,1", @"iPhone5,2"] containsObject:platform]) return DeviceiPhone5;
    if ([@[@"iPhone5,3", @"iPhone5,4"] containsObject:platform]) return DeviceiPhone5c;
    if ([@[@"iPhone6,1", @"iPhone6,2"] containsObject:platform]) return DeviceiPhone5s;
    if ([@[@"iPhone7,2"] containsObject:platform])  return DeviceiPhone6;
    if ([@[@"iPhone7,1"] containsObject:platform])  return DeviceiPhone6Plus;
    if ([@[@"iPhone8,1"] containsObject:platform])  return DeviceiPhone6s;
    if ([@[@"iPhone8,2"] containsObject:platform])  return DeviceiPhone6sPlus;
    if ([@[@"iPhone9,1", @"iPhone9,3"] containsObject:platform]) return DeviceiPhone7;
    if ([@[@"iPhone9,2", @"iPhone9,4"] containsObject:platform]) return DeviceiPhone7Plus;
    if ([@[@"iPhone8,4"] containsObject:platform])  return DeviceiPhoneSE;
    if ([@[@"iPhone10,1", @"iPhone10,4"] containsObject:platform]) return DeviceiPhone8;
    if ([@[@"iPhone10,2", @"iPhone10,5"] containsObject:platform]) return DeviceiPhone8Plus;
    if ([@[@"iPhone10,3", @"iPhone10,6"] containsObject:platform]) return DeviceiPhoneX;
    if ([@[@"iPhone11,2"] containsObject:platform])  return DeviceiPhoneXs;
    if ([@[@"iPhone11,4", @"iPhone11,6"] containsObject:platform]) return DeviceiPhoneXsMax;
    if ([@[@"iPhone11,8"] containsObject:platform])  return DeviceiPhoneXr;
    /** iPad*/
    if ([@[@"iPad2,1", @"iPad2,2", @"iPad2,3", @"iPad2,4"] containsObject:platform]) return DeviceiPad2;
    if ([@[@"iPad3,1", @"iPad3,2", @"iPad3,3"] containsObject:platform]) return DeviceiPad3;
    if ([@[@"iPad3,4", @"iPad3,5", @"iPad3,6"] containsObject:platform]) return DeviceiPad4;
    if ([@[@"iPad4,1", @"iPad4,2", @"iPad4,3"] containsObject:platform]) return DeviceiPadAir;
    if ([@[@"iPad5,3", @"iPad5,4"] containsObject:platform]) return DeviceiPadAir2;
    if ([@[@"iPad6,11", @"iPad6,12"] containsObject:platform]) return DeviceiPad5;
    if ([@[@"iPad7,5", @"iPad7,6"] containsObject:platform]) return DeviceiPad6;
    if ([@[@"iPad2,5", @"iPad2,6", @"iPad2,7"] containsObject:platform]) return DeviceiPadMini;
    if ([@[@"iPad4,4", @"iPad4,5", @"iPad4,6"] containsObject:platform]) return DeviceiPadMini2;
    if ([@[@"iPad4,7", @"iPad4,8", @"iPad4,9"] containsObject:platform]) return DeviceiPadMini3;
    if ([@[@"iPad5,1", @"iPad5,2"] containsObject:platform]) return DeviceiPadMini4;
    if ([@[@"iPad6,3", @"iPad6,4"] containsObject:platform]) return DeviceiPadPro9Inch;
    if ([@[@"iPad6,7", @"iPad6,8"] containsObject:platform]) return DeviceiPadPro12Inch;
    if ([@[@"iPad7,1", @"iPad7,2"] containsObject:platform]) return DeviceiPadPro12Inch2;
    if ([@[@"iPad7,3", @"iPad7,4"] containsObject:platform]) return DeviceiPadPro10Inch;
    
    
    if ([@[@"i386", @"x86_64"] containsObject:platform]) {
        NSString *temp = [NSProcessInfo processInfo].environment[@"SIMULATOR_MODEL_IDENTIFIER"];
        [UIDevice deviceFromDeviceIdentifier:temp];
    }
    
    return DeviceUnknown;
}

+ (Device)xb_currentDevice {
    return [UIDevice deviceFromDeviceIdentifier:[UIDevice platformWithCurrentDevice]];
}


+ (CGFloat)diagonalWithDevice {
    Device temp = [UIDevice xb_currentDevice];
    switch (temp) {
        case DeviceiPodTouch5: return 4.0;
        case DeviceiPodTouch6: return 4.0;
        case DeviceiPhone4: return 3.5;
        case DeviceiPhone4s: return 3.5;
        case DeviceiPhone5: return 4.0;
        case DeviceiPhone5c: return 4.0;
        case DeviceiPhone5s: return 4.0;
        case DeviceiPhone6: return 4.7;
        case DeviceiPhone6Plus: return 5.5;
        case DeviceiPhone6s: return 4.7;
        case DeviceiPhone6sPlus: return 5.5;
        case DeviceiPhone7: return 4.7;
        case DeviceiPhone7Plus: return 5.5;
        case DeviceiPhoneSE: return 4.0;
        case DeviceiPhone8: return 4.7;
        case DeviceiPhone8Plus: return 5.5;
        case DeviceiPhoneX: return 5.8;
        case DeviceiPhoneXs: return 5.8;
        case DeviceiPhoneXsMax: return 6.5;
        case DeviceiPhoneXr: return 6.1;
        case DeviceiPad2: return 9.7;
        case DeviceiPad3: return 9.7;
        case DeviceiPad4: return 9.7;
        case DeviceiPadAir: return 9.7;
        case DeviceiPadAir2: return 9.7;
        case DeviceiPad5: return 9.7;
        case DeviceiPad6: return 9.7;
        case DeviceiPadMini: return 7.9;
        case DeviceiPadMini2: return 7.9;
        case DeviceiPadMini3: return 7.9;
        case DeviceiPadMini4: return 7.9;
        case DeviceiPadPro9Inch: return 9.7;
        case DeviceiPadPro12Inch: return 12.9;
        case DeviceiPadPro12Inch2: return 12.9;
        case DeviceiPadPro10Inch: return 10.5;
        case DeviceSimulator: return -1.0;
        case DeviceUnknown: return -1.0;
    }
}

+ (CGSize)screenRatioWithDevice {
    Device temp = [UIDevice xb_currentDevice];
    switch (temp) {
        case DeviceiPodTouch5: return CGSizeMake(9, 16);
        case DeviceiPodTouch6: return CGSizeMake(9, 16);
        case DeviceiPhone4: return CGSizeMake(2, 3);
        case DeviceiPhone4s: return CGSizeMake(2, 3);
        case DeviceiPhone5: return CGSizeMake(9, 16);
        case DeviceiPhone5c: return CGSizeMake(9, 16);
        case DeviceiPhone5s: return CGSizeMake(9, 16);
        case DeviceiPhone6: return CGSizeMake(9, 16);
        case DeviceiPhone6Plus: return CGSizeMake(9, 16);
        case DeviceiPhone6s: return CGSizeMake(9, 16);
        case DeviceiPhone6sPlus: return CGSizeMake(9, 16);
        case DeviceiPhone7: return CGSizeMake(9, 16);
        case DeviceiPhone7Plus: return CGSizeMake(9, 16);
        case DeviceiPhoneSE: return CGSizeMake(9, 16);
        case DeviceiPhone8: return CGSizeMake(9, 16);
        case DeviceiPhone8Plus: return CGSizeMake(9, 16);
        case DeviceiPhoneX: return CGSizeMake(9, 19.5);
        case DeviceiPhoneXs: return CGSizeMake(9, 19.5);
        case DeviceiPhoneXsMax: return CGSizeMake(9, 19.5);
        case DeviceiPhoneXr: return CGSizeMake(9, 19.5);
        case DeviceiPad2: return CGSizeMake(3, 4);
        case DeviceiPad3: return CGSizeMake(3, 4);
        case DeviceiPad4: return CGSizeMake(3, 4);
        case DeviceiPadAir: return CGSizeMake(3, 4);
        case DeviceiPadAir2: return CGSizeMake(3, 4);
        case DeviceiPad5: return CGSizeMake(3, 4);
        case DeviceiPad6: return CGSizeMake(3, 4);
        case DeviceiPadMini: return CGSizeMake(3, 4);
        case DeviceiPadMini2: return CGSizeMake(3, 4);
        case DeviceiPadMini3: return CGSizeMake(3, 4);
        case DeviceiPadMini4: return CGSizeMake(3, 4);
        case DeviceiPadPro9Inch: return CGSizeMake(3, 4);
        case DeviceiPadPro12Inch: return CGSizeMake(3, 4);
        case DeviceiPadPro12Inch2: return CGSizeMake(3, 4);
        case DeviceiPadPro10Inch: return CGSizeMake(3, 4);
        case DeviceSimulator: return CGSizeMake(-1, -1);
        case DeviceUnknown: return CGSizeMake(-1, -1);
    }
}

+ (NSInteger)ppiWithDevice {
    
    Device temp = [UIDevice xb_currentDevice];
    switch (temp) {
        case DeviceiPodTouch5: return 326;
        case DeviceiPodTouch6: return 326;
        case DeviceiPhone4: return 326;
        case DeviceiPhone4s: return 326;
        case DeviceiPhone5: return 326;
        case DeviceiPhone5c: return 326;
        case DeviceiPhone5s: return 326;
        case DeviceiPhone6: return 326;
        case DeviceiPhone6Plus: return 401;
        case DeviceiPhone6s: return 326;
        case DeviceiPhone6sPlus: return 401;
        case DeviceiPhone7: return 326;
        case DeviceiPhone7Plus: return 401;
        case DeviceiPhoneSE: return 326;
        case DeviceiPhone8: return 326;
        case DeviceiPhone8Plus: return 401;
        case DeviceiPhoneX: return 458;
        case DeviceiPhoneXs: return 458;
        case DeviceiPhoneXsMax: return 458;
        case DeviceiPhoneXr: return 326;
        case DeviceiPad2: return 132;
        case DeviceiPad3: return 264;
        case DeviceiPad4: return 264;
        case DeviceiPadAir: return 264;
        case DeviceiPadAir2: return 264;
        case DeviceiPad5: return 264;
        case DeviceiPad6: return 264;
        case DeviceiPadMini: return 163;
        case DeviceiPadMini2: return 326;
        case DeviceiPadMini3: return 326;
        case DeviceiPadMini4: return 326;
        case DeviceiPadPro9Inch: return 264;
        case DeviceiPadPro12Inch: return 264;
        case DeviceiPadPro12Inch2: return 264;
        case DeviceiPadPro10Inch: return 264;
        case DeviceSimulator: return -1;
        case DeviceUnknown: return -1;
    }
}

+ (NSString *)descriptionWithDevice {
    Device temp = [UIDevice xb_currentDevice];
    switch (temp) {
        case DeviceiPodTouch5: return @"iPod Touch 5";
        case DeviceiPodTouch6: return @"iPod Touch 6";
        case DeviceiPhone4: return @"iPhone4";
        case DeviceiPhone4s: return @"iPhone4s";
        case DeviceiPhone5: return @"iPhone5";
        case DeviceiPhone5c: return @"iPhone5c";
        case DeviceiPhone5s: return @"iPhone5s";
        case DeviceiPhone6: return @"iPhone6";
        case DeviceiPhone6Plus: return @"iPhone6Plus";
        case DeviceiPhone6s: return @"iPhone6s";
        case DeviceiPhone6sPlus: return @"iPhone6sPlus";
        case DeviceiPhone7: return @"iPhone7";
        case DeviceiPhone7Plus: return @"iPhone7Plus";
        case DeviceiPhoneSE: return @"iPhoneSE";
        case DeviceiPhone8: return @"iPhone8";
        case DeviceiPhone8Plus: return @"iPhone8Plus";
        case DeviceiPhoneX: return @"iPhoneX";
        case DeviceiPhoneXs: return @"iPhoneXs";
        case DeviceiPhoneXsMax: return @"iPhoneXsMax";
        case DeviceiPhoneXr: return @"iPhoneXr";
        case DeviceiPad2: return @"iPad2";
        case DeviceiPad3: return @"iPad35";
        case DeviceiPad4: return @"iPad4";
        case DeviceiPadAir: return @"iPadAir";
        case DeviceiPadAir2: return @"iPadAir2";
        case DeviceiPad5: return @"iPad5";
        case DeviceiPad6: return @"iPad6";
        case DeviceiPadMini: return @"iPadMini";
        case DeviceiPadMini2: return @"iPadMini2";
        case DeviceiPadMini3: return @"iPadMini3";
        case DeviceiPadMini4: return @"iPadMini4";
        case DeviceiPadPro9Inch: return @"iPadPro9Inch";
        case DeviceiPadPro12Inch: return @"iPadPro12Inch";
        case DeviceiPadPro12Inch2: return @"iPadPro12Inch2";
        case DeviceiPadPro10Inch: return @"iPadPro10Inch";
        case DeviceSimulator: return @"Simulator";
        case DeviceUnknown: return @"Unknown";
    }
}

#pragma mark --- is Kinds of the Device ---
+ (BOOL)isPod {
    Device temp = [UIDevice xb_currentDevice];
    if (temp >= DeviceiPodTouch5 && temp <= DeviceiPodTouch6) {
        return true;
    } else {
        return false;
    }
}

+ (BOOL)isPhone {
    Device temp = [UIDevice xb_currentDevice];
    if (temp >= DeviceiPhone4 && temp <= DeviceiPhoneXr) {
        return true;
    } else {
        return false;
    }
}


+ (BOOL)isPad {
    Device temp = [UIDevice xb_currentDevice];
    if (temp >= DeviceiPad2 && temp <= DeviceiPadPro10Inch) {
        return true;
    } else {
        return false;
    }
}

+ (BOOL)isCanFaceID {
    Device temp = [UIDevice xb_currentDevice];
    if (temp == DeviceiPhoneX ||
        temp == DeviceiPhoneXs ||
        temp == DeviceiPhoneXsMax ||
        temp == DeviceiPhoneXr) {
        return true;
    } else {
        return false;
    }
}

+ (BOOL)isCanTouchID {
    Device temp = [UIDevice xb_currentDevice];
    if (temp == DeviceiPhone5s ||
        temp == DeviceiPhone6 ||
        temp == DeviceiPhone6Plus ||
        temp == DeviceiPhone6s ||
        temp == DeviceiPhone6sPlus ||
        temp == DeviceiPhone7 ||
        temp == DeviceiPhone7Plus ||
        temp == DeviceiPhoneSE ||
        temp == DeviceiPhone8 ||
        temp == DeviceiPhone8Plus ||
        temp == DeviceiPadAir2 ||
        temp == DeviceiPad5 ||
        temp == DeviceiPad6 ||
        temp == DeviceiPadMini3 ||
        temp == DeviceiPadMini4 ||
        temp == DeviceiPadPro9Inch ||
        temp == DeviceiPadPro12Inch ||
        temp == DeviceiPadPro12Inch2 ||
        temp == DeviceiPadPro10Inch) {
        return true;
    } else {
        return false;
    }
}


//是否是iPhone真机运行
+ (BOOL)isRunningOniPhone{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
}

//3.7/4英寸的iPhone
+ (BOOL)isSmallSizedDevice {
    CGFloat diagonal = [UIDevice diagonalWithDevice];
    if (diagonal <= 4) {
        return true;
    } else {
        return false;
    }
}

//4.7英寸的iPhone
+ (BOOL)isDefaultSizedDevice {
    CGFloat diagonal = [UIDevice diagonalWithDevice];
    if (diagonal == 4.7) {
        return true;
    } else {
        return false;
    }
}

//5.5英寸的iPhone
+ (BOOL)isPlusSizedDevice {
    CGFloat diagonal = [UIDevice diagonalWithDevice];
    if (diagonal == 5.5) {
        return true;
    } else {
        return false;
    }
}

//iPhone X系列
+ (BOOL)isXSeriesSizedDevice {
    //目前就iPhone X系列有人脸识别，可以直接返回
    return [UIDevice isCanFaceID];
}

#pragma mark --- Base Info ---
+ (NSString *)platformWithCurrentDevice {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    return platform;
}

+ (NSString *)name {
    return UIDevice.currentDevice.name;
}

+ (NSString *)systemName {
    return UIDevice.currentDevice.systemName;
}

+ (NSString *)systemVersion {
    return UIDevice.currentDevice.systemVersion;
}

+ (NSString *)model {
    return UIDevice.currentDevice.model;
}

+ (NSString *)localizedModel {
    return UIDevice.currentDevice.localizedModel;
}

+ (UIDeviceOrientation)orientation {
    return UIDevice.currentDevice.orientation;
}

/** mac地址 */
+ (NSString *)macAddress {
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    mib[5] = if_nametoindex("en0");
    
    
    if (mib[5] == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. Rrror!\n");
        return NULL;
    }
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    return outString;
}

/** 是否有摄像头 */
+ (BOOL)hasCamera {
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

/** 获取手机可用内存, 返回的是字节数 */
+ (NSUInteger)freeMemoryBytes {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t pagesize;
    vm_statistics_data_t vm_stat;
    
    host_page_size(host_port, &pagesize);
    if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS) {
        return 0;
    }
    unsigned long mem_free = vm_stat.free_count * pagesize;
    return mem_free;
    
}

/** 获取手机硬盘总空间, 返回的是字节数 */
+ (NSUInteger)totalDiskSpaceBytes {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *attributes = [fileManager attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSNumber *number = attributes[NSFileSystemSize];
    return [number unsignedIntegerValue];
}

/** 获取手机硬盘空闲空间, 返回的是字节数 */
+ (NSUInteger)freeDiskSpaceBytes {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *attributes = [fileManager attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSNumber *number = attributes[NSFileSystemFreeSize];
    return [number unsignedIntegerValue];
}

+ (CGFloat)usableHardDriveCapacity {
    CGFloat usable = 0;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *attributes = [fileManager attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    usable = [attributes[NSFileSystemFreeSize] doubleValue] / powf(1024, 3);
    return usable;
}


+ (CGFloat)allHardDriveCapacity {
    CGFloat all = 0;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *attributes = [fileManager attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    all = [attributes[NSFileSystemSize] doubleValue] / (powf(1024, 3));
    return all;
}

@end
