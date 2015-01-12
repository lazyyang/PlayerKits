//
//  ZYSlider.m
//  ifengMPV7
//
//  Created by 杨争 on 8/5/14.
//  Copyright (c) 2014 v.ifeng.com. All rights reserved.
//

#import "ZYSlider.h"

@implementation ZYSlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImage *image = [UIImage imageNamed:@"landscape_volume"];
        [self setThumbImage:image forState:UIControlStateNormal];
        [self setThumbImage:image forState:UIControlStateHighlighted];
        [self setMaximumTrackImage:[UIImage imageNamed:@"mp_slider_max"]  forState:UIControlStateNormal];
        [self setMinimumTrackImage:[UIImage imageNamed:@"mp_slider_min"]  forState:UIControlStateNormal];
    }
    return self;
}

- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value
{
    CGRect thumbRect = [super thumbRectForBounds:bounds trackRect:rect value:value];
//    NSLog(@"thumbRect == %f",thumbRect.origin.x);
    if (thumbRect.origin.x > 54.5) {
        return CGRectMake(thumbRect.origin.x+7.5f, thumbRect.origin.y, thumbRect.size.width, thumbRect.size.height);
    }
    else if (thumbRect.origin.x < 0.5f){
        return CGRectMake(thumbRect.origin.x-7.5f, thumbRect.origin.y, thumbRect.size.width, thumbRect.size.height);

    }
    else{
        return CGRectMake(thumbRect.origin.x, thumbRect.origin.y, thumbRect.size.width, thumbRect.size.height);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
