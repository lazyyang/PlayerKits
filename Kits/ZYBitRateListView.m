//
//  ZYBitRateListView.m
//  ZYPlayerKit
//
//  Created by YangZheng on 14/12/16.
//  Copyright (c) 2014年 YangZheng. All rights reserved.
//

#import "ZYBitRateListView.h"
#import "ZYPanelViewController.h"

@interface ZYBitRateListView ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation ZYBitRateListView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = self.dataArray[indexPath.row];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.supperViewController anthologyViewDidSeletedRowAtIndex:indexPath.row];
}

- (id)initWithFrame:(CGRect)frame WithSupperViewController:(id)supperViewController
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.7f;
        _supperViewController = supperViewController;
        _dataArray = [NSArray arrayWithArray:[supperViewController getAnthologyDataSource]];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.alpha = .7f;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self addSubview:_tableView];
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
