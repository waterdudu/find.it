//
//  SegmentsViewController.h
//  find.it
//
//  Created by dudu on 13-6-22.
//  Copyright (c) 2013年 dudu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentsViewController : NSObject
{
    NSArray                * viewControllers;
    UINavigationController * navigationController;
}

@property (nonatomic, strong, readonly) NSArray                * viewControllers;
@property (nonatomic, strong, readonly) UINavigationController * navigationController;

- (id)initWithNavigationController:(UINavigationController *)aNavigationController
                   viewControllers:(NSArray *)viewControllers;

- (void)indexDidChangeForSegmentedControl:(UISegmentedControl *)aSegmentedControl;

@end
