//
//  ZYBitRateListView.h
//  ZYPlayerKit
//
//  Created by YangZheng on 14/12/16.
//  Copyright (c) 2014年 YangZheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZYPanelViewController;

@interface ZYBitRateListView : UIView

@property (nonatomic, assign) ZYPanelViewController *supperViewController;

/**
 *  初始化
 *
 *  @param frame
 *  @param supperViewController
 *
 *  @return id
 */
- (id)initWithFrame:(CGRect)frame WithSupperViewController:(id)supperViewController;

@end
