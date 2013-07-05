//
//  UITextView+autoresize.h
//  find.it
//
//  Created by dudu on 13-7-1.
//  Copyright (c) 2013年 dudu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (autoresize)

+ (UITextView *)makeAutoResizeTextView:(NSString *)content frame:(CGRect)frame;


@end
