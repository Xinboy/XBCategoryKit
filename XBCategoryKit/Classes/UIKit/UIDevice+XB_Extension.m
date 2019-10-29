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

+ (NSString *)platformString {
    
    NSString *platform = [UIDevice platform];
    
    if ([UIDevice isPhone]) {
        return [UIDevice iPhoneDescription:platform];
    }
    
    if ([UIDevice isPad]) {
        return [UIDevice iPadDescription:platform];
    }
    
    if ([UIDevice isPod]) {
        return [UIDevice iPodDescription:platform];
    }

    if ([platform isEqualToString:@"i386"])             return @"Simulator";//模拟器
    if ([platform isEqualToString:@"x86_64"])        return @"Simulator";//模拟器
    
    return @"Unknown iOS Device";
}

+ (BOOL)isRunningOnSimulator {
    if ([[UIDevice platform] isEqualToString:@"Simulator"]) {
        return YES;
    } else {
        return NO;
    }
}


#pragma mark --- iPhone ---
+ (Phone)iPhonePlatform:(NSString *)platform {
    if ([@[@"iPhone3,1", @"iPhone3,2", @"iPhone3,3"] containsObject:platform]) return Phone4;
    if ([@[@"iPhone4,1"] containsObject:platform])  return Phone4s;
    if ([@[@"iPhone5,1", @"iPhone5,2"] containsObject:platform]) return Phone5;
    if ([@[@"iPhone5,3", @"iPhone5,4"] containsObject:platform]) return Phone5c;
    if ([@[@"iPhone6,1", @"iPhone6,2"] containsObject:platform]) return Phone5s;
    if ([@[@"iPhone7,2"] containsObject:platform])  return Phone6;
    if ([@[@"iPhone7,1"] containsObject:platform])  return Phone6Plus;
    if ([@[@"iPhone8,1"] containsObject:platform])  return Phone6s;
    if ([@[@"iPhone8,2"] containsObject:platform])  return Phone6sPlus;
    if ([@[@"iPhone9,1", @"iPhone9,3"] containsObject:platform]) return Phone7;
    if ([@[@"iPhone9,2", @"iPhone9,4"] containsObject:platform]) return Phone7Plus;
    if ([@[@"iPhone8,4"] containsObject:platform])  return PhoneSE;
    //2017年9月发布，更新三种机型：iPhone 8、iPhone 8 Plus、iPhone X
    if ([@[@"iPhone10,1", @"iPhone10,4"] containsObject:platform]) return Phone8;
    if ([@[@"iPhone10,2", @"iPhone10,5"] containsObject:platform]) return Phone8Plus;
    if ([@[@"iPhone10,3", @"iPhone10,6"] containsObject:platform]) return PhoneX;
    //2018年10月发布，更新三种机型：iPhone XR、iPhone XS、iPhone XS Max
    if ([@[@"iPhone11,2"] containsObject:platform])  return PhoneXs;
    if ([@[@"iPhone11,4", @"iPhone11,6"] containsObject:platform]) return PhoneXsMax;
    if ([@[@"iPhone11,8"] containsObject:platform])  return PhoneXr;
    //2019年9月发布，更新三种机型：iPhone 11、iPhone 11 Pro、iPhone 11 Pro Max
    if ([@[@"iPhone12,1"] containsObject:platform])  return Phone11;
    if ([@[@"iPhone12,3"] containsObject:platform]) return Phone11Pro;
    if ([@[@"iPhone12,5"] containsObject:platform])  return Phone11ProMax;
    
    return PhoneUnknown;
}

+ (NSString *)iPhoneDescription:(NSString *)platform {
    Phone temp = [UIDevice iPhonePlatform:platform];
    switch (temp) {
        case Phone4: return @"iPhone4";
        case Phone4s: return @"iPhone4s";
        case Phone5: return @"iPhone5";
        case Phone5c: return @"iPhone5c";
        case Phone5s: return @"iPhone5s";
        case Phone6: return @"iPhone6";
        case Phone6Plus: return @"iPhone6Plus";
        case Phone6s: return @"iPhone6s";
        case Phone6sPlus: return @"iPhone6sPlus";
        case Phone7: return @"iPhone7";
        case Phone7Plus: return @"iPhone7Plus";
        case PhoneSE: return @"iPhoneSE";
        case Phone8: return @"iPhone8";
        case Phone8Plus: return @"iPhone8Plus";
        case PhoneX: return @"iPhoneX";
        case PhoneXs: return @"iPhoneXs";
        case PhoneXsMax: return @"iPhoneXsMax";
        case PhoneXr: return @"iPhoneXr";
        case Phone11: return @"iPhone11";
        case Phone11Pro: return @"iPhone11Pro";
        case Phone11ProMax: return @"iPhone11ProMax";
        case PhoneUnknown: return @"Unknown";
    }
}


