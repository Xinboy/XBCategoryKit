//
//  NSObject+Invocation.m
//  XBKit
//
//  Created by Xinbo Hong on 2018/10/16.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

#import "NSObject+XB_Invocation.h"
#import <objc/runtime.h>
@implementation NSObject (Invocation)

- (id)performSelector:(SEL)selector Parameters:(NSArray *)parameters {
    //方法签名
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:selector];
    
    if (signature == nil ) {
        return nil;
    }
    //利用NSIvocation可以包装一次方法调用(设置方法调用者、方法名、参数、返回值)
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    
    //设置方法调用者
    invocation.target = self;
    //设置方法名
    invocation.selector = selector;
    //设置方法参数，注意参数下标从2开始，0、1被系统占用
    for (int i = 0; i < parameters.count; i++) {
        id object = parameters[i];
        if ([object isKindOfClass:[NSNull class]]) {
            continue;
        }
        [invocation setArgument:&object atIndex:i + 2];
    }
    //执行
    [invocation invoke];
    
    //设置返回值
    id returnValue = nil;
    //兼顾没有返回值的方法
    if (signature.methodReturnLength != 0) {
        // 说明此方法有返回值
        [invocation getReturnValue:&returnValue];
    }
    return returnValue;
}


+ (void)swizzlingMethodReplaceSelector:(SEL)oriSel swizz:(SEL)swizzSel {
    Class class = [self class];
    
    [NSObject swizzlingMethodReplaceClass:class Selector:oriSel SwizzledSelector:swizzSel];
}

+ (void)swizzlingMethodReplaceClass:(Class)clazz Selector:(SEL)ori swizz:(SEL)swizz {
    Method originalMethod = class_getInstanceMethod(clazz, ori);
    Method swizzledMethod = class_getInstanceMethod(clazz, swizz);
    
    BOOL success = class_addMethod(clazz, ori, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod(clazz, swizz, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        //说明方法列表中存在 swizzMethod 方法
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
@end
