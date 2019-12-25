//
//  NSURL+XB_Extension.m
//  XBCategoryKit_Example
//
//  Created by Xinbo Hong on 2019/11/28.
//  Copyright © 2019 Xinboy. All rights reserved.
//

#import "NSURL+XB_Extension.h"


@implementation NSURL (XB_Extension)


+ (void)openScheme:(NSString *)urlString {
    UIApplication *application = [UIApplication sharedApplication];
    
    NSURL *URL = [NSURL URLWithString:urlString];

    if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
         [application openURL:URL options:@{} completionHandler:^(BOOL success) {
             NSLog(@"Open %@: %d",urlString,success);
         }];

     } else {
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wdeprecated-declarations"
         BOOL success = [application openURL:URL];
        #pragma clang diagnostic pop
         NSLog(@"Open %@: %d",urlString,success);
     }
}


+ (NSURL *)getURLForDirectory:(NSSearchPathDirectory)directory {
    NSArray *array = [NSFileManager.defaultManager URLsForDirectory:directory inDomains:NSUserDomainMask];
    
    return array.lastObject;
}


+ (NSURL *)getDocumentURLPath {
    return [self getURLForDirectory:NSDocumentDirectory];
}

+ (NSURL *)getLibraryURLPath {
    return [self getURLForDirectory:NSLibraryDirectory];
}

+ (NSURL *)getCachesURLPath {
    return [self getURLForDirectory:NSCachesDirectory];
}

@end
