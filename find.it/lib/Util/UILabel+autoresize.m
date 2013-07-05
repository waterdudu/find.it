//
//  UILabel+autoresize.m
//  find.it
//
//  Created by dudu on 13-7-1.
//  Copyright (c) 2013年 dudu. All rights reserved.
//

#import "UILabel+autoresize.h"

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



@implementation UILabel (autoresize)

+ (UILabel *)makeAutoResizeLabel:(NSString *)content frame:(CGRect)frame tag:(NSInteger)tag
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.font = TEXT_FONT;
    label.tag = tag;
    label.numberOfLines = 0;
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentLeft;
    [label setBackgroundColor:BG_COLOR];
    

    CGSize size = [content sizeWithFont:label.font constrainedToSize:CGSizeMake(label.frame.size.width, CGFLOAT_MAX) lineBreakMode:
                   NSLineBreakByWordWrapping
                   //NSLineBreakByCharWrapping
                   ];
   
    NSLog(@"YYY %f", size.height);
    frame.size.height = size.height;
    [label setFrame:frame];
    label.text = content;
    
    NSLog(@">> OOOO << %@", NSStringFromCGRect(frame));
    
    
    return label;
}

@end
