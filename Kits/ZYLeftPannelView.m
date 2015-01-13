//
//  ZYLeftPannelView.m
//  ZYPlayerKit
//
//  Created by 杨争 on 14/12/14.
//  Copyright (c) 2014年 YangZheng. All rights reserved.
//

#import "ZYLeftPannelView.h"
#import "ZYPanelViewController.h"
#import "ZYPlayerViewController.h"

@interface ZYLeftPannelView ()

@property (nonatomic, strong) UIButton *downloadBtn;

@property (nonatomic, strong) UIButton *shareBtn;

@property (nonatomic, strong) UIButton *collectBtn;

@end

@implementation ZYLeftPannelView

- (void)dealloc
{
    self.downloadBtn = nil;
    self.shareBtn = nil;
    self.collectBtn = nil;
}

- (id)initWithFrame:(CGRect)frame WithSupperViewController:(id)supperViewController
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0.7f;
        _supperViewController = supperViewController;
        
        if (![_supperViewController.playerViewController isLiveType]) {
            _downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _downloadBtn.showsTouchWhenHighlighted = YES;
            _downloadBtn.backgroundColor = [UIColor blackColor];
            [_downloadBtn setImage:[UIImage imageNamed:@"landscape_cache.png"] forState:UIControlStateNormal];
            [_downloadBtn setImage:[UIImage imageNamed:@"landscape_cache_press.png"] forState:UIControlStateSelected];
            [_downloadBtn setImage:[UIImage imageNamed:@"landscape_cache_press.png"] forState:UIControlStateHighlighted];
            [_downloadBtn addTarget:supperViewController action:@selector(downloadButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_downloadBtn];
            
            _collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _collectBtn.showsTouchWhenHighlighted = YES;
            _collectBtn.backgroundColor = [UIColor blackColor];
            [_collectBtn setImage:[UIImage imageNamed:@"landscape_collect.png"] forState:UIControlStateNormal];
            [_collectBtn setImage:[UIImage imageNamed:@"landscape_collect_press.png"] forState:UIControlStateSelected];
            [_collectBtn setImage:[UIImage imageNamed:@"landscape_collect_press.png"] forState:UIControlStateHighlighted];
            [_collectBtn addTarget:supperViewController action:@selector(collectButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_collectBtn];
        }
        
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareBtn.backgroundColor = [UIColor blackColor];
        _shareBtn.showsTouchWhenHighlighted = YES;
        [_shareBtn setImage:[UIImage imageNamed:@"landscape_share.png"] forState:UIControlStateNormal];
        [_shareBtn setImage:[UIImage imageNamed:@"landscape_share_press.png"] forState:UIControlStateSelected];
        [_shareBtn setImage:[UIImage imageNamed:@"landscape_share_press.png"] forState:UIControlStateHighlighted];
        [_shareBtn addTarget:supperViewController action:@selector(shareButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_shareBtn];
    }
    return self;
}

-(void)layoutSubviews
{
    _downloadBtn.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height/3);
    _shareBtn.frame = CGRectMake(0, self.bounds.size.height/3, self.bounds.size.width, self.bounds.size.height/3);
    _collectBtn.frame = CGRectMake(0, self.bounds.size.height*2/3, self.bounds.size.width, self.bounds.size.height/3);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