+ (BOOL)isPhone {
    NSString *platform = [UIDevice platform];
    
    if([platform rangeOfString:@"iPhone"].location != NSNotFound){
        return YES;
    } else {
        return NO;
    }
}

//是否是iPhone真机运行
+ (BOOL)isRunningOnPhone{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
}

+ (CGFloat)diagonalWithPhone {
    Phone temp = [UIDevice iPhonePlatform:[UIDevice platform]];
    switch (temp) {
        case Phone4: return 3.5;
        case Phone4s: return 3.5;
        case Phone5: return 4.0;
        case Phone5c: return 4.0;
        case Phone5s: return 4.0;
        case Phone6: return 4.7;
        case Phone6Plus: return 5.5;
        case Phone6s: return 4.7;
        case Phone6sPlus: return 5.5;
        case Phone7: return 4.7;
        case Phone7Plus: return 5.5;
        case PhoneSE: return 4.0;
        case Phone8: return 4.7;
        case Phone8Plus: return 5.5;
        case PhoneX: return 5.8;
        case PhoneXs: return 5.8;
        case PhoneXsMax: return 6.5;
        case PhoneXr: return 6.1;
        case Phone11: return 6.1;
        case Phone11Pro: return 5.8;
        case Phone11ProMax: return 6.5;
        default: return -1;
    }
}

+ (CGSize)screenRatioWithPhone {
    Phone temp = [UIDevice iPhonePlatform:[UIDevice platform]];
    switch (temp) {
        case Phone4: return CGSizeMake(2, 3);
        case Phone4s: return CGSizeMake(2, 3);
        case Phone5: return CGSizeMake(9, 16);
        case Phone5c: return CGSizeMake(9, 16);
        case Phone5s: return CGSizeMake(9, 16);
        case Phone6: return CGSizeMake(9, 16);
        case Phone6Plus: return CGSizeMake(9, 16);
        case Phone6s: return CGSizeMake(9, 16);
        case Phone6sPlus: return CGSizeMake(9, 16);
        case Phone7: return CGSizeMake(9, 16);
        case Phone7Plus: return CGSizeMake(9, 16);
        case PhoneSE: return CGSizeMake(9, 16);
        case Phone8: return CGSizeMake(9, 16);
        case Phone8Plus: return CGSizeMake(9, 16);
        case PhoneX: return CGSizeMake(9, 19.5);
        case PhoneXs: return CGSizeMake(9, 19.5);
        case PhoneXsMax: return CGSizeMake(9, 19.5);
        case PhoneXr: return CGSizeMake(9, 19.5);
        case Phone11: return CGSizeMake(9, 19.5);
        case Phone11Pro: return CGSizeMake(9, 19.5);
        case Phone11ProMax: return CGSizeMake(9, 19.5);
        case PhoneUnknown: return CGSizeMake(-1, -1);
    }
}

+ (NSInteger)ppiWithPhone {
    Phone temp = [UIDevice iPhonePlatform:[UIDevice platform]];
    switch (temp) {
        case Phone4: return 326;
        case Phone4s: return 326;
        case Phone5: return 326;
        case Phone5c: return 326;
        case Phone5s: return 326;
        case Phone6: return 326;
        case Phone6Plus: return 401;
        case Phone6s: return 326;
        case Phone6sPlus: return 401;
        case Phone7: return 326;
        case Phone7Plus: return 401;
        case PhoneSE: return 326;
        case Phone8: return 326;
        case Phone8Plus: return 401;
        case PhoneX: return 458;
        case PhoneXs: return 458;
        case PhoneXsMax: return 458;
        case PhoneXr: return 326;
        case Phone11: return 326;
        case Phone11Pro: return 458;
        case Phone11ProMax: return 458;
        case PhoneUnknown: return -1;
    }
}
//3.7/4英寸的iPhone
+ (BOOL)isSmallSizedPhone {
    CGFloat diagonal = [UIDevice diagonalWithPhone];
    if (diagonal <= 4 && diagonal > 0) {
        return true;
    } else {
        return false;
    }
}

