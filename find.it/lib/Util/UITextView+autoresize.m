//
//  UITextView+autoresize.m
//  find.it
//
//  Created by dudu on 13-7-1.
//  Copyright (c) 2013年 dudu. All rights reserved.
//

#import "UITextView+autoresize.h"

#define LINE_DEFAULT_WIDTH 304
#define LINE_DEFAULT_HEIGHT 40
#define LINE_DEFAULT_MARGIN 8

#define STRING_DEFAULT_HEIGHT 30

#define TEXT_COLOR [UIColor colorWithRed:133/256.0 green:192/256.0 blue:201/256.0 alpha:1];
//#define BG_COLOR [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1]
#define BG_COLOR [UIColor colorWithRed:240/256.0 green:240/256.0 blue:242/256.0 alpha:1]
#define NAME_FONT [UIFont fontWithName:@"HelveticaNeue" size:28]
#define TEXT_FONT [UIFont fontWithName:@"HelveticaNeue" size:14]
#define NAV_TITLE_FONT [UIFont fontWithName:@"HelveticaNeue" size:18]


@implementation UITextView (autoresize)

+ (UITextView *)makeAutoResizeTextView:(NSString *)content frame:(CGRect)frame
{
    CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:14] // TEXT_FONT
                constrainedToSize:CGSizeMake(302 - 16, MAXFLOAT)
                    lineBreakMode:NSLineBreakByWordWrapping];
    
    NSLog(@">> %f %f", size.width, size.height);
    
    UITextView *tv = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 302, 20)];

    tv.text = content;
    [tv setFont:TEXT_FONT];
    tv.textColor = [UIColor blackColor];
    [tv setBackgroundColor:BG_COLOR];
    
    tv.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    tv.scrollEnabled = YES;
    tv.userInteractionEnabled = NO;
    tv.contentSize = size;
    
    //    t1.contentSize = size;
    UIEdgeInsets inset = tv.contentInset;
    //    frame.size.height = t1.contentSize.height + inset.top + inset.bottom;
    tv.frame = (CGRect){frame.origin.x,frame.origin.y,frame.size.width, size.height + inset.top + inset.bottom};
    return tv;
}
@end
