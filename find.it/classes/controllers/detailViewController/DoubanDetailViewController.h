//
//  DoubanDetailViewController.h
//  find.it
//
//  Created by dudu on 13-7-5.
//  Copyright (c) 2013年 dudu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDScrollView.h"
#import "DoubanSearchDelegate.h"

@interface DoubanDetailViewController : UIViewController<DoubanSearchDelegate>

@property (nonatomic, weak) IBOutlet DDScrollView *scroller;


- (void)configureNavigationBarTitle:(NSString *)title;

@end
