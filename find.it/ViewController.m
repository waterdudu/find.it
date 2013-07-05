//
//  ViewController.m
//  find.it
//
//  Created by dudu on 13-6-22.
//  Copyright (c) 2013年 dudu. All rights reserved.
//

#import "ViewController.h"
#import "SDSegmentedControl.h"
#import "SegmentedViewController.h"
#import "SegmentsViewController.h"
#import "UIButton+imaged.h"
#import "MovieTableViewController.h"
#import "BookTableViewController.h"
#import "MusicTableViewController.h"

#define SEGMENT_INDEX 0
#define BOOK_INDEX (SEGMENT_INDEX)
#define MUSIC_INDEX (SEGMENT_INDEX+1)
#define MOVIE_INDEX (SEGMENT_INDEX+2)

#define SEGMENT_INDEX_COUNT 10
#define TEXT_COLOR [UIColor colorWithRed:133/256.0 green:192/256.0 blue:201/256.0 alpha:1];

@interface ViewController ()
{
    SegmentsViewController * _segmentsViewController;
    
    BookTableViewController * _bookViewController;
    MusicTableViewController * _musicViewController;
    MovieTableViewController * _movieViewController;
    
    UISearchBar   * _searchBar;
    int _currentViewControllerIndex;

}

- (void)configureBookTableView;
- (void)configureMusicTableView;
- (void)configureMovieTableView;
- (void)configureTitleLabel;
- (void)configureSearchView;

- (void)showSearchBar;
- (void)showSegmentedTableView:(int)index;

// business
- (void)doSearch:(NSString *)q searchType:(int)index;

- (SegmentedViewController *)getSegmentedTableView:(int)index;

@end

@implementation ViewController

@synthesize segControl;


