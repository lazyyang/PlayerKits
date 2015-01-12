//
//  ZYRightPannelView.m
//  ZYPlayerKit
//
//  Created by 杨争 on 14/12/14.
//  Copyright (c) 2014年 YangZheng. All rights reserved.
//

#import "ZYRightPannelView.h"
#import <MediaPlayer/MediaPlayer.h>
#import "ZYPanelViewController.h"

@interface ZYRightPannelView ()

@end

@implementation ZYRightPannelView


- (id)initWithFrame:(CGRect)frame WithSupperViewController:(id)supperViewController
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _supperViewController = supperViewController;
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.7f;
        
        _volumeSlider = [[ZYSlider alloc] init];
        self.volumeSlider.value = [MPMusicPlayerController iPodMusicPlayer].volume;
        CGAffineTransform rotation = CGAffineTransformMakeRotation(M_PI*1.5);
        [self.volumeSlider setTransform:rotation];
        [self.volumeSlider addTarget:_supperViewController action:@selector(volumnSlider:) forControlEvents:UIControlEventValueChanged];
        [self.volumeSlider addTarget:_supperViewController action:@selector(volumnSliderTouchCancel:) forControlEvents:UIControlEventTouchCancel];
        self.volumeSlider.frame = CGRectMake(0, 1, 40, 80);
        [self addSubview:self.volumeSlider];
        
        _volumeIndicateView = [[UIImageView alloc]initWithFrame:CGRectMake(0,85,40,32)];
        self.volumeIndicateView.contentMode = UIViewContentModeScaleAspectFit;
        NSString *volumeImgName = (self.volumeSlider.value > 0.5) ? @"landscape_sound"
        :((self.volumeSlider.value > 0.0)?@"landscape_sound":@"landscape_mute");
        self.volumeIndicateView.image = [UIImage imageNamed:volumeImgName];
        [self addSubview:_volumeIndicateView];
    }
    return self;
}

- (void)layoutSubviews
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
