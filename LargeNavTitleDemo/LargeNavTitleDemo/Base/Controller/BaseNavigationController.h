//
//  JC_BaseNavigationController.h
//
//  Created by tigerAndBull on 2017/12/11.
//  Copyright © 2017年 tigerAndBull. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseViewController;

typedef void(^NavBackAction)(void);

@interface BaseNavigationController : UINavigationController

@property (nonatomic, copy) NavBackAction backAction;


- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
                              NavBackColor:(UIColor *)backColor
                             NavTitleColor:(UIColor *)titleColor
                              NavTitleFont:(UIFont *)titleFont;

- (void)pushViewController:(BaseViewController *)viewController animated:(BOOL)animated hideTabbar:(BOOL)hide;

#pragma mark - 屏幕旋转

@property (nonatomic) BOOL supportPortraitOnly;

@end
