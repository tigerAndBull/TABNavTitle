//
//  TABBaseViewController.h
//  ChildStory
//
//  Created by tigerAndBull on 2018/10/20.
//  Copyright © 2018年 tigerAndBull. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LargeTitleBaseViewController : BaseViewController

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSString *navTitle;

- (void)refreshNavViewWithNavStatus:(BOOL)show;  // reflash nav when the nav is showing

@end

NS_ASSUME_NONNULL_END
