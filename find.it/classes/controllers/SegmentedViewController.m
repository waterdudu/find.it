//
//  SegmentedTableViewController.m
//  find.it
//
//  Created by dudu on 13-6-22.
//  Copyright (c) 2013年 dudu. All rights reserved.
//

#import "SegmentedViewController.h"
#import "SVPullToRefresh.h"

@interface SegmentedViewController ()
{
    
}
@end

@implementation SegmentedViewController

@synthesize objects;
@synthesize count, start;
@synthesize queryString;

#pragma mark - view did load
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.start = 0;
    self.count = 20;
    self.queryString = [[NSString alloc] init];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    CGRect frame = [UIScreen mainScreen].bounds;
    //    self.tableView.frame = CGRectMake(0, 80, frame.size.width, frame.size.height);
    self.view.frame = CGRectMake(0, 80, frame.size.width, frame.size.height);
    self.tableView.frame = CGRectMake(0, 80, frame.size.width, frame.size.height);
    NSLog(@"### %f OOOO %f", self.view.frame.origin.x, self.view.frame.origin.y);
    NSLog(@"OOO %f #### %f", self.tableView.frame.origin.x, self.tableView.frame.origin.y);
    [self.tableView triggerInfiniteScrolling];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGRect frame = [UIScreen mainScreen].bounds;
    CGFloat screenWidth = frame.size.width;
    CGFloat screenHeight = frame.size.height;
    CGFloat offset = 80;
    self.view.frame = CGRectMake(0, offset, screenWidth, screenHeight - 80);
    self.tableView.frame = CGRectMake(0, offset, screenWidth, screenHeight - 80);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doSearch:(NSString *)q tag:(NSString *)tag
{
    // subclass should implement it
}

@end
