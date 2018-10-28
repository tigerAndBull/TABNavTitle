//
//  AppDelegate.m
//  LargeNavTitleDemo
//
//  Created by tigerAndBull on 2018/10/26.
//  Copyright © 2018年 tigerAndBull. All rights reserved.
//

#import "AppDelegate.h"

#import "TestViewController.h"
#import "MyViewController.h"
#import "BaseTabbarController.h"

#import "TABDefine.h"

#define titleArray @[@"首页",@"我的"]
#define normalImageArray @[@"index_normal",@"my_normal"]
#define selectImageArray @[@"index_select",@"my_select"]

@interface AppDelegate () {
    NSMutableArray *controllerArray;     // 控制器
}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    BaseTabbarController *tab = [[BaseTabbarController alloc]
         initWithTabbarControllerArray:self.controllerArray
                            TitleArray:titleArray
                      NormalImageArray:normalImageArray
                      SelectImageArray:selectImageArray
                          DefaultColor:[UIColor grayColor]
                           SelectColor:kNavigationColor
                             TitleFont:kFont(11)
                          NavBackColor:kNavigationColor
                         NavTitleColor:[UIColor blackColor]
                          NavTitleFont:kFont(16)];

    self.window.rootViewController = tab;
    return YES;
}

- (NSMutableArray *)controllerArray {
    if (!controllerArray) {
        controllerArray = [NSMutableArray array];
        
        TestViewController *index = [[TestViewController alloc]init];
        MyViewController *my = [[MyViewController alloc]init];
        [controllerArray addObject:index];
        [controllerArray addObject:my];
    }
    return controllerArray;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
