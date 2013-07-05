//
//  UIButton+imaged.h
//  find.it
//
//  Created by dudu on 13-6-22.
//  Copyright (c) 2013年 dudu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (imaged)

+ (UIButton *)buttonWithTitle:(NSString *)title
                       target:(id)target
                     selector:(SEL)selector
                        frame:(CGRect)frame
                        image:(UIImage *)image
                 imagePressed:(UIImage *)imagePressed
                darkTextColor:(BOOL)darkTextColor;


@end
