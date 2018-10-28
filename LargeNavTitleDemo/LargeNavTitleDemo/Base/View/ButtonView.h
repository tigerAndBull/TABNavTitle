//
//  ButtonView.h
//
//  Created by tigerAndBull on 2017/12/11.
//  Copyright © 2017年 tigerAndBull. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSInteger {
    UnknowType = -1,
    NormalTypeTitlesOnly,
    NormalTypeImagesOnly,
    NormalTypeImageTitles,
    ChangeTypeTitlesOnly,
    ChangeTypeImagesOnly,
    ChangeTypeImageTitles,
} ContentType;

@protocol ButtonViewDelegate <NSObject>

- (void)didSelectButton:(UIButton *)button atIndex:(NSInteger)index title:(NSString *)title;

@end

@interface ButtonView : UIView

@property (nonatomic, assign) ContentType type;
/** 图片 */
@property (nonatomic, strong) NSArray *images;
/** 标题 */
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, weak) id<ButtonViewDelegate> delegate;
@property (nonatomic, strong) NSArray *seletedImages;
/** 默认字体颜色 */
@property (nonatomic, strong) UIColor *defaultColor;
/** 选中字体颜色 */
@property (nonatomic, strong) UIColor *selectedColor;
/** 是否显示下划线 默认NO */
@property (nonatomic, assign, getter=canShowPageLine) BOOL showPageLine;
/** 文字的字体 */
@property (nonatomic, strong) UIFont *titleFont;
/** 标题和图片间隙 */
@property (nonatomic, assign) CGFloat spacing;
/** 判断是否需要状态变化 */
@property (nonatomic, assign) BOOL stateChangeSwitch;
/** 当前选中的下标 */
@property (nonatomic, assign) NSInteger currentIndex;
/** 是否对于选中的按钮不可再次点击 默认yes */
@property (nonatomic, assign) BOOL lockEnable;
/** 按钮的大小  默认 44*44 */
@property (nonatomic, assign) CGSize buttonSize;
@property (nonatomic, strong) UIColor *lineColor;
/** 存放按钮的数组 */
@property (nonatomic, strong) NSMutableArray *buttonArray;

- (instancetype)initWithType:(ContentType)type;

/** 仅显示图片+文字的buttonView 没有状态变化 */
- (instancetype)initWithFrame:(CGRect)frame
                       Images:(NSArray <NSString *> *)images
                       titles:(NSArray <NSString *> *)titles
                     delegate:(id<ButtonViewDelegate>)delegate;
/** 重新布局 */
- (void)reloadView;

/** 自定义tabbar样式 状态跟随点击变化 */
- (instancetype)initWithFrame:(CGRect)frame
                       Images:(NSArray<NSString *> *)images
               selectedImages:(NSArray<NSString *> *)selectedImages
                       titles:(NSArray<NSString *> *)titles
                 defaultColor:(UIColor *)defaultColor
                selectedColor:(UIColor *)selectedColor
                     delegate:(id<ButtonViewDelegate>)delegate;

#pragma mark - 新增功能  选中放大

// 选中颜色变化开关    开启此开关后纯文字形式才能切换选中色彩
@property (nonatomic, assign) BOOL colorChangeEnable;
// 选中状态变化开关
@property (nonatomic, assign) BOOL sizeChangeEnable;
// 缩放系数 建议0.5~2 只有sizeChangeEnable开关打开时候生效
@property (nonatomic, assign) CGFloat scale;

@end
