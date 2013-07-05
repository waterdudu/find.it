//
//  MusicTableViewController.m
//  find.it
//
//  Created by dudu on 13-6-23.
//  Copyright (c) 2013年 dudu. All rights reserved.
//

#import "MusicTableViewController.h"
#import "DoubanRequest.h"
#import "DoubanMusic.h"
#import "DoubanMusicTableViewCell.h"
#import "MusicDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "SVPullToRefresh.h"
#import "AppDelegate.h"

static const float kDoubanMusicTableViewCellHeight = 109.0;
static NSString * kDoubanMusicTableViewCell = @"DoubanMusicTableViewCell";


@interface MusicTableViewController ()

@end

@implementation MusicTableViewController

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
    
    UINib *nib = [UINib nibWithNibName:kDoubanMusicTableViewCell bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:kDoubanMusicTableViewCell];
    
    self.objects = [[NSMutableArray alloc] init];

    __weak MusicTableViewController *weakSelf = self;
    
    // setup pull-to-refresh
    [self.tableView addPullToRefreshWithActionHandler:^{
        //        [weakSelf insertRowAtTop];
    }];
    
    // setup infinite scrolling
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        //        [weakSelf insertRowAtBottom];
        [weakSelf addItemsOnBottom];
    }];
    
#if 1
    DoubanRequest *doubanRequest = [[DoubanRequest alloc] init];
    NSString *queryString = @"范玮琪";
    doubanRequest.delegate = self;
    [doubanRequest searchMusic:queryString withTag:nil startFrom:0 count:10];
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
    [doubanRequest searchMusic:q withTag:tag startFrom:self.start count:self.count];
    
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
    [doubanRequest searchMusic:self.queryString withTag:nil startFrom:self.start count:self.count];
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
    
    DoubanMusic *doubanMusic = self.objects[indexPath.row];
    
    // TODO: reuse detail view controller
    MusicDetailViewController *musicDetailVC = [[MusicDetailViewController alloc] initWithNibName:@"MusicDetailViewController" bundle:nil];
    musicDetailVC.musicId = doubanMusic.musicId;
    NSLog(@"~~~  %@", doubanMusic.musicId);
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate.navigationController pushViewController:musicDetailVC animated:YES];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DoubanMusicTableViewCell";
    
    DoubanMusicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[DoubanMusicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (self.objects) {
        DoubanMusic *music = [self.objects objectAtIndex:indexPath.row];
        NSString *displayTitle = music.title;
        
        cell.titleLabel.text = displayTitle;
        
        //  cell.originalTitleLabel.text = movie.original_title;
        cell.ratingLabel.text = [NSString stringWithFormat:@"%f", music.rating.average];
        [cell.thumbnailImageView setImageWithURL:[NSURL URLWithString:music.image] placeholderImage:[UIImage imageNamed:@"placeholderImage.png"]];
        
        //        cell.starRatingControl.rating = movie.rating.average / 2;
        cell.rating = music.rating.average;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kDoubanMusicTableViewCellHeight;
}

#pragma mark - DoubanSearchDelegate
- (void)loadMusicFinished:(NSArray *)musics withError:(NSError *)error
{
    // TODO: handle error
    [self.objects addObjectsFromArray:musics];
    NSLog(@"movies : %d, all length : %d", [musics count], [self.objects count]);
    // self.objects = movies;
    // update start
    self.start += [musics count];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

    [self.tableView reloadData];
    [self.tableView.infiniteScrollingView stopAnimating];

    
}



@end
