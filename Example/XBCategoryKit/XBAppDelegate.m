//
//  XBAppDelegate.m
//  XBCategoryKit
//
//  Created by Xinboy on 11/09/2018.
//  Copyright (c) 2018 Xinboy. All rights reserved.
//

#import "XBAppDelegate.h"
//#import "NSObject+Properties.h"

//#import "XBTest.h"
#import "XBCategoryKit.h"
@implementation XBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    NSLog(@"--");
    // Override point for customization after application launch.
//    XBTest *test = [[XBTest alloc] init];
//    test.string = @"testString";
//
//    test.dict = @{@"key1": @"value1",
//                  @"key2": @"value2",
//                  @"key3": @"value3",
//                  @"key4": @"value4",
//                  @"key5": @"value5",
//                  @"key6": @"value6"
//                  };
//
//    test.array = @[@"value2",@"value2",@"value2",@"value2",@"value2"];
//
//
//    NSLog(@"%@",[XBTest className]);
//    NSLog(@"%@",[test className]);
//
//    NSLog(@"-----");
//    NSLog(@"%@",[XBTest propertiesValues]);
//    NSLog(@"%@",[test propertiesValues]);
//
//    NSLog(@"-----");
//    NSLog(@"%@",[XBTest propertyKeys]);
//    NSLog(@"%@",[test propertyKeys]);
//
//    NSLog(@"-----");
//    NSLog(@"%@",[XBTest methodList]);
//    NSLog(@"%@",[test methodList]);
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
