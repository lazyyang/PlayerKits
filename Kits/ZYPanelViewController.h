//
//  ZYPanelViewController.h
//  ZYPlayerKit
//
//  Created by 杨争 on 14/12/14.
//  Copyright (c) 2014年 YangZheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>


@class ZYPlayerViewController;
@interface ZYPanelViewController : UIViewController


@property (nonatomic, assign) ZYPlayerViewController *playerViewController;

@property (nonatomic, assign) BOOL isPannelHidden;

/**
 *  播放或者暂停
 *
 *  @param button
 */
- (void)playOrPause:(UIButton *)button;

/**
 *  播放下一条
 *
 *  @param button
 */
- (void)playNext:(UIButton *)button;

/**
 *  rss订阅
 *
 *  @param button
 */
- (void)rssBtnClicked:(UIButton *)button;

/**
 *  锁频按钮
 *
 *  @param button
 */
- (void)lockBtnClicked:(UIButton *)button;

/**
 *  播放进度条
 *
 *  @param slider
 */
- (void)progessSlider:(UISlider *)slider;

/**
 *  开始拖拽播放进度条
 *
 *  @param slider
 */
- (void)progessSliderValueChangedBegin:(UISlider *)slider;

/**
 *  停止拖拽进度条
 *
 *  @param slider
 */
- (void)progessSliderValueChangedEnd:(UISlider *)slider;

/**
 *  音量进度条
 *
 *  @param slider
 */
- (void)volumnSlider:(UISlider *)slider;

/**
 *  音量进度条松手
 *
 *  @param slider
 */
- (void)volumnSliderTouchCancel:(UISlider *)slider;

/**
 *  全屏
 *
 *  @param button
 */
- (void)fullScreen:(UIButton *)button;

/**
 *  退出全屏
 *
 *  @param button
 */
- (void)resignFullScreen:(UIButton *)button;

/**
 *  改变媒体类型，改为音频模式或者视频模式
 *
 *  @param button
 */
- (void)changeMediaType:(UIButton *)button;

/**
 *  换台或选集按钮点击
 *
 *  @param button
 */
- (void)anthologyBtnClicked:(UIButton *)button;

/**
 *  缓存按钮点击
 *
 *  @param button
 */
- (void)downloadButtonClicked:(UIButton *)button;

/**
 *  分享按钮点击
 *
 *  @param button
 */
- (void)shareButtonClicked:(UIButton *)button;

/**
 *  收藏按钮点击
 *
 *  @param button
 */
- (void)collectButtonClicked:(UIButton *)button;

/**
 *  清晰度切换按钮点击
 *
 *  @param button 切换清晰度
 */
- (void)bitRateButtonClicked:(UIButton *)button;

/**
 *  获取当前Title
 */
- (NSString *)getCurrentTitle;

/**
 *  更新当前的进度条与时间
 *
 *  @param duration 总时间
 *  @param current  当前播放时间
 */
- (void)updateStatusWithDuration:(CGFloat)duration current:(CGFloat)current;

/**
 *  获取选集或换台的数据列表
 *
 *  @return NSArray
 */
- (NSArray *)getAnthologyDataSource;

/**
 *  anthologyView点击事件
 *
 *  @param index 点击了哪一行
 */
- (void)anthologyViewDidSeletedRowAtIndex:(NSInteger)index;

/**
 *  显示相关PannelView
 */
- (void)showPannelView;

/**
 *  隐藏相关PannelView
 */
- (void)hiddenPannelView;


@end
