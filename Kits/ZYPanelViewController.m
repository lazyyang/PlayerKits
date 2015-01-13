//
//  ZYPanelViewController.m
//  ZYPlayerKit
//
//  Created by 杨争 on 14/12/14.
//  Copyright (c) 2014年 YangZheng. All rights reserved.
//

#import "ZYPanelViewController.h"
#import "ZYButtomPannelView.h"
#import "ZYLeftPannelView.h"
#import "ZYTopPannelView.h"
#import "ZYRightPannelView.h"
#import "ZYPlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "ZYPlayerKeys.h"
#import "ZYAnthologyListView.h"
#import "ZYGesture.h"

@interface ZYPanelViewController ()

@property (strong, nonatomic) ZYLeftPannelView *leftPannelView;

@property (strong, nonatomic) ZYButtomPannelView *buttomPannelView;

@property (strong, nonatomic) ZYTopPannelView *topPannelView;

@property (strong, nonatomic) ZYRightPannelView *rightPannelView;

@property (strong, nonatomic) ZYAnthologyListView *anthologyListView;

@property (strong, nonatomic) ZYGesture *gestureView;

@end

@implementation ZYPanelViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kSystemVolumeDidChanged
                                                  object:nil];
    self.leftPannelView = nil;
    self.buttomPannelView = nil;
    self.topPannelView = nil;
    self.rightPannelView = nil;
    self.anthologyListView = nil;
    self.gestureView = nil;
}

- (void)showPannelView
{
    self.isPannelHidden = NO;
    self.buttomPannelView.hidden = NO;
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        self.leftPannelView.hidden = NO;
        self.topPannelView.hidden = NO;
        self.rightPannelView.hidden = NO;
    }
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self startTime];
}

- (void)hiddenPannelView
{
    [self stopTime];
    self.isPannelHidden = YES;
    self.leftPannelView.hidden = YES;
    self.buttomPannelView.hidden = YES;
    self.topPannelView.hidden = YES;
    self.rightPannelView.hidden = YES;
    self.anthologyListView.hidden = YES;
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
    }
}

- (void)startTime
{
    [self performSelector:@selector(hiddenPannelView) withObject:nil afterDelay:5.0f];
}

- (void)stopTime
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hiddenPannelView) object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.buttomPannelView = [[ZYButtomPannelView alloc] initWithFrame:CGRectZero WithSupperViewController:self];
    self.leftPannelView = [[ZYLeftPannelView alloc] initWithFrame:CGRectZero WithSupperViewController:self];
    self.topPannelView = [[ZYTopPannelView alloc] initWithFrame:CGRectZero WithSupperViewController:self];
    self.rightPannelView = [[ZYRightPannelView alloc] initWithFrame:CGRectZero WithSupperViewController:self];
    self.gestureView = [[ZYGesture alloc] initWithFrame:self.view.bounds WithSupperViewController:self];
    self.gestureView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_gestureView];
    [self.view addSubview:_buttomPannelView];
    [self.view addSubview:_leftPannelView];
    [self.view addSubview:_topPannelView];
    [self.view addSubview:_rightPannelView];
    
    [self startTime];
}

- (void)viewWillLayoutSubviews
{
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)){
        self.leftPannelView.hidden = NO;
        self.topPannelView.hidden = NO;
        self.rightPannelView.hidden = NO;
        self.leftPannelView.frame = CGRectMake(0, self.view.bounds.size.height/2 - 110.0f/2, 40.0f, 110.0f);
        if ([_playerViewController isLiveType]) {
            self.buttomPannelView.frame = CGRectMake(0, self.view.bounds.size.height - 40.0f, self.view.bounds.size.width, 40.0f);
        } else{
            self.buttomPannelView.frame = CGRectMake(0, self.view.bounds.size.height - 62.0f, self.view.bounds.size.width, 62.0f);
        }
        if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)) {
            self.topPannelView.frame = CGRectMake(0, 0.0f, self.view.bounds.size.width, 60.0f);
        } else{
            self.topPannelView.frame = CGRectMake(0, 0.0f, self.view.bounds.size.width, 40.0f);
        }
        self.rightPannelView.frame = CGRectMake(self.view.bounds.size.width - 40.0f, self.view.bounds.size.height/2 - 110.0f/2, 40.0f, 110.0f);
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(volumeChanged:)
                                                     name:kSystemVolumeDidChanged
                                                   object:nil];
        
        if (!self.isPannelHidden) {
            [[UIApplication sharedApplication] setStatusBarHidden:NO];
            
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        }
    
    } else{
        self.leftPannelView.hidden = YES;
        self.rightPannelView.hidden = YES;
        self.topPannelView.hidden = YES;
        self.leftPannelView.frame = CGRectMake(0, self.view.bounds.size.height/2 - 110.0f/2, 40.0f, 110.0f);
        self.buttomPannelView.frame = CGRectMake(0, self.view.bounds.size.height - 40.0f, self.view.bounds.size.width, 40.0f);
        self.topPannelView.frame = CGRectMake(0, 20.0f, self.view.bounds.size.width, 40.0f);
        self.rightPannelView.frame = CGRectMake(self.view.bounds.size.width - 40.0f, self.view.bounds.size.height/2 - 110.0f/2, 40.0f, 110.0f);
        
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:kSystemVolumeDidChanged
                                                      object:nil];
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];


    }
}

- (void)volumeChanged:(NSNotification *)notif
{
    float volume = [[[notif userInfo]
                        objectForKey:@"AVSystemController_AudioVolumeNotificationParameter"] floatValue];
    if (fabs(self.rightPannelView.volumeSlider.value - volume) > 0.000001) {
        self.rightPannelView.volumeSlider.value = volume;
    }
}

