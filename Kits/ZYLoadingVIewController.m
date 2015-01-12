//
//  ZYLoadingVIewController.m
//  ZYPlayerKit
//
//  Created by YangZheng on 14/11/26.
//  Copyright (c) 2014年 YangZheng. All rights reserved.
//

#import "ZYLoadingVIewController.h"

@interface ZYLoadingVIewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ZYLoadingVIewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor blackColor];
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mp_logo.png"]];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_imageView];
}

- (void)viewWillLayoutSubviews
{
    _imageView.frame = self.view.bounds;

//    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)){
//        
//        _imageView.frame = self.view.bounds;
//
//    } else{
//        _imageView.frame = self.view.bounds;
//
//    }
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
