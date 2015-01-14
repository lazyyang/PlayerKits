//
//  ZYLoadingFailedViewController.m
//  ZYPlayerKit
//
//  Created by 杨争 on 14/12/14.
//  Copyright (c) 2014年 YangZheng. All rights reserved.
//

#import "ZYLoadingFailedViewController.h"

@interface ZYLoadingFailedViewController ()

@end

@implementation ZYLoadingFailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"播放失败，点击我重试" forState:UIControlStateNormal];
    btn.bounds = CGRectMake(0, 0, 200, 100);
    btn.center = self.view.center;
    [self.view addSubview:btn];
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
