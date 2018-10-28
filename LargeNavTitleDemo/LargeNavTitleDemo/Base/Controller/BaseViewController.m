//
//  TABBaseViewController.m
//  TABBaseProject
//
//  Created by tigerAndBull on 2018/10/5.
//  Copyright © 2018年 tigerAndBull. All rights reserved.
//

#import "BaseViewController.h"

#import "TABDefine.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark - LifeCycle

- (void)loadView {
    
    CGFloat statusHeight = self.hideNavigationBar ? 0 : self.statusHeight;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - statusHeight - self.navigationBarHeight - self.tabbarHeight)];
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNotification];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTabbarNotification" object:nil userInfo:@{@"hideTabbar":@(self.hideTabbar)}];
    
    if (self.backButtonEnable) {
        if (self.hideNavigationBar) {
            [self.view addSubview:self.backButton];
        } else {
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
        }
    }
    self.navigationController.navigationBarHidden = self.hideNavigationBar;
    self.tabBarController.tabBar.hidden = self.hideTabbar;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)dealloc {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Target Methods

- (void)clickBackButtonAction:(UIButton *)button {
    
    if (self.navigationController.viewControllers.count > 1) {
        if (self.backAction) {
            BLOCK_EXEC(self.backAction);
        }
        [self.navController popViewControllerAnimated:YES];
    } else {
        [self.navController dismissViewControllerAnimated:YES completion:^{
            if (self.backAction) {
                BLOCK_EXEC(self.backAction);
            }
        }];
    }
}

#pragma mark - Private Methods

- (BaseNavigationController *)navController {
    return (BaseNavigationController *)self.navigationController;
}

#pragma mark - Initize Methods

/**
 add notificaiton
 添加通知
 */
- (void)addNotification {
    
}

/**
 initialize view
 初始化视图
 */
- (void)initUI {
    
}

#pragma mark - Lazy Methods

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _backButton.frame = CGRectMake(isIPad?30:20, self.statusHeight+8, 30, 30);
        [_backButton setImage:[UIImage imageNamed:@"back"] forState:(UIControlStateNormal)];
        [_backButton setImage:[UIImage imageNamed:@"back"] forState:(UIControlStateHighlighted)];
        [_backButton addTarget:self action:@selector(clickBackButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _backButton;
}

- (CGFloat)statusHeight {
    
    // 这里不用[UIApplication sharedApplication].statusBarFrame 因为播放页面隐藏状态栏 返回首页后此方法将获得值为0
    if (isIPhoneFill) {
        return 44;
    }
    return 20;
}

- (CGFloat)navigationBarHeight {
    self.navigationController.navigationBar.hidden = self.hideNavigationBar;
    if (self.hideNavigationBar) {
        return 0.f;
    }
    return self.navigationController.navigationBar.frame.size.height;
}

- (CGFloat)tabbarHeight {
    if (self.hideTabbar) {
        return 0.f;
    }
    return isIPhoneFill ? 83 : 49;
}

- (void)setHideNavigationBar:(BOOL)hideNavigationBar {
    _hideNavigationBar = hideNavigationBar;
    self.navigationController.navigationBar.hidden = hideNavigationBar;
}

@end
