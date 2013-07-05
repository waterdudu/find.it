//
//  BookTableViewController.m
//  find.it
//
//  Created by dudu on 13-6-23.
//  Copyright (c) 2013年 dudu. All rights reserved.
//


#import "BookTableViewController.h"
#import "DoubanRequest.h"
#import "DoubanBook.h"
#import "DoubanBookTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "SVPullToRefresh.h"
#import "BookDetailViewController.h"
#import "AppDelegate.h"

static const float kDoubanBookTableViewCellHeight = 109.0;
static NSString * kDoubanBookTableViewCell = @"DoubanBookTableViewCell";

@interface BookTableViewController ()
{
}
@end

@implementation BookTableViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UINib *nib = [UINib nibWithNibName:kDoubanBookTableViewCell bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:kDoubanBookTableViewCell];
    
    self.objects = [[NSMutableArray alloc] init];
    
    
    __weak BookTableViewController *weakSelf = self;
    

    [self.tableView addPullToRefreshWithActionHandler:^{

    }];
    

    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf addItemsOnBottom];
    }];
    

#if 1
    DoubanRequest *doubanRequest = [[DoubanRequest alloc] init];
    NSString *queryString = @"村上春树";
    doubanRequest.delegate = self;
    [doubanRequest searchBook:queryString withTag:nil startFrom:0 count:20];
    self.queryString = queryString;
#endif
}

- (void)doSearch:(NSString *)q tag:(NSString *)tag
{

    [self.objects removeAllObjects];
    self.start = 0;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    DoubanRequest *doubanRequest = [[DoubanRequest alloc] init];
    doubanRequest.delegate = self;
    [doubanRequest searchBook:q withTag:tag startFrom:self.start count:self.count];
    
}

#pragma mark - pull to refresh delegate method
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) addItemsOnTop
{
    [self.tableView reloadData];
    
    // Call this to indicate that we have finished "refreshing".
    // This will then result in the headerView being unpinned (-unpinHeaderView will be called).

}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) addItemsOnBottom
{
    // test doubanrequets search movie api
    DoubanRequest *doubanRequest = [[DoubanRequest alloc] init];
    doubanRequest.delegate = self;
    NSLog(@"query : %@, start : %d, count : %d", self.queryString, self.start, self.count);
    [doubanRequest searchBook:self.queryString withTag:nil startFrom:self.start count:self.count];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.objects)
        return self.objects.count;
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DoubanBook *doubanBook = self.objects[indexPath.row];
    
    // TODO: reuse detail view controller
    BookDetailViewController *bookDetailVC = [[BookDetailViewController alloc] initWithNibName:@"BookDetailViewController" bundle:nil];
    bookDetailVC.bookModel = doubanBook;
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate.navigationController pushViewController:bookDetailVC animated:YES];

}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DoubanBookTableViewCell";
    
    DoubanBookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[DoubanBookTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (self.objects) {
        DoubanBook *movie = [self.objects objectAtIndex:indexPath.row];
        NSString *displayTitle = movie.title;
       
        cell.titleLabel.text = displayTitle;
        
        //  cell.originalTitleLabel.text = movie.original_title;
        cell.ratingLabel.text = [NSString stringWithFormat:@"%f", movie.rating.average];
        [cell.thumbnailImageView setImageWithURL:[NSURL URLWithString:movie.imageSmall] placeholderImage:[UIImage imageNamed:@"placeholderImage.png"]];
        
        //        cell.starRatingControl.rating = movie.rating.average / 2;
        cell.rating = movie.rating.average;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kDoubanBookTableViewCellHeight;
}

#pragma mark - DoubanSearchDelegate
- (void)loadBookFinished:(NSArray *)books withError:(NSError *)error
{
    if (error) {
        NSLog(@"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    }
    // TODO: handle error
    [self.objects addObjectsFromArray:books];
    NSLog(@"movies : %d, all length : %d", [books count], [self.objects count]);
    // self.objects = movies;
    // update start
    self.start += [books count];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.tableView reloadData];
    [self.tableView.infiniteScrollingView stopAnimating];


}



@end
