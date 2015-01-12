//
//  ZYPlayerViewController.m
//  ZYPlayerKit
//
//  Created by YangZheng on 14/11/20.
//  Copyright (c) 2014年 YangZheng. All rights reserved.
//

#import "ZYPlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "ZYPlayerView.h"
#import "ZYPlayerKeys.h"
#import "ZYLoadingVIewController.h"
#import "ZYPanelViewController.h"

@interface ZYPlayerViewController ()

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) ZYPlayerView *playerView;
@property (nonatomic, strong) AVAsset *asset;
@property (nonatomic, strong) id timeObserver;
@property (nonatomic, strong) ZYPanelViewController *pannelViewController;
@property (nonatomic, assign) MeidaType mediaType;

@end

@implementation ZYPlayerViewController

- (instancetype)initWithMeidaType:(MeidaType)mediaType
{
    if (self = [super init]) {
        self.mediaType = mediaType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
     _playerView = [[ZYPlayerView alloc] initWithFrame:self.view.bounds];
    _player = [[AVPlayer alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    [_playerView.playerLayer setPlayer:_player];
    _playerView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_playerView];
}

- (void)viewWillLayoutSubviews
{
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)){
        if ([_delegate respondsToSelector:@selector(playerDidRotationLandscape)]) {
            [_delegate playerDidRotationLandscape];
        }
    } else{
        if ([_delegate respondsToSelector:@selector(playerDidRotationPortrait)]) {
            [_delegate playerDidRotationPortrait];
        }
    }
}

- (void)setAsset:(AVAsset *)asset
{
    if (_asset == asset)
        return;
    
    _asset = asset;
    
    if (!_asset) {
        [self setPlayerItem:nil];
    }
    

    
    NSArray *keys = @[@"tracks", @"playable", @"duration"];
    
    [_asset loadValuesAsynchronouslyForKeys:keys completionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            // check the keys
            for (NSString *key in keys) {
                NSError *error = nil;
                AVKeyValueStatus keyStatus = [asset statusOfValueForKey:key error:&error];
                if (keyStatus == AVKeyValueStatusFailed) {
                    return;
                }
            }
            
            // setup player
            AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:_asset];
            [self setPlayerItem:playerItem];
        });
    }];
}

- (void)removePlayerItemObserver:(AVPlayerItem *)playerItem
{
    [playerItem removeObserver:self forKeyPath:kItemStatus context:nil];
    [playerItem removeObserver:self forKeyPath:kItemBufferFull context:nil];
    [playerItem removeObserver:self forKeyPath:kItemBufferEmpty context:nil];
    [playerItem removeObserver:self forKeyPath:kItemLoadedTimeRanges context:nil];
    [playerItem removeObserver:self forKeyPath:kItemAirPlayVideoActive context:nil];
    [playerItem removeObserver:self forKeyPath:kItemExternalPlaybackActive context:nil];
    [playerItem removeObserver:self forKeyPath:kItemplaybackLikelyToKeepUp context:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AVPlayerItemDidPlayToEndTimeNotification
                                                  object:playerItem];
}

