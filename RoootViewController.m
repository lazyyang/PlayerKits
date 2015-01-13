//
//  RoootViewController.m
//  ZYPlayerKit
//
//  Created by YangZheng on 15/1/13.
//  Copyright (c) 2015年 YangZheng. All rights reserved.
//

#import "RoootViewController.h"
#import "AppDelegate.h"

@interface RoootViewController ()<PlayerEventsDelegate,PlayerDataSource>

@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation RoootViewController


-(void)makeTabBarHidden:(BOOL)hide {
    // Custom code to hide TabBar
    if ( [self.tabBarController.view.subviews count] < 2 ) {
        return;
    }
    
    UIView *contentView;
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] ) {
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    } else {
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    }
    
    if (hide) {
        contentView.frame = self.tabBarController.view.bounds;
    } else {
        contentView.frame = CGRectMake(self.tabBarController.view.bounds.origin.x,
                                       self.tabBarController.view.bounds.origin.y,
                                       self.tabBarController.view.bounds.size.width,
                                       self.tabBarController.view.bounds.size.height -
                                       self.tabBarController.tabBar.frame.size.height);
    }
    
    self.tabBarController.tabBar.hidden = hide;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    _playerVC = [[ZYPlayerViewController alloc] initWithMeidaType:VideoType];
    _playerVC.view.frame = CGRectMake(0, 40, self.view.bounds.size.width, 180);
    _playerVC.delegate = self;
    _playerVC.datasource = self;
    
    [self addChildViewController:_playerVC];
    [self.view addSubview:_playerVC.view];
    [_playerVC playFromSeconds:nil withURL:[NSURL URLWithString:@"http://ips.ifeng.com/video19.ifeng.com/video09/2014/06/13/1986101-102-1518.mp4"]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_playerVC.view removeFromSuperview];
    [_playerVC removeFromParentViewController];
    self.playerVC = nil;
}

#pragma mark -PlayerEventsDelegate
- (void)playerDidRotationPortrait
{
    [self makeTabBarHidden:NO];
    self.navigationController.navigationBar.hidden = NO;
    _playerVC.view.frame = CGRectMake(0, 40, self.view.bounds.size.width, 180);
}

- (void)playerDidRotationLandscape
{
    [self makeTabBarHidden:YES];
    [self.tabBarController.tabBar setAccessibilityElementsHidden:YES];
    self.navigationController.navigationBar.hidden = YES;
    _playerVC.view.frame = self.view.bounds;
}

- (void)playerWillPlayNextMedia
{
    NSLog(@"播放下一条");
    NSArray *array = @[@"http://ips.ifeng.com/video19.ifeng.com/video09/2014/12/16/2808803-102-1342.mp4",@"http://ips.ifeng.com/video19.ifeng.com/video09/2014/06/13/1986101-102-1518.mp4",@"http://ips.ifeng.com/video19.ifeng.com/video09/2014/12/15/2803309-102-1457.mp4",@"http://ips.ifeng.com/video19.ifeng.com/video09/2014/12/16/2808803-102-1342.mp4",@"http://ips.ifeng.com/video19.ifeng.com/video09/2014/06/13/1986101-102-1518.mp4",@"http://ips.ifeng.com/video19.ifeng.com/video09/2014/12/16/2808803-102-1342.mp4"];
    _currentIndex ++;
    if (_currentIndex >= 6) {
        _currentIndex = 0;
    }
    NSString *url = [array objectAtIndex:_currentIndex];
    [_playerVC playFromSeconds:nil withURL:[NSURL URLWithString:url]];
    
}

- (void)anthologyListView:(ZYAnthologyListView *)anthologyListView didSelectedRowAtIndex:(NSInteger)index
{
    NSLog(@"选择了第%d行",index);
    self.currentIndex = index;
    NSArray *array = @[@"http://ips.ifeng.com/video19.ifeng.com/video09/2014/12/16/2808803-102-1342.mp4",@"http://ips.ifeng.com/video19.ifeng.com/video09/2014/06/13/1986101-102-1518.mp4",@"http://ips.ifeng.com/video19.ifeng.com/video09/2014/12/15/2803309-102-1457.mp4",@"http://ips.ifeng.com/video19.ifeng.com/video09/2014/12/16/2808803-102-1342.mp4",@"http://ips.ifeng.com/video19.ifeng.com/video09/2014/06/13/1986101-102-1518.mp4",@"http://ips.ifeng.com/video19.ifeng.com/video09/2014/12/16/2808803-102-1342.mp4"];
    NSString *url = [array objectAtIndex:index];
    [_playerVC playFromSeconds:nil withURL:[NSURL URLWithString:url]];
}

- (void)playerWillRssMedia
{
    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"点击了订阅" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alerView show];
}

- (void)playerWillDownloadMedia
{
    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"点击了下载" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alerView show];
}

- (void)playerWillShareMedia
{
    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"点击了分享" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alerView show];
}

- (void)playerWillCollectMedia
{
    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"点击了收藏" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alerView show];
}

#pragma mark - PlayerViewDatasource

- (NSString *)mediaTitleInPlayerView:(ZYPlayerViewController *)player
{
    return @"凤凰XXXXX卫视";
}

- (NSArray *)anthologyListInPlayerView:(ZYPlayerViewController *)player
{
    NSArray *array = @[@"新闻1",@"新闻2",@"新闻3",@"新闻4",@"新闻5",@"新闻6"];
    return array;
}

- (BOOL)collectionStateInPlayerView:(ZYPlayerViewController *)player
{
    //返回该条节目的收藏状态
    NSArray *collectArray = @[@YES,@NO,@NO,@YES,@YES,@NO];
    return [collectArray[_currentIndex] boolValue];
}

- (BOOL)downloadStateInPlayerView:(ZYPlayerViewController *)player
{
    //返回该条节目的下载状态
    NSArray *downloadArray = @[@NO,@YES,@YES,@NO,@NO,@YES];
    return [downloadArray[_currentIndex] boolValue];
}

- (BOOL)rssStateInPlayerView:(ZYPlayerViewController *)player
{
    //返回rss状态
    NSArray *rssDownloadArray = @[@YES,@YES,@NO,@NO,@NO,@YES];
    return [rssDownloadArray[_currentIndex] boolValue];
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