//4.7英寸的iPhone
+ (BOOL)isDefaultSizedPhone {
    CGFloat diagonal = [UIDevice diagonalWithPhone];
    if (diagonal == 4.7) {
        return true;
    } else {
        return false;
    }
}

//5.5英寸的iPhone
+ (BOOL)isPlusSizedPhone {
    CGFloat diagonal = [UIDevice diagonalWithPhone];
    if (diagonal > 4.7) {
        return true;
    } else {
        return false;
    }
}

+ (BOOL)hasTouchIDInPhone {
    Phone iphone = [UIDevice iPhonePlatform:[UIDevice platform]];
    if (iphone >= Phone5s && iphone <= Phone8Plus) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)hasFaceIDInPhone {
    Phone iphone = [UIDevice iPhonePlatform:[UIDevice platform]];
    if (iphone >= PhoneX) {
        return YES;
    } else {
        return NO;
    }
}
//iPhone X系列
+ (BOOL)isXSeriesSizedDevice {
    //目前就iPhone X系列有人脸识别，可以直接返回
    return [UIDevice hasFaceIDInPhone];
}
#pragma mark --- iPad ---
+ (Pad)iPadPlatform:(NSString *)platform {
    
    if ([@[@"iPad2,1", @"iPad2,2", @"iPad2,3", @"iPad2,4"] containsObject:platform]) return Pad2;
    if ([@[@"iPad2,5", @"iPad2,6", @"iPad2,7"] containsObject:platform]) return PadMini;
    if ([@[@"iPad3,1", @"iPad3,2", @"iPad3,3"] containsObject:platform]) return Pad3;
    if ([@[@"iPad3,4", @"iPad3,5", @"iPad3,6"] containsObject:platform]) return Pad4;
    if ([@[@"iPad4,1", @"iPad4,2", @"iPad4,3"] containsObject:platform]) return PadAir;
    if ([@[@"iPad4,4", @"iPad4,5", @"iPad4,6"] containsObject:platform]) return PadMini2;
    if ([@[@"iPad4,7", @"iPad4,8", @"iPad4,9"] containsObject:platform]) return PadMini3;
    if ([@[@"iPad5,1", @"iPad5,2"] containsObject:platform]) return PadMini4;
    if ([@[@"iPad5,3", @"iPad5,4"] containsObject:platform]) return PadAir2;
    if ([@[@"iPad6,3", @"iPad6,4"] containsObject:platform]) return PadPro9Inch;
    if ([@[@"iPad6,7", @"iPad6,8"] containsObject:platform]) return PadPro12Inch;
    if ([@[@"iPad6,11", @"iPad6,12"] containsObject:platform]) return Pad5;
    if ([@[@"iPad7,1", @"iPad7,2"] containsObject:platform]) return PadPro12Inch2;
    if ([@[@"iPad7,3", @"iPad7,4"] containsObject:platform]) return PadPro10Inch;
    if ([@[@"iPad7,5", @"iPad7,6"] containsObject:platform]) return Pad6;
    if ([@[@"iPad11,1", @"iPad11,2"] containsObject:platform]) return PadMini5;
    if ([@[@"iPad11,3", @"iPad11,4"] containsObject:platform]) return PadAir3;
    return PadUnknown;
}


