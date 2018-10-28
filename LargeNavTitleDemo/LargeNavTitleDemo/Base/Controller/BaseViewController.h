//
//  TABBaseViewController.h
//  TABBaseProject
//
//  Created by tigerAndBull on 2018/10/5.
//  Copyright © 2018年 tigerAndBull. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseNavigationController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^BackBlock)(void);

@interface BaseViewController : UIViewController

/** 是否隐藏tab栏 */
@property (nonatomic, assign) BOOL hideTabbar;
@property (nonatomic, copy) BackBlock backAction;
@property (nonatomic, strong) UIButton *backButton;

/** 是否出现公共的返回按钮 */
@property (nonatomic, assign) BOOL backButtonEnable;

/** 是否隐藏导航栏 */
@property (nonatomic, assign) BOOL hideNavigationBar;
@property (nonatomic, strong) BaseNavigationController *navController;

@end

NS_ASSUME_NONNULL_END
