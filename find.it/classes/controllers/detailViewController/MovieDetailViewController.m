//
//  MovieDetailViewController.m
//  find.it
//
//  Created by dudu on 13-6-24.
//  Copyright (c) 2013年 dudu. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "AppDelegate.h"
#import "DoubanMovieModel.h"

#import "UITextView+autoresize.h"

#import "DoubanRequest.h"

#import "UIImageView+AFNetworking.h"
#import "NSArray+DoubanMovieCasts.h"
#import "StyleDefines.h"
#import "UILabel+autoresize.h"

// adjust the height of a multi-line label to make it align vertical with top

@interface MovieDetailViewController ()
{
    DoubanMovieModel *_movieModel;
    UILabel *_myRatingLabel;

}

@end

@implementation MovieDetailViewController

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
    // load movie item
    [self loadMovieModel];

}

- (void)addSummary
{
    UIView *headerView = [self.scroller viewWithTag:SCROLL_HEADER_VIEW_TAG];
    
    CGRect frame = headerView.frame;
    frame = (CGRect){LINE_DEFAULT_MARGIN, frame.origin.y+frame.size.height,
                      LINE_DEFAULT_WIDTH, 20};
    
    NSString *content = [NSString stringWithFormat:@"简介 : %@", _movieModel.summary];

//    content = [NSString stringWithFormat:@"%@%@", content,content];
    UILabel *label = [UILabel makeAutoResizeLabel:content frame:frame tag:99];
    NSLog(@"~~~~~~  %@", NSStringFromCGRect(label.frame));
    [self.scroller addSubview:label];
    
}

#pragma mark - load movie model
- (void)loadMovieModel
{
    DoubanRequest *doubanRequest = [[DoubanRequest alloc] init];
    doubanRequest.delegate = self;
    [doubanRequest loadMovieSubject:self.movieId];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES; //显示
    
}
#pragma mark - DoubanSearchDelegate
- (void)loadMovieSubjectFinished:(DoubanMovieModel *)movieModel withError:(NSError *)error
{
    // TODO: hander error
    _movieModel = movieModel;

    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

    [self configureNavigationBarTitle:_movieModel.title];
    [self addMovieModel];
    [self addSummary];

}

- (void)addMovieModel
{
    self.directorLabel.text  = [_movieModel.directors directorNames];
    self.castsLabel.text     = [_movieModel.casts allCastsNames];
    self.genresLabel.text    = [_movieModel.genres genresNames];
    self.countriesLabel.text = [_movieModel.countries countriesNames];
    self.ratingLabel.text    = [NSString stringWithFormat:@"%.1f", _movieModel.rating.average];
    
    for(int i=0; i<10; i++)
        self.castsLabel.text = [self.castsLabel.text stringByAppendingString:@"\n "];
 
    NSURL *url = [NSURL URLWithString:_movieModel.imageLarge];
    [self.postImageView setImageWithURL:url placeholderImage:PLACEHOLDER_IMAGE];
}



- (void)viewDidUnload {
    
    [self setPostImageView:nil];
    [self setDirectorLabel:nil];
    [self setCastsLabel:nil];
    [self setGenresLabel:nil];
    [self setCountriesLabel:nil];
    [self setRatingLabel:nil];
    [super viewDidUnload];
}
@end
