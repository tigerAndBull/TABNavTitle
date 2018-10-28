//
//  BaseTabbarController.h
//
//  Created by tigerAndBull on 2017/12/11.
//  Copyright © 2017年 tigerAndBull. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CustomTabBar.h"
#import "BaseViewController.h"

@interface BaseTabbarController : UITabBarController<CustomTabBarDelegate>

@property (nonatomic, strong) CustomTabBar *customBar;

- (instancetype)initWithTabbarControllerArray:(NSArray<BaseViewController *> *)controllerArray
                                   TitleArray:(NSArray<NSString *> *)titleArray
                             NormalImageArray:(NSArray<NSString *> *)normalImageArray
                             SelectImageArray:(NSArray<NSString *> *)selectImageArray
                                 DefaultColor:(UIColor *)defaultColor
                                  SelectColor:(UIColor *)selectColor
                                    TitleFont:(UIFont *)titleFont
                                 NavBackColor:(UIColor *)navBackColor
                                NavTitleColor:(UIColor *)navTitleColor
                                 NavTitleFont:(UIFont *)navTitleFont;

@end