- (void)viewDidLoad
{
    [super viewDidLoad];
    //////////////////////////////////////////////////////////////////////////////////
    // connect segmentedcontroller with controller of segmentedcontroller
    //////////////////////////////////////////////////////////////////////////////////
    
#if 1
    [self configureBookTableView];
    [self configureMusicTableView];
    [self configureMovieTableView];
    
    [self configureSearchView];
    
    [self configureTitleLabel];
    
    _currentViewControllerIndex = 0;
#endif
    
/*
#if 0
    NSArray * viewControllers = [self segmentViewControllers];
    UINavigationController *navigationController = [[UINavigationController alloc] init];
    
    _segmentsViewController = [[SegmentsViewController alloc] initWithNavigationController:navigationController viewControllers:viewControllers];
    
    [self.view addSubview:navigationController.view];
#endif
	// Do any additional setup after loading the view, typically from a nib.

 */
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - segmentedcontrol
- (IBAction)segmentDidChange:(id)sender
{
    int index = self.segControl.selectedSegmentIndex;
    
    [_segmentsViewController indexDidChangeForSegmentedControl:self.segControl];

    [self showSegmentedTableView:index];
    
}

#pragma mark - configure book/music/movie table view
- (void)configureBookTableView
{
    _bookViewController = [[BookTableViewController alloc] initWithNibName:@"BookTableViewController" bundle:nil];
     
    // adjust height of UITableView
    
    CGRect segControlFrame = segControl.frame;
    NSLog(@"origin : x : %f, y : %f  size : width: %f, height : %f", segControlFrame.origin.x, segControlFrame.origin.y,
          segControlFrame.size.width, segControlFrame.size.height); // x:0, y:36, w:320, h:43
    
    float screenHeight = [[UIScreen mainScreen] bounds].size.height;
    float screenWidth = [[UIScreen mainScreen] bounds].size.width;
//    float offset = segControlFrame.origin.y+segControlFrame.size.height;
    
    NSLog(@"screen height : %f, width : %f", screenHeight, screenWidth);
    
//    [self.view addSubview:_bookViewController.view];
    [self.view insertSubview:_bookViewController.view belowSubview:self.segControl];
//    [self.view addSubview:_bookViewController.view];
//    _bookViewController.view.frame = CGRectMake(0, offset, screenWidth, screenHeight);
//    _bookViewController.tableView.frame = CGRectMake(0, offset, screenWidth, screenHeight);

}

- (void)configureMusicTableView
{
    _musicViewController = [[MusicTableViewController alloc] initWithNibName:@"MusicTableViewController" bundle:nil];
    
    // adjust height of UITableView
    
    CGRect segControlFrame = segControl.frame;
    
    float screenHeight = [[UIScreen mainScreen] bounds].size.height;
    float screenWidth = [[UIScreen mainScreen] bounds].size.width;
    float offset = segControlFrame.origin.y+segControlFrame.size.height;
    
    _musicViewController.view.frame = CGRectMake(0, offset, screenWidth, screenHeight);
    _musicViewController.tableView.frame = CGRectMake(0, offset, screenWidth, screenHeight);

 //   [self.view addSubview:_musicViewController.view];
    [self.view insertSubview:_musicViewController.view belowSubview:self.segControl];

    [_musicViewController.view setHidden:YES];
}


- (void)configureMovieTableView
{
    _movieViewController = [[MovieTableViewController alloc] initWithNibName:@"MovieTableViewController" bundle:nil];
    // adjust height of UITableView
    
    CGRect segControlFrame = segControl.frame;
    
    float screenHeight = [[UIScreen mainScreen] bounds].size.height;
    float screenWidth = [[UIScreen mainScreen] bounds].size.width;
    // offset = 37 + 43 = 80
    float offset = segControlFrame.origin.y+segControlFrame.size.height;

//    _movieViewController.view.frame = CGRectMake(0, offset, screenWidth, screenHeight);

    CGRect f1 = _movieViewController.view.frame;
    CGRect f2 = _movieViewController.tableView.frame;
    
    NSLog(@"#_____#  %f %f %f %f", f1.origin.x, f1.origin.y, f1.size.width, f1.size.height);
    
    NSLog(@"#_____#  %f %f %f %f", f2.origin.x, f2.origin.y, f2.size.width, f2.size.height);
    NSLog(@"OOOOOOOOOO set ; y :　%f, h : %f, offset : %f", segControlFrame.origin.y, segControlFrame.size.height, offset);
    
//    _movieViewController.tableView.frame = CGRectMake(0, offset, screenWidth, screenHeight);
    _movieViewController.tableView.frame = CGRectMake(0, offset, screenWidth, screenHeight);
//    [self.view addSubview:_movieViewController.view];
    [self.view insertSubview:_movieViewController.view belowSubview:self.segControl];

    [_movieViewController.view setHidden:YES];
}

- (void)configureSearchView
{
    UIImage *image = [UIImage imageNamed:@"search@37.png"];
    UIImage *imagePressed = [UIImage imageNamed:@"search.png"];
    float kButtonWidth = 20.0;
    float kButtonHeight = 20.0;
    
    float screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGRect buttonFrame = CGRectMake(screenWidth-kButtonWidth - 7, 7, kButtonWidth, kButtonHeight);
    
    
    UIButton *searchButton = [UIButton buttonWithTitle:@"title" target:self selector:@selector(searchButtonClicked:) frame:buttonFrame image:image imagePressed:imagePressed darkTextColor:YES];
//    self.headView.clipsToBounds = YES;
//    self.headView.userInteractionEnabled = YES;
//    [self.headView addSubview:searchButton];   // TODO:why cannot add button to headview ????
    [self.view addSubview:searchButton];
}

- (void)configureTitleLabel
{
    
    UILabel *titleLabel = [[UILabel alloc] init];
    
    NSString *title = @"find.it";
    UIFont *font =  [UIFont fontWithName:@"Helvetica" size:25.0];
    
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment   = NSTextAlignmentCenter;
    titleLabel.numberOfLines   = 0; // unlimited
    titleLabel.lineBreakMode   = NSLineBreakByWordWrapping;
    titleLabel.text            = @"find.it";
    titleLabel.shadowColor     = TEXT_COLOR;//[UIColor whiteColor];
    titleLabel.shadowOffset = CGSizeMake(0.0, 1.0);
    
    
    CGSize stringSize = [title sizeWithFont:font];
    float screenWidth = [UIScreen mainScreen].bounds.size.width;

    titleLabel.frame = CGRectMake((screenWidth - stringSize.width)/2, (37-stringSize.height)/2, stringSize.width, stringSize.height);
    titleLabel.font            = font;
    [self.view insertSubview:titleLabel aboveSubview:self.segControl];
    
}

#pragma mark - view show/hide
- (void)showSegmentedTableView:(int)index
{
    _currentViewControllerIndex = index;
    
    if (index == BOOK_INDEX) {
        [_bookViewController.view setHidden:NO];
        [_musicViewController.view setHidden:YES];
        [_movieViewController.view setHidden:YES];
    }
    else if (index == MUSIC_INDEX)
    {
        [_bookViewController.view setHidden:YES];
        [_musicViewController.view setHidden:NO];
        [_movieViewController.view setHidden:YES];
    }
    else if (index == MOVIE_INDEX)
    {
        [_bookViewController.view setHidden:YES];
        [_musicViewController.view setHidden:YES];
        [_movieViewController.view setHidden:NO];
    }
  
    /////////////////////////////////////////////////
    //   no need to call reloaddata ???
    /////////////////////////////////////////////////
    
    SegmentedViewController *currentTableView = [self getSegmentedTableView:index];
    [currentTableView.tableView reloadData];
}

- (void)showSearchBar
{
  
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]
                                    initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, 37)]; // TODO:magic number
        _searchBar.delegate = self;     // must implement UISearchBarDelegate delegate
        _searchBar.showsCancelButton = YES;
        _searchBar.showsSearchResultsButton = YES;
        _searchBar.barStyle = UIBarStyleDefault;
        _searchBar.placeholder=@"请输入搜索内容...";
        _searchBar.keyboardType=UIKeyboardTypeDefault;
        [self.view addSubview:_searchBar];
    }

    [_searchBar setHidden:NO];
}

