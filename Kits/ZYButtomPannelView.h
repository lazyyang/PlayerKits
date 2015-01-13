//
//  ZYButtomPannelView.h
//  ZYPlayerKit
//
//  Created by 杨争 on 14/12/14.
//  Copyright (c) 2014年 YangZheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYSlider.h"

@class ZYPanelViewController;
@interface ZYButtomPannelView : UIView

@property (nonatomic, assign) ZYPanelViewController *supperViewController;

/**
 *  进度条
 */
@property (strong, nonatomic) ZYSlider *progessSlider;

/**
 *  播放暂停按钮
 */
@property (strong, nonatomic) UIButton *playOrPauseButton;

/**
 *  播放下一条
 */
@property (strong, nonatomic) UIButton *playNextButton;

/**
 *  播放时间
 */
@property (strong, nonatomic) UILabel *timeLabel;

/**
 *  订阅频道
 */
@property (strong, nonatomic) UIButton *rssButton;

/**
 *  音频模式
 */
@property (strong, nonatomic) UIButton *audioButton;

/**
 *  清晰度切换
 */
@property (strong, nonatomic) UIButton *bitRateButton;

/**
 *  全屏按钮
 */
@property (strong, nonatomic) UIButton *fullScreenBtn;

/**
 *  锁屏
 */
@property (strong, nonatomic) UIButton *lockButton;

/**
 *  初始化
 *
 *  @param frame                frame
 *  @param supperViewController 父类
 *
 *  @return id
 */
- (id)initWithFrame:(CGRect)frame WithSupperViewController:(id)supperViewController;

- (void)refreshButtomPannelView;

@end
