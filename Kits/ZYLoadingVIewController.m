//
//  ZYLoadingVIewController.m
//  ZYPlayerKit
//
//  Created by YangZheng on 14/11/26.
//  Copyright (c) 2014年 YangZheng. All rights reserved.
//

#import "ZYLoadingVIewController.h"

#define LOGO_IMAGEVIEW_WIDTH    349.0f
#define LOGO_IMAGEVIEW_HEIGHT   109.0f
#define LOGO_IMAGEVIEW_T        37.0f
#define LOGO_IMAGEVIEW_L        0.0f
#define LOGO_IMAGEVIEW_B        51.0f
#define LOGO_IMAGEVIEW_R        0.0f

#define TITLE_LABEL_T           0.0f
#define TITLE_LABEL_L           10.0f
#define TITLE_LABEL_B           0.0f
#define TITLE_LABEL_R           0.0f

#define TITLE_LABEL_FONT [UIFont systemFontOfSize:12.0f]

@interface ZYLoadingVIewController ()

@end

@implementation ZYLoadingVIewController

- (void)dealloc
{
    self.logoImgView = nil;
    self.actiView = nil;
    self.titleLabel = nil;
    self.indicateLabel = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor blackColor];
    _logoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mp_logo.png"]];
   // _logoImgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_logoImgView];
    
    _actiView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [self.view addSubview:_actiView];
    
    _indicateLabel = [[UILabel alloc] init];
    _indicateLabel.backgroundColor = [UIColor clearColor];
    [_indicateLabel setFont:TITLE_LABEL_FONT];
    [_indicateLabel setTextColor:[UIColor whiteColor]];
    _indicateLabel.text = @"正在载入...";
    [self.view addSubview:_indicateLabel];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor = [UIColor clearColor];
    [_titleLabel setFont:TITLE_LABEL_FONT];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    [self.view addSubview:_titleLabel];

}

- (void)viewWillLayoutSubviews
{
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    CGFloat x = (width - LOGO_IMAGEVIEW_WIDTH) / 2;
    CGFloat y = (height - LOGO_IMAGEVIEW_HEIGHT) * LOGO_IMAGEVIEW_T / (LOGO_IMAGEVIEW_B + LOGO_IMAGEVIEW_T);
    self.logoImgView.frame = CGRectMake(x,
                                        y,
                                        LOGO_IMAGEVIEW_WIDTH,
                                        LOGO_IMAGEVIEW_HEIGHT);
    
    //指示标签
    CGSize size = [self.indicateLabel.text sizeWithFont:TITLE_LABEL_FONT];
    x = (width - size.width - CGRectGetWidth(self.actiView.frame) - TITLE_LABEL_L) / 2;
    x = (x < 10) ? 10 : x;
    y += (LOGO_IMAGEVIEW_HEIGHT+5);
    float dW = width - self.actiView.frame.size.width - 20 - TITLE_LABEL_L;
    size.width = size.width > dW ? dW : size.width;
    
    self.indicateLabel.frame = CGRectMake(x + CGRectGetWidth(self.actiView.frame) + TITLE_LABEL_L,
                                          y,
                                          size.width,
                                          size.height);
    
    //指示符
    CGFloat t = (size.height - CGRectGetHeight(self.actiView.frame)) / 2;
    self.actiView.frame = CGRectMake(x,
                                     y + t,
                                     CGRectGetWidth(self.actiView.frame),
                                     CGRectGetHeight(self.actiView.frame));
    
    //标题
    size = [self.titleLabel.text sizeWithFont:TITLE_LABEL_FONT];
    x = (width - size.width) / 2;
    x = (x < 10) ? 10 : x;
    y += (size.height+5);
    dW = self.view.frame.size.width - TITLE_LABEL_L;
    size.width = size.width > dW ? dW : size.width;
    
    self.titleLabel.frame = CGRectMake(x,
                                       y,
                                       size.width,
                                       size.height);
    
    [self.actiView startAnimating];
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