- (void)playOrPause:(UIButton *)button
{
    NSLog(@"播放或者暂停");
    if (button.tag == 0) {//暂停状态
        [_playerViewController startMedia];
        [button setImage:[UIImage imageNamed:@"landscape_pause.png"] forState:UIControlStateNormal];
        button.tag = 1;
    } else{//播放状态
        [_playerViewController stopMedia];
        [button setImage:[UIImage imageNamed:@"landscape_play.png"] forState:UIControlStateNormal];
        button.tag = 0;
    }
}

- (void)playNext:(UIButton *)button
{
    NSLog(@"播放下一条");
    if ([_playerViewController.delegate respondsToSelector:@selector(playerWillPlayNextMedia)]) {
        [_playerViewController.delegate playerWillPlayNextMedia];
    }
}

- (void)rssBtnClicked:(UIButton *)button
{
    NSLog(@"rss订阅");
    if ([_playerViewController.delegate respondsToSelector:@selector(playerWillRssMedia)]) {
        [_playerViewController.delegate playerWillRssMedia];
    }
}

- (void)lockBtnClicked:(UIButton *)button
{
    NSLog(@"锁频按钮");
}

- (void)progessSliderValueChangedBegin:(UISlider *)slider
{
    NSLog(@"开始拖拽进度条");
}

- (void)progessSliderValueChangedEnd:(UISlider *)slider
{
    NSLog(@"进度条拖拽结束");
    [_playerViewController seekToTimeWithValue:slider.value completion:nil];
}

- (void)volumnSlider:(UISlider *)slider
{
    [MPMusicPlayerController iPodMusicPlayer].volume = slider.value;
    NSLog(@"音量进度条");
}

- (void)volumnSliderTouchCancel:(UISlider *)slider
{
    NSLog(@"音量slider松手");
}

- (void)fullScreen:(UIButton *)button
{
    NSLog(@"全屏");
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationLandscapeLeft;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

- (void)resignFullScreen:(UIButton *)button
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationPortrait;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
    NSLog(@"退出全屏");
}

- (void)changeMediaType:(UIButton *)button
{
    NSLog(@"改变媒体类型，切换为音频模式或者视频模式");
}

- (void)anthologyBtnClicked:(UIButton *)button
{
    NSLog(@"换台或者选集按钮点击");
    if (!_anthologyListView) {
        _anthologyListView = [[ZYAnthologyListView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 200.0f, _topPannelView.frame.origin.y + _topPannelView.frame.size.height, 200.0f, self.view.bounds.size.height - _topPannelView.frame.origin.y - _topPannelView.frame.size.height) WithSupperViewController:self];
        [self.view addSubview:_anthologyListView];
    } else{
        _anthologyListView.hidden = !_anthologyListView.hidden;
    }
    
    if (_anthologyListView.hidden == NO) {
        self.leftPannelView.hidden = YES;
        self.buttomPannelView.hidden = YES;
        self.rightPannelView.hidden = YES;
    } else{
        [self hiddenPannelView];
    }
}

- (void)downloadButtonClicked:(UIButton *)button
{
    NSLog(@"下载按钮点击");
    if ([_playerViewController.delegate respondsToSelector:@selector(playerWillDownloadMedia)]) {
        [_playerViewController.delegate playerWillDownloadMedia];
    }
}

- (void)shareButtonClicked:(UIButton *)button
{
    NSLog(@"分享按钮点击");
    if ([_playerViewController.delegate respondsToSelector:@selector(playerWillShareMedia)]) {
        [_playerViewController.delegate playerWillShareMedia];
    }
}

- (void)collectButtonClicked:(UIButton *)button
{
    NSLog(@"收藏按钮点击");
    if ([_playerViewController.delegate respondsToSelector:@selector(playerWillCollectMedia)]) {
        [_playerViewController.delegate playerWillCollectMedia];
    }
}

- (void)bitRateButtonClicked:(UIButton *)button
{
    NSLog(@"显示或取消清晰度列表");
}

- (NSString *)getCurrentTitle
{
    if ([_playerViewController.datasource respondsToSelector:@selector(mediaTitleInPlayerView:)]) {
        return [_playerViewController.datasource mediaTitleInPlayerView:_playerViewController];
    }
    return @"";
}

- (NSArray *)getAnthologyDataSource
{
    if ([self.playerViewController.datasource respondsToSelector:@selector(anthologyListInPlayerView:)]) {
        return [self.playerViewController.datasource anthologyListInPlayerView:_playerViewController];
    }
    return nil;
}

- (void)anthologyViewDidSeletedRowAtIndex:(NSInteger)index
{
    if ([_playerViewController.delegate respondsToSelector:@selector(anthologyListView:didSelectedRowAtIndex:)]) {
        [_playerViewController.delegate anthologyListView:self.anthologyListView didSelectedRowAtIndex:index];
    }
}

- (void)updateStatusWithDuration:(CGFloat)duration current:(CGFloat)current
{
     [self.buttomPannelView.progessSlider setMaximumValue:duration];
     [self.buttomPannelView.progessSlider setValue:current animated:YES];
     self.buttomPannelView.timeLabel.text = [NSString stringWithFormat:@"%@ / %@",[self stringFormattedTimeFromSeconds:current] ,[self stringFormattedTimeFromSeconds:duration]];
}

- (NSString *)stringFormattedTimeFromSeconds:(NSInteger)seconds
{
    NSInteger hour = seconds/3600;
    NSInteger minute = (seconds%3600)/60;
    NSInteger second = seconds%60;
    
    NSString *timeStr = nil;
    if (0 < hour) {
        timeStr = [NSString stringWithFormat:@"%02d:%02d:%02d", hour, minute, second];
    } else {
        timeStr = [NSString stringWithFormat:@"%02d:%02d", minute, second];
    }
    
    return timeStr;
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
