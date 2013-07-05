//
//  DDScrollView.m
//  DDScrollView
//
//  Created by dudu on 13-7-3.
//  Copyright (c) 2013年 dudu. All rights reserved.
//

#import "DDScrollView.h"

#define BOTTOM_MARGIN 100
#define RIGHT_MARGIN 0

@implementation DDScrollView
{
    CGSize _contentSize;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _contentSize = frame.size;
        self.reservedContentHeight = 0;
    }
    return self;
}

- (void)addSubview:(UIView *)view
{
    [super addSubview:view];
    
    CGRect frame = view.frame;
    CGRect selfFrame = self.frame;
    
    CGFloat height = frame.origin.y + frame.size.height;
    CGFloat width  = frame.origin.x + frame.size.width;
    
    if (height > selfFrame.size.height) {
        _contentSize.height = height;
    }
    if (width > selfFrame.size.width) {
        _contentSize.width = width;
    }
    
    self.contentSize = _contentSize;
    self.contentInset = UIEdgeInsetsMake(0, 0, BOTTOM_MARGIN + self.reservedContentHeight, RIGHT_MARGIN);
    NSLog(@"---");
    NSLog(@">>  %@", NSStringFromCGRect(frame));
    NSLog(@"##  %@", NSStringFromCGRect(self.frame));
    NSLog(@"##  %@", NSStringFromCGPoint(self.contentOffset));
    NSLog(@"##  %@", NSStringFromCGSize(self.contentSize));
    
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
