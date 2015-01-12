//
//  ZYTopPannelView.h
//  ZYPlayerKit
//
//  Created by 杨争 on 14/12/14.
//  Copyright (c) 2014年 YangZheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZYPanelViewController;

@interface ZYTopPannelView : UIView

@property (nonatomic, assign) ZYPanelViewController *supperViewController;

- (id)initWithFrame:(CGRect)frame WithSupperViewController:(id)supperViewController;

@end
