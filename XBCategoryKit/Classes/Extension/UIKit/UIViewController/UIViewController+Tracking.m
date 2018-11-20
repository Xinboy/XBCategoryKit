//
//  UIViewController+Tracking.m
//  XBKit
//
//  Created by Xinbo Hong on 2018/11/6.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

#import "UIViewController+Tracking.h"
#import <objc/runtime.h>

@implementation UIViewController (Tracking)


- (void)xb_viewWillAppear:(BOOL)animated {
    [self xb_viewWillAppear:animated];
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originSEL = @selector(viewWillAppear:);
        SEL swizzledSEL = @selector(xb_viewWillAppear:);
        
        Method originMethod = class_getInstanceMethod(class, originSEL);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSEL);
        
        BOOL didAddMethod = class_addMethod(class, originSEL, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class, swizzledSEL, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
        } else {
            method_exchangeImplementations(originMethod, swizzledMethod);
        }

    });
}

@end
