//
//  ZYTopPannelView.m
//  ZYPlayerKit
//
//  Created by 杨争 on 14/12/14.
//  Copyright (c) 2014年 YangZheng. All rights reserved.
//

#import "ZYTopPannelView.h"
#import "ZYPanelViewController.h"

@interface ZYTopPannelView ()

@property (strong, nonatomic) UIButton *backButton;

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UIButton *anthologyButton;

@end

@implementation ZYTopPannelView

- (void)dealloc
{
    self.backButton = nil;
    self.titleLabel = nil;
    self.anthologyButton = nil;
}

- (id)initWithFrame:(CGRect)frame WithSupperViewController:(id)supperViewController
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _supperViewController = supperViewController;
        self.backgroundColor = [UIColor blackColor];
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"landscape_back.png"] forState:UIControlStateNormal];
        [_backButton setImage:[UIImage imageNamed:@"landscape_back_press.png"] forState:UIControlStateHighlighted];
        [_backButton addTarget:_supperViewController action:@selector(resignFullScreen:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backButton];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = [_supperViewController getCurrentTitle];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        _anthologyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_anthologyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_anthologyButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [_anthologyButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [_anthologyButton setTitle:@"选集" forState:UIControlStateNormal];
        [_anthologyButton addTarget:_supperViewController action:@selector(anthologyBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_anthologyButton];
        
        self.alpha = 0.7f;
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat space;
    if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)) {
        space = 10.0f;
    } else{
        space = 0;
    }
    self.backButton.frame = CGRectMake(0, self.bounds.size.height/2 - 37.0f/2 + space, 43.0f, 37.0f);
    self.titleLabel.frame = CGRectMake(self.bounds.size.width/2 - 100, self.bounds.size.height/2 - 40.0f/2 + space, 200, 40.0f);
    self.anthologyButton.frame = CGRectMake(self.bounds.size.width - 50, self.bounds.size.height/2 - 30.0f/2 + space, 40, 30);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
