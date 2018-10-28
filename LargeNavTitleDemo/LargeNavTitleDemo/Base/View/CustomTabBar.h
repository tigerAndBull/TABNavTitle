//
//  CustomTabBar.h
//
//  Created by tigerAndBull on 2017/12/11.
//  Copyright © 2017年 tigerAndBull. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomTabBarDelegate<NSObject>

- (void)didSelectIndex:(NSInteger)index;

@end

@interface CustomTabBar : UIView

/** 图片 */
@property (nonatomic, strong) NSArray *images;
/** 标题 */
@property (nonatomic, strong) NSArray *titles;
/** 选中图片 */
@property (nonatomic, strong) NSArray *seletedImages;
/** 默认字体颜色 */
@property (nonatomic, strong) UIColor *defaultColor;
/** 选中字体颜色 */
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UIView *centerView;
/** 执行选中事件的代理对象 */
@property (nonatomic, weak) id<CustomTabBarDelegate> delegate;
@property (nonatomic, assign) CGFloat imageTitleSpace;
// 字体
@property (nonatomic, strong) UIFont *titleFont;

- (void)updateBar;

/** 以图片为主 */
- (instancetype)initWithImages:(NSArray <NSString *> *)images
                 selectedImage:(NSArray <NSString *> *)selectedImages
                        titles:(NSArray <NSString *> *)titles
                 selectedColor:(UIColor *)selectedColor
                      delegate:(id<CustomTabBarDelegate>)delegate;
+ (CGSize)barSize;

- (void)setSelectedIndex:(NSInteger)index;

@end