- (void)addPlayerItemObserver:(AVPlayerItem *)playerItem
{
    [playerItem addObserver:self forKeyPath:kItemStatus options:NSKeyValueObservingOptionNew context:nil];
    [playerItem addObserver:self forKeyPath:kItemBufferFull options:NSKeyValueObservingOptionNew context:nil];
    [playerItem addObserver:self forKeyPath:kItemBufferEmpty options:NSKeyValueObservingOptionNew context:nil];
    [playerItem addObserver:self forKeyPath:kItemLoadedTimeRanges options:NSKeyValueObservingOptionNew context:nil];
    [playerItem addObserver:self forKeyPath:kItemAirPlayVideoActive options:NSKeyValueObservingOptionNew context:nil];
    [playerItem addObserver:self forKeyPath:kItemExternalPlaybackActive options:NSKeyValueObservingOptionNew context:nil];
    [playerItem addObserver:self forKeyPath:kItemplaybackLikelyToKeepUp options:NSKeyValueObservingOptionNew context:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(itemDidFinishedPlaying:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:playerItem];
}

- (void)itemDidFinishedPlaying:(NSNotification *)notif
{
    NSLog(@"本机播放完成");
    if ([_delegate respondsToSelector:@selector(playerWillPlayNextMedia)]) {
        [_delegate playerWillPlayNextMedia];
    }
}

- (void)setPlayerItem:(AVPlayerItem *)playerItem
{
    if (_playerItem == playerItem) {
        return;
    }
    
    if (_playerItem) {
        [self removePlayerItemObserver:_playerItem];
    }
    
    _playerItem = playerItem;
    if(_playerItem){
        [_player replaceCurrentItemWithPlayerItem:_playerItem];
        [self addPlayerItemObserver:_playerItem];
    }
}

- (void)addLoadingView
{
    _loadingViewController = [[ZYLoadingVIewController alloc] init];
//    _loadingViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _loadingViewController.view.frame = _playerView.bounds;
    [self addChildViewController:_loadingViewController];
    [_playerView addSubview:_loadingViewController.view];
}

- (void)removeLoadingView
{
    [_loadingViewController removeFromParentViewController];
    [_loadingViewController.view removeFromSuperview];
    
    [self addPannelViewController];
}

- (void)addPannelViewController
{
    if (!_pannelViewController) {
        _pannelViewController = [[ZYPanelViewController alloc] init];
        _pannelViewController.playerViewController = self;
        _pannelViewController.view.frame = _playerView.bounds;
        [self addChildViewController:_pannelViewController];
        [_playerView addSubview:_pannelViewController.view];
    }
}

- (void)playFromSeconds:(NSTimeInterval *)seconds withURL:(NSURL *)url
{
    [self addLoadingView];
    [self setAsset:[AVURLAsset URLAssetWithURL:url options:nil]];
}

- (void)updateStatus:(AVPlayerItem *)playerItem
{
    [self.player removeTimeObserver:self.timeObserver];
    self.timeObserver = nil;
    __weak typeof(&*self) weakSelf = self;
    self.timeObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
        CGFloat timeDuration = CMTimeGetSeconds(playerItem.duration);
        CGFloat timeCurrent = CMTimeGetSeconds(playerItem.currentTime);
        [weakSelf.pannelViewController updateStatusWithDuration:timeDuration current:timeCurrent];
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:kItemplaybackLikelyToKeepUp]) {
        
        NSLog(@"kItemplaybackLikelyToKeepUp");
        
    } else if ([keyPath isEqualToString:kItemExternalPlaybackActive]){
        
        NSLog(@"kItemExternalPlaybackActive");
        
    } else if ([keyPath isEqualToString:kItemAirPlayVideoActive]){
        
        NSLog(@"kItemAirPlayVideoActive");
        
    } else if ([keyPath isEqualToString:kItemLoadedTimeRanges]){
        
        NSLog(@"kItemLoadedTimeRanges");
        
    } else if ([keyPath isEqualToString:kItemBufferEmpty]){
        
        NSLog(@"kItemBufferEmpty");
        
    } else if ([keyPath isEqualToString:kItemBufferFull]){
        
        NSLog(@"kItemBufferFull");
        
    } else if ([keyPath isEqualToString:kItemStatus]){
        
        NSLog(@"kItemStatus");
        if ([playerItem status] == AVPlayerItemStatusReadyToPlay) {
            [_player play];
            [self removeLoadingView];
            [self updateStatus:playerItem];
            NSLog(@"可以播放了");
        } else if ([_playerItem status] == AVPlayerItemStatusFailed){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"播放失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
}

- (void)stopMedia
{
    [self.player pause];
}

- (void)startMedia
{
    [self.player play];
}

- (void)seekToTimeWithValue:(float)value completion:(void (^)(void))completion
{
    [_player pause];
    [_player seekToTime:CMTimeMakeWithSeconds(value, _player.currentTime.timescale) completionHandler:^(BOOL finished) {
        NSLog(@"进度调节完成");
        [_player play];
        [self updateStatus:_playerItem];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
