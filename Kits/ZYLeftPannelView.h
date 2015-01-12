//
//  ZYLeftPannelView.h
//  ZYPlayerKit
//
//  Created by 杨争 on 14/12/14.
//  Copyright (c) 2014年 YangZheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZYPanelViewController;

@interface ZYLeftPannelView : UIView

/**
 *  初始化
 *
 *  @param frame                frame
 *  @param supperViewController 父类
 *
 *  @return id
 */
- (id)initWithFrame:(CGRect)frame WithSupperViewController:(id)supperViewController;

/**
 *  父类VC
 */
@property (nonatomic, assign) ZYPanelViewController *supperViewController;

@end