+ (NSString *)iPadDescription:(NSString *)platform {
    
    if([platform isEqualToString:@"iPad1,1"])   return @"iPad";
    if([platform isEqualToString:@"iPad1,2"])   return @"iPad 3G";
    if([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (WiFi)";
    if([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";
    if([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (CDMA)";
    if([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
    if([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini (WiFi)";
    if([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini";
    if([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini (GSM+CDMA)";
    if([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (WiFi)";
    if([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (GSM+CDMA)";
    if([platform isEqualToString:@"iPad3,3"])   return @"iPad 3";
    if([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (WiFi)";
    if([platform isEqualToString:@"iPad3,5"])   return @"iPad 4";
    if([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (GSM+CDMA)";
    if([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (WiFi)";
    if([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (Cellular)";
    if([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2 (WiFi)";
    if([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2 (Cellular)";
    if([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2";
    if([platform isEqualToString:@"iPad4,7"])   return @"iPad Mini 3";
    if([platform isEqualToString:@"iPad4,8"])   return @"iPad Mini 3";
    if([platform isEqualToString:@"iPad4,9"])   return @"iPad Mini 3";
    if([platform isEqualToString:@"iPad5,1"])   return @"iPad Mini 4 (WiFi)";
    if([platform isEqualToString:@"iPad5,2"])   return @"iPad Mini 4 (LTE)";
    if([platform isEqualToString:@"iPad5,3"])   return @"iPad Air 2";
    if([platform isEqualToString:@"iPad5,4"])   return @"iPad Air 2";
    if([platform isEqualToString:@"iPad6,3"])   return @"iPad Pro 9.7";
    if([platform isEqualToString:@"iPad6,4"])   return @"iPad Pro 9.7";
    if([platform isEqualToString:@"iPad6,7"])   return @"iPad Pro 12.9";
    if([platform isEqualToString:@"iPad6,8"])   return @"iPad Pro 12.9";
    if([platform isEqualToString:@"iPad6,11"])  return @"iPad 5 (WiFi)";
    if([platform isEqualToString:@"iPad6,12"])  return @"iPad 5 (Cellular)";
    if([platform isEqualToString:@"iPad7,1"])   return @"iPad Pro 12.9 inch 2nd gen (WiFi)";
    if([platform isEqualToString:@"iPad7,2"])   return @"iPad Pro 12.9 inch 2nd gen (Cellular)";
    if([platform isEqualToString:@"iPad7,3"])   return @"iPad Pro 10.5 inch (WiFi)";
    if([platform isEqualToString:@"iPad7,4"])   return @"iPad Pro 10.5 inch (Cellular)";
    if([platform isEqualToString:@"iPad7,5"])   return @"iPad 6 (WiFi)";
    if([platform isEqualToString:@"iPad7,6"])   return @"iPad 6 (Cellular)";
    //2019年3月发布，更新二种机型：iPad mini、iPad Air
    if ([platform isEqualToString:@"iPad11,1"])   return @"iPad mini (5th generation)";
    if ([platform isEqualToString:@"iPad11,2"])   return @"iPad mini (5th generation)";
    if ([platform isEqualToString:@"iPad11,3"])   return @"iPad Air (3rd generation)";
    if ([platform isEqualToString:@"iPad11,4"])   return @"iPad Air (3rd generation)";
    
    return @"Unknow Device";
}

+ (BOOL)isPad {
    NSString *platform = [UIDevice platform];
    if([platform rangeOfString:@"iPad"].location != NSNotFound){
       return YES;
    } else {
       return NO;
    }
}

+ (BOOL)isRunningOnPad{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}

+ (CGFloat)diagonalWithPad {
    Pad ipad = [UIDevice iPadPlatform:[UIDevice platform]];
    
    switch (ipad) {
        case Pad2: return 9.7;
        case Pad3: return 9.7;
        case Pad4: return 9.7;
        case PadAir: return 9.7;
        case PadAir2: return 9.7;
        case PadAir3: return 10.5;
        case Pad5: return 9.7;
        case Pad6: return 9.7;
        case PadMini: return 7.9;
        case PadMini2: return 7.9;
        case PadMini3: return 7.9;
        case PadMini4: return 7.9;
        case PadMini5: return 7.9;
        case PadPro9Inch: return 9.7;
        case PadPro12Inch: return 12.9;
        case PadPro12Inch2: return 12.9;
        case PadPro10Inch: return 10.5;
        case PadUnknown: return -1;
    }

}

+ (CGSize)screenRatioWithPad {
    Pad ipad = [UIDevice iPadPlatform:[UIDevice platform]];
    
    switch (ipad) {
        case Pad2: return CGSizeMake(3, 4);
        case Pad3: return CGSizeMake(3, 4);
        case Pad4: return CGSizeMake(3, 4);
        case PadAir: return CGSizeMake(3, 4);
        case PadAir2: return CGSizeMake(3, 4);
        case PadAir3: return CGSizeMake(3, 4);
        case Pad5: return CGSizeMake(3, 4);
        case Pad6: return CGSizeMake(3, 4);
        case PadMini: return CGSizeMake(3, 4);
        case PadMini2: return CGSizeMake(3, 4);
        case PadMini3: return CGSizeMake(3, 4);
        case PadMini4: return CGSizeMake(3, 4);
        case PadMini5: return CGSizeMake(3, 4);
        case PadPro9Inch: return CGSizeMake(3, 4);
        case PadPro12Inch: return CGSizeMake(3, 4);
        case PadPro12Inch2: return CGSizeMake(3, 4);
        case PadPro10Inch: return CGSizeMake(3, 4);
        case PadUnknown: return CGSizeMake(-1, -1);
    }
}

+ (NSInteger)ppiWithPad {
    Pad ipad = [UIDevice iPadPlatform:[UIDevice platform]];
    
    switch (ipad) {
        case Pad2: return 132;
        case Pad3: return 264;
        case Pad4: return 264;
        case PadAir: return 264;
        case PadAir2: return 264;
        case PadAir3: return 264;
        case Pad5: return 264;
        case Pad6: return 264;
        case PadMini: return 163;
        case PadMini2: return 326;
        case PadMini3: return 326;
        case PadMini4: return 326;
        case PadMini5: return 326;
        case PadPro9Inch: return 264;
        case PadPro12Inch: return 264;
        case PadPro12Inch2: return 264;
        case PadPro10Inch: return 264;
        case PadUnknown: return -1;
    }
}


#pragma mark --- iTouch ---
+ (Pod)iPodPlatform:(NSString *)platform {
    
    if ([platform isEqualToString:@"iPod1,1"])  return Pod1;
    if ([platform isEqualToString:@"iPod2,1"])  return Pod2;
    if ([platform isEqualToString:@"iPod3,1"])  return Pod3;
    if ([platform isEqualToString:@"iPod4,1"])  return Pod4;
    if ([platform isEqualToString:@"iPod5,1"])  return Pod5;
    if ([platform isEqualToString:@"iPod7,1"])  return Pod6;
    //2019年5月发布，更新一种机型：iPod touch (7th generation)
    if ([platform isEqualToString:@"iPod9,1"])  return Pod7;
    
    return PodUnknown;
}

+ (NSString *)iPodDescription:(NSString *)platform {
    Pod temp = [UIDevice iPodPlatform:platform];
    switch (temp) {
        case Pod1: return @"iPod Touch 1G";
        case Pod2: return @"iPod Touch 2G";
        case Pod3: return @"iPod Touch 3G";
        case Pod4: return @"iPod Touch 4G";
        case Pod5: return @"iPod Touch (5 Gen)";
        case Pod6: return @"iPod Touch (6th generation)";
        case Pod7: return @"iPod Touch (7th generation)";
        case PodUnknown: return @"Unknown";
    }
}

+ (BOOL)isPod {
    NSString *platform = [UIDevice platform];
    if([platform rangeOfString:@"iPod"].location != NSNotFound){
      return YES;
    } else {
      return NO;
    }
}

+ (BOOL)isRunningOnPod {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if ([UIDevice isPod]) {
            return YES;
        }
    }
    return NO;
}

//      temp == PadAir2 ||
//        temp == Pad5 ||
//        temp == Pad6 ||
//        temp == PadMini3 ||
//        temp == PadMini4 ||
//        temp == PadPro9Inch ||
//        temp == PadPro12Inch ||
//        temp == PadPro12Inch2 ||
//        temp == PadPro10Inch) {
#pragma mark --- is Kinds of the Device ---

//+ (BOOL)isCanTouchID {
//    Device temp = [UIDevice xb_currentDevice];
//    if (temp == Phone5s ||
//        temp == Phone6 ||
//        temp == Phone6Plus ||
//        temp == Phone6s ||
//        temp == Phone6sPlus ||
//        temp == Phone7 ||
//        temp == Phone7Plus ||
//        temp == PhoneSE ||
//        temp == Phone8 ||
//        temp == Phone8Plus ||
//        temp == PadAir2 ||
//        temp == Pad5 ||
//        temp == Pad6 ||
//        temp == PadMini3 ||
//        temp == PadMini4 ||
//        temp == PadPro9Inch ||
//        temp == PadPro12Inch ||
//        temp == PadPro12Inch2 ||
//        temp == PadPro10Inch) {
//        return true;
//    } else {
//        return false;
//    }
//}


#pragma mark --- Base Info ---
+ (NSString *)platform {
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
