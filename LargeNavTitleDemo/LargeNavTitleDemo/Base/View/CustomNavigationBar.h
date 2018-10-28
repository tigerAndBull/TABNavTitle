//
//  CustomNavigationBar.h
//
//  Created by tigerAndBull on 2018/9/3.
//  Copyright © 2018年 tigerAndBull. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomNavigationBarDelegate<NSObject>

@optional

- (void)customNavigationBarBackAction;

@end

@interface CustomNavigationBar : UIView

/** searchBar */
@property (nonatomic, strong) UISearchBar *customSearchBar;

@property (nonatomic, assign) id<CustomNavigationBarDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame
               showBackButton:(BOOL)show
                     delegate:(id<CustomNavigationBarDelegate>)delegate;


@end
