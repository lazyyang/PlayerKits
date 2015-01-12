//
//  ZYRightPannelView.h
//  ZYPlayerKit
//
//  Created by 杨争 on 14/12/14.
//  Copyright (c) 2014年 YangZheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYSlider.h"
@class ZYPanelViewController;

@interface ZYRightPannelView : UIView

/**
 *  声音Slider
 */
@property (nonatomic, strong) ZYSlider *volumeSlider;

/**
 *  声音状态指示符，静音、最小以及最大三种状态
 */
@property (nonatomic, strong) UIImageView *volumeIndicateView;

/**
 *  初始化
 *
 *  @param frame                frame
 *  @param supperViewController 父类
 *
 *  @return id
 */
- (id)initWithFrame:(CGRect)frame WithSupperViewController:(id)supperViewController;

/**
 *  父类VC
 */
@property (nonatomic, assign) ZYPanelViewController *supperViewController;

@end
