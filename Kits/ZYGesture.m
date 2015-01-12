//
//  ZYGesture.m
//  ZYPlayerKit
//
//  Created by YangZheng on 14/11/20.
//  Copyright (c) 2014年 YangZheng. All rights reserved.
//

#import "ZYGesture.h"
#import "ZYPanelViewController.h"

@implementation ZYGesture

- (id)initWithFrame:(CGRect)frame WithSupperViewController:(id)supperViewController;
{
    if (self = [super initWithFrame:frame]) {
        self.supperViewController = supperViewController;
        self.backgroundColor = [UIColor clearColor];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapClick:)];
        singleTap.numberOfTapsRequired = 1;
        singleTap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:singleTap];
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapClick:)];
        doubleTap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleTap];
        
        [singleTap requireGestureRecognizerToFail:doubleTap];
    }
    return self;
}

- (void)singleTapClick:(UITapGestureRecognizer *)tapGes
{
    if (_supperViewController.isPannelHidden) {
        if ([_supperViewController respondsToSelector:@selector(showPannelView)]) {
            [_supperViewController showPannelView];
        }
    } else{
        if ([_supperViewController respondsToSelector:@selector(hiddenPannelView)]) {
            [_supperViewController hiddenPannelView];
        }
    }
    NSLog(@"=======单击事件");
    
}

- (void)doubleTapClick:(UITapGestureRecognizer *)tapGes
{
    NSLog(@"=======双击事件");
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
