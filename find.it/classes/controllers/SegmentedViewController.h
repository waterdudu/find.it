//
//  SegmentedTableViewController.h
//  find.it
//
//  Created by dudu on 13-6-22.
//  Copyright (c) 2013年 dudu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoubanSearchDelegate.h"

@interface SegmentedViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, DoubanSearchDelegate>


@property (nonatomic, strong) IBOutlet UITableView *tableView;


@property (strong, nonatomic) NSMutableArray *objects;
@property (nonatomic, copy)   NSString *queryString;
@property (nonatomic, assign) int start;
@property (nonatomic, assign) int count;

- (void)doSearch:(NSString *)q tag:(NSString *)tag; // start:(int)start count:(int)count;


@end
