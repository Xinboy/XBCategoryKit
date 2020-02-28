//
//  XBCategoryKit
//  Pods
//
//  Created by Xinbo Hong on 2018/11/21.
//

#ifndef XBCategoryKit_h
#define XBCategoryKit_h

/* --- Foundation.h" --- */
#import "NSData+XB_Encryption.h"
#import "NSDate+XB_Extension.h"
#import "NSNumber+XB_Extension.h"
#import "NSObject+XB_Invocation.h"
#import "NSObject+XB_Properties.h"
#import "NSString+XB_Encryption.h"
#import "NSString+XB_Regex.h"
#import "NSString+XB_Utils.h"
#import "NSDictionary+XB_Extension.h"

/* --- UIKit" --- */
#import "UIAlertController+XB_Extension.h"
#import "UIButton+XB_Utils.h"
#import "UIColor+XB_Extension.h"
#import "UIDevice+XB_Extension.h"
#import "UIFont+XB_Extension.h"
#import "UIImage+XB_Extension.h"
#import "UILabel+XB_Extension.h"
#import "UIScrollView+XB_Extention.h"
#import "UITextField+XB_Extension.h"
//UIView
#import "UIView+XB_Extension.h"
#import "UIView+XB_Frame.h"
#import "UIView+XB_Init.h"
#import "UIView+XB_PlaceholderView.h"

//UIViewController
#import "UIViewController+XB_Extention.h"
#import "UIViewController+XB_Swizzled.h"


#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
#define StrongObj(o) autoreleasepool{} __strong typeof(o) o = o##Strong;

#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif


#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
            #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
            #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif

#endif /* XBCategoryKit_h */
