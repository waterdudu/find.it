//
//  SegmentsViewController.m
//  find.it
//
//  Created by dudu on 13-6-22.
//  Copyright (c) 2013年 dudu. All rights reserved.
//

#import "SegmentsViewController.h"

@interface SegmentsViewController ()
@property (nonatomic, strong, readwrite) NSArray                * viewControllers;
@property (nonatomic, strong, readwrite) UINavigationController * navigationController;
@end

@implementation SegmentsViewController

@synthesize viewControllers, navigationController;

- (id)initWithNavigationController:(UINavigationController *)aNavigationController
                   viewControllers:(NSArray *)theViewControllers {
    if (self = [super init]) {
        self.navigationController = aNavigationController;
        self.viewControllers = theViewControllers;
    }
    return self;
}

- (void)indexDidChangeForSegmentedControl:(UISegmentedControl *)aSegmentedControl {
    NSUInteger index = aSegmentedControl.selectedSegmentIndex;
    UIViewController * incomingViewController = [self.viewControllers objectAtIndex:index];
    
    NSArray * theViewControllers = [NSArray arrayWithObject:incomingViewController];
    [self.navigationController setViewControllers:theViewControllers animated:NO];
    
    incomingViewController.navigationItem.titleView = aSegmentedControl;
}

- (void)dealloc {
    self.viewControllers = nil;
    self.navigationController = nil;
 
}

@end