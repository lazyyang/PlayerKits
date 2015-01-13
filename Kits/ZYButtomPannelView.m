//
//  ZYButtomPannelView.m
//  ZYPlayerKit
//
//  Created by 杨争 on 14/12/14.
//  Copyright (c) 2014年 YangZheng. All rights reserved.
//

#import "ZYButtomPannelView.h"
#import "ZYPanelViewController.h"
#import "ZYPlayerViewController.h"

@interface ZYButtomPannelView ()


@end

@implementation ZYButtomPannelView

- (void)dealloc
{
    self.progessSlider = nil;
    self.playOrPauseButton = nil;
    self.playNextButton = nil;
    self.timeLabel = nil;
    self.rssButton = nil;
    self.audioButton = nil;
    self.bitRateButton = nil;
    self.fullScreenBtn = nil;
    self.lockButton = nil;
}

- (id)initWithFrame:(CGRect)frame WithSupperViewController:(id)supperViewController
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.7f;
        
        _supperViewController = supperViewController;
        
        if (![_supperViewController.playerViewController isLiveType]) {
            _progessSlider = [[ZYSlider alloc] initWithFrame:frame];
            [_progessSlider addTarget:_supperViewController action:@selector(progessSliderValueChangedEnd:) forControlEvents:UIControlEventTouchUpInside];
            [_progessSlider addTarget:_supperViewController action:@selector(progessSliderValueChangedBegin:) forControlEvents:UIControlEventTouchDown];
            [self addSubview:_progessSlider];
            
            _timeLabel = [[UILabel alloc] init];
            _timeLabel.backgroundColor = [UIColor clearColor];
            _timeLabel.textColor = [UIColor whiteColor];
            _timeLabel.text = @"00:00/00:00";
            [self addSubview:_timeLabel];
            
            _playNextButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_playNextButton setImage:[UIImage imageNamed:@"landscape_next.png"] forState:UIControlStateNormal];
            [_playNextButton setImage:[UIImage imageNamed:@"landscape_next_press.png"] forState:UIControlStateHighlighted];
            [_playNextButton addTarget:_supperViewController action:@selector(playNext:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_playNextButton];
            
            _rssButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_rssButton addTarget:_supperViewController action:@selector(rssBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [_rssButton setImage:[UIImage imageNamed:@"landscape_subscribe.png"] forState:UIControlStateNormal];
            [self addSubview:_rssButton];
        }

        
        _playOrPauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _playOrPauseButton.tag = 1;//1表示播放状态
        [_playOrPauseButton setImage:[UIImage imageNamed:@"landscape_pause.png"] forState:UIControlStateNormal];
        [_playOrPauseButton addTarget:_supperViewController action:@selector(playOrPause:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_playOrPauseButton];
        
        _fullScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fullScreenBtn setImage:[UIImage imageNamed:@"landscape_fullscreen.png"] forState:UIControlStateNormal];
        [_fullScreenBtn setImage:[UIImage imageNamed:@"landscape_fullscreen_press.png"] forState:UIControlStateHighlighted];
        [_fullScreenBtn addTarget:_supperViewController action:@selector(fullScreen:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_fullScreenBtn];
        
        _lockButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_lockButton setImage:[UIImage imageNamed:@"landscape_unlock.png"] forState:UIControlStateNormal];
        [_lockButton addTarget:_supperViewController action:@selector(lockBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_lockButton];
        
        _bitRateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bitRateButton setTitle:@"自动" forState:UIControlStateNormal];
        [_bitRateButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [_bitRateButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [_bitRateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:_bitRateButton];
        
        _audioButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_audioButton setImage:[UIImage imageNamed:@"landscape_audio.png"] forState:UIControlStateNormal];
        [_audioButton addTarget:_supperViewController action:@selector(changeMediaType:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_audioButton];

    }
    return self;
}


-(void)layoutSubviews
{
    if (UIInterfaceOrientationIsLandscape(_supperViewController.interfaceOrientation)){
    
        _progessSlider.frame = CGRectMake(10, 0, self.bounds.size.width - 20.0f, 31.0f);
        _playOrPauseButton.frame = CGRectMake(0, self.bounds.size.height - 35.0f, 44.0f, 42.0f);
        _fullScreenBtn.frame = CGRectMake(0, 0, 0, 0);
        _playNextButton.frame = CGRectMake(_playOrPauseButton.frame.origin.x + 50, _playOrPauseButton.frame.origin.y, 41.0f, 42.0f);
        _timeLabel.frame = CGRectMake(_playNextButton.frame.origin.x + 50.0f, _playNextButton.frame.origin.y - 5.0f, 200.0f, 42.0f);
        _lockButton.frame = CGRectMake(self.bounds.size.width - 50.0f, _playOrPauseButton.frame.origin.y, 49.0f, 42.0f);
        _bitRateButton.frame = CGRectMake(_lockButton.frame.origin.x - 60.0f, _playOrPauseButton.frame.origin.y-5.0f, 49.0f, 42.0f);
        _audioButton.frame = CGRectMake(_lockButton.frame.origin.x - 130.0f, _playOrPauseButton.frame.origin.y, 57.0f, 42.0f);
        _rssButton.frame = CGRectMake(_audioButton.frame.origin.x - 40.0f, _playOrPauseButton.frame.origin.y, 47.0f, 42.0f);
        

    } else{
        _progessSlider.frame = CGRectMake(50, 0, self.bounds.size.width - 100.0f, 31.0f);
        _playOrPauseButton.frame = CGRectMake(0, (self.bounds.size.height - 42.0f)/2+5.0f, 44.0f, 42.0f);
        _fullScreenBtn.frame = CGRectMake(self.bounds.size.width - 40.0f, (self.bounds.size.height - 30.0f)/2 , 30.0f , 30.0f);
        _playNextButton.frame = CGRectMake(0, 0, 0, 0);
        _timeLabel.frame = CGRectMake(0, 0, 0, 0);
        _lockButton.frame = CGRectMake(0, 0, 0, 0);
        _audioButton.frame = CGRectMake(0, 0, 0, 0);
        _rssButton.frame =  CGRectMake(0, 0, 0, 0);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
