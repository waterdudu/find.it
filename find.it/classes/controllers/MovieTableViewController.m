//
//  MovieTableViewController.m
//  find.it
//
//  Created by dudu on 13-6-23.
//  Copyright (c) 2013年 dudu. All rights reserved.
//

#import "MovieTableViewController.h"
#import "DoubanRequest.h"
#import "DoubanMovie.h"
#import "DoubanMovieTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "MovieDetailViewController.h"
#import "AppDelegate.h"
#import "SVPullToRefresh.h"


static const float kDoubanMovieTableViewCellHeight = 109.0;
static NSString * kDoubanMovieTableViewCell = @"DoubanMovieTableViewCell";

@interface MovieTableViewController ()

@end

@implementation MovieTableViewController

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
	// Do any additional setup after loading the view.
    
    UINib *nib = [UINib nibWithNibName:kDoubanMovieTableViewCell bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:kDoubanMovieTableViewCell];
    
    self.objects = [[NSMutableArray alloc] init];
    
    __weak MovieTableViewController *weakSelf = self;
    
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
    doubanRequest.delegate = self;
    [doubanRequest searchMovie:@"张艺谋" withTag:nil startFrom:0 count:20];
    self.queryString = @"张艺谋";
#endif
}

- (void)doSearch:(NSString *)q tag:(NSString *)tag
{
    [self.objects removeAllObjects];
    self.start = 0;
    // test doubanrequets search movie api
    DoubanRequest *doubanRequest = [[DoubanRequest alloc] init];
    doubanRequest.delegate = self;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    [doubanRequest searchMovie:q withTag:tag startFrom:self.start count:self.count];
    
}

#pragma mark - pull to refresh delegate method
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) addItemsOnTop
{
    [self.tableView reloadData];
    
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) addItemsOnBottom
{
     // test doubanrequets search movie api
    DoubanRequest *doubanRequest = [[DoubanRequest alloc] init];
    doubanRequest.delegate = self;
//    NSLog(@"query : %@, start : %d, count : %d", self.queryString, self.start, self.count);
    [doubanRequest searchMovie:self.queryString withTag:nil startFrom:self.start count:self.count];
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
    /*
    if (!self.detailViewController) {
        self.detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    }
    NSDate *object = _objects[indexPath.row];
    self.detailViewController.detailItem = object;
    [self.navigationController pushViewController:self.detailViewController animated:YES];
     */
    
    DoubanMovie *doubanMovie = self.objects[indexPath.row];
    
    // TODO: reuse detail view controller
    MovieDetailViewController *movieDetailVC = [[MovieDetailViewController alloc] initWithNibName:@"MovieDetailViewController" bundle:nil];
    movieDetailVC.movieId = doubanMovie.movieId;
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate.navigationController pushViewController:movieDetailVC animated:YES];


    //    [self.navigationController pushViewController:movieDetailVC animated:YES];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DoubanMovieTableViewCell";
   
    DoubanMovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[DoubanMovieTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    if (self.objects) {
        DoubanMovie *movie = [self.objects objectAtIndex:indexPath.row];
        NSString *displayTitle = movie.title;
        if (movie.year) {
            displayTitle = [NSString stringWithFormat:@"%@(%@)", movie.title, movie.year];
        }
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
    return kDoubanMovieTableViewCellHeight;
}

#pragma mark - DoubanSearchDelegate
- (void)loadMovieFinished:(NSArray *)movies withError:(NSError *)error
{
    // TODO: handle error
    [self.objects addObjectsFromArray:movies];
//    NSLog(@"movies : %d, all length : %d", [movies count], [self.objects count]);
    // self.objects = movies;
    // update start
    self.start += [movies count];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

    [self.tableView reloadData];
}


@end