#pragma mark - button
- (void)searchButtonClicked:(id)sender
{
    [self showSearchBar];
    // add search bar 
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [_searchBar setShowsCancelButton:YES animated:YES];
    UITableView *tableView = [self getSegmentedTableView:_currentViewControllerIndex].tableView;
    
    tableView.allowsSelection = NO;
    tableView.scrollEnabled = NO;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    _searchBar.text=@"";
    
    [_searchBar setShowsCancelButton:NO animated:YES];
    [_searchBar resignFirstResponder];
   
    UITableView *tableView = [self getSegmentedTableView:_currentViewControllerIndex].tableView;
   
    tableView.allowsSelection = YES;
    tableView.scrollEnabled = YES;
    
    // hide search bar
    [_searchBar setHidden:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    NSString *searchText = _searchBar.text;
    // do the real thing
    [self doSearch:searchText searchType:_currentViewControllerIndex];
    
    // TODO:move following codes to delegate method(load[Book/Music/Movie]Finished)
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    UITableView *tableView = [self getSegmentedTableView:_currentViewControllerIndex].tableView;
    
    tableView.allowsSelection = YES;
    tableView.scrollEnabled = YES;
	
}

#pragma mark - business
- (void)doSearch:(NSString *)q searchType:(int)index
{
    // TODO: dispatch_async
    SegmentedViewController *searchView = [self getSegmentedTableView:index];
    searchView.queryString = q;
    NSLog(@"I got search string : %@", q);
    [searchView doSearch:q tag:nil];
    
}

#pragma mark - utils (get[headerview/segcontrol] rect)

- (SegmentedViewController *)getSegmentedTableView:(int)index
{
    SegmentedViewController * result = nil;
    
    if (index == BOOK_INDEX) {
        result = _bookViewController;
    }
    else if (index == MUSIC_INDEX)
    {
        result = _musicViewController;
    }
    else if (index == MOVIE_INDEX)
    {
        result = _movieViewController;
    }
    
    return result;
}
@end
