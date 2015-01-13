//
//  ZYPlayerViewController.h
//  ZYPlayerKit
//
//  Created by YangZheng on 14/11/20.
//  Copyright (c) 2014年 YangZheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AVPlayer;
@class ZYPlayerView;
@class AVPlayerItem;
@class ZYLoadingVIewController;
@class ZYPlayerViewController;
@class ZYBitRateListView;
@class ZYAnthologyListView;

typedef void(^PlayerPannelEventBlock)(void);

typedef void (^FinishedBlock)(void);

typedef enum
{
    AutoBitRate,//自动
    FluentBitRate,//流畅
    StandardBitRate,//标准
    HightBitRate//高清
}BitRateType;

typedef enum
{
    AudioType,
    LiveType,
    VideoType,
}MeidaType;

@protocol PlayerEventsDelegate <NSObject>

@required

/**
 *  播放器已经旋转为竖直状态
 */
- (void)playerDidRotationPortrait;

/**
 *  播放器已经旋转为水平状态
 */
- (void)playerDidRotationLandscape;

/**
 *  即将播放下一条
 */
- (void)playerWillPlayNextMedia;

/**
 *  点击清晰度列表
 *
 *  @param bitRateListView 清晰度View
 *  @param index           行数
 */
- (void)bitRateListView:(ZYBitRateListView *)bitRateListView didSelectedRowAtIndex:(NSInteger)index;

/**
 *  点击选集或换台列表
 *
 *  @param anthologyListView 选集或者换台列表
 *  @param index             行数
 */
- (void)anthologyListView:(ZYAnthologyListView *)anthologyListView didSelectedRowAtIndex:(NSInteger)index;

@optional

/**
 *  即将收藏该节目
 */
- (void)playerWillCollectMedia;

/**
 *  即将订阅该节目
 */
- (void)playerWillRssMedia;

/**
 *  即将下载改节目
 */
- (void)playerWillDownloadMedia;

/**
 *  即将分享节目
 */
- (void)playerWillShareMedia;

@end

@protocol PlayerDataSource <NSObject>

/**
 *  获取节目的title
 *
 *  @param player
 *
 *  @return 返回标题
 */
- (NSString *)mediaTitleInPlayerView:(ZYPlayerViewController *)player;

/**
 *  当前播放媒体的收藏状态
 *
 *  @param player
 *
 *  @return 若已收藏则返回YES，否则返回NO
 */
- (BOOL)collectionStateInPlayerView:(ZYPlayerViewController *)player;

/**
 *  当前播放媒体的缓存状态
 *
 *  @param player
 *
 *  @return 若已缓存则返回YES，否则返回NO
 */
- (BOOL)downloadStateInPlayerView:(ZYPlayerViewController *)player;

/**
 *  当前播放哪一集
 *
 *  @param player
 *
 *  @return 返回播放第几条
 */
- (NSUInteger)currentIndexInPlayer:(ZYPlayerViewController *)player;

/**
 *  rss的状态
 *
 *  @param player
 *
 *  @return 若已订阅则返回YES，否则返回NO
 */
- (BOOL)rssStateInPlayerView:(ZYPlayerViewController *)player;

/**
 *  选集列表或者换台列表
 *
 *  @param player
 *
 *  @return 返回选集列表
 */
- (NSArray *)anthologyListInPlayerView:(ZYPlayerViewController *)player;

/**
 *  当前码率
 *
 *  @param player
 *
 *  @return 返回当前码率
 */
- (BitRateType)currentBitRateIndexPlayer:(ZYPlayerViewController *)player;

/**
 *  码率列表
 *
 *  @param player
 *
 *  @return 返回码率列表
 */
- (NSArray *)bitRateListIndexPlayer:(ZYPlayerViewController *)player;

@end

@interface ZYPlayerViewController : UIViewController

@property (nonatomic, strong) ZYLoadingVIewController *loadingViewController;

@property (nonatomic, assign) id<PlayerEventsDelegate> delegate;

@property (nonatomic, assign) id<PlayerDataSource> datasource;


/**
 *  初始化播放器
 *
 *  @param mediaType 媒体类型
 *
 *  @return
 */
- (instancetype)initWithMeidaType:(MeidaType)mediaType;

/**
 *  初始化播放
 *
 *  @param seconds 时间
 *  @param url     播放地址
 */
- (void)playFromSeconds:(NSTimeInterval *)seconds withURL:(NSURL *)url;

/**
 *  停止播放
 */
- (void)stopMedia;

/**
 *  开始播放
 */
- (void)startMedia;

/**
 *  seek time
 *
 *  @param value
 *  @param completion
 */
- (void)seekToTimeWithValue:(float)value completion:(void (^)(void))completion;

/**
 *  是否是直播
 */
- (BOOL)isLiveType;

@end
