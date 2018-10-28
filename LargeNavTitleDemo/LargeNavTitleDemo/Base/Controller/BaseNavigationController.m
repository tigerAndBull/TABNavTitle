//
//  BaseNavigationController.m
//
//  Created by tigerAndBull on 2017/12/11.
//  Copyright © 2017年 tigerAndBull. All rights reserved.
//

#import "BaseNavigationController.h"
#import "BaseViewController.h"
#import "BaseTabbarController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(BaseViewController *)viewController animated:(BOOL)animated hideTabbar:(BOOL)hide {
    viewController.hideTabbar = hide;
    viewController.hidesBottomBarWhenPushed = hide;
    viewController.backButtonEnable = YES;
    [self pushViewController:viewController animated:animated];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [super popViewControllerAnimated:animated];
}

#pragma mark - 屏幕旋转

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.supportPortraitOnly) {
        return UIInterfaceOrientationMaskPortrait;
    } else {
        return [self.topViewController supportedInterfaceOrientations];
    }
}

- (BOOL)shouldAutorotate {
    if (self.supportPortraitOnly) {
        return NO;
    } else {
        return [self.topViewController shouldAutorotate];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    if (self.supportPortraitOnly) {
        return UIInterfaceOrientationPortrait == toInterfaceOrientation;
    } else {
        return [self.topViewController shouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
    }
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.topViewController;
}

#pragma mark - Initize Method

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
                              NavBackColor:(UIColor *)navBackColor
                             NavTitleColor:(UIColor *)navTitleColor
                              NavTitleFont:(UIFont *)navTitleFont {
    
    self = [super initWithRootViewController:rootViewController];
    
    if (self) {
        
        self.navigationBar.tintColor = navBackColor;
        self.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:navTitleColor, NSForegroundColorAttributeName, navTitleFont, NSFontAttributeName, nil];
        self.navigationBar.translucent = NO;
        self.interactivePopGestureRecognizer.delegate = (id)self;
    }
    return self;
}

@end
