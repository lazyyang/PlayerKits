//
//  ZYGesture.h
//  ZYPlayerKit
//
//  Created by YangZheng on 14/11/20.
//  Copyright (c) 2014年 YangZheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZYPanelViewController;

@interface ZYGesture : UIView

@property (nonatomic, assign) ZYPanelViewController *supperViewController;

/**
 *  初始化
 *
 *  @param frame                frame
 *  @param supperViewController supper vc
 *
 *  @return id
 */
- (id)initWithFrame:(CGRect)frame WithSupperViewController:(id)supperViewController;

@end
