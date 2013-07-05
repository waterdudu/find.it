//
//  MovieDetailViewController.m
//  find.it
//
//  Created by dudu on 13-6-24.
//  Copyright (c) 2013年 dudu. All rights reserved.
//

#import "MusicDetailViewController.h"
#import "AppDelegate.h"
#import "DoubanMovieModel.h"
#import "UILabel+autoresize.h"
#import "DoubanRequest.h"

#import "UIImageView+AFNetworking.h"
#import "NSArray+DoubanMovieCasts.h"
#import "StyleDefines.h"

// adjust the height of a multi-line label to make it align vertical with top



@interface MusicDetailViewController ()
{

    UILabel *_myRatingLabel;

}

@end

@implementation MusicDetailViewController

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

    // load book item
    [self loadMusicModel];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)loadMusicModel
{
    DoubanRequest *doubanRequest = [[DoubanRequest alloc] init];
    doubanRequest.delegate = self;
    [doubanRequest loadMusicSubject:self.musicId];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES; //显示

}
- (void)addMusicModel
{
    self.authorLabel.text = [self.musicModel.author musicAuthor2NSString];
    self.ratingLabel.text    = [NSString stringWithFormat:@"%.1f", self.musicModel.rating.average];

    
    NSURL *url = [NSURL URLWithString:self.musicModel.image];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
//    [self.postImageView setImageWithURL:url placeholderImage:PLACEHOLDER_IMAGE];
    __weak UIImageView * weakImageView = self.postImageView;
    
    [self.postImageView setImageWithURLRequest:request placeholderImage:PLACEHOLDER_IMAGE success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        // adjust imageview's frame
        NSLog(@">>>>> <<<<< >>>>> <<<<< %@", NSStringFromCGRect(weakImageView.frame));
        CGSize imgSize = image.size;
        CGSize newSize = CGSizeZero;
        
        CGFloat ratio = weakImageView.frame.size.width/weakImageView.frame.size.height;
        if (imgSize.width/imgSize.height > ratio) {
            // adjust width only
            newSize = (CGSize){weakImageView.frame.size.height * ratio, weakImageView.frame.size.height};
            weakImageView.frame = (CGRect){weakImageView.frame.origin, newSize};
        }
        else{
            newSize = (CGSize){weakImageView.frame.size.width, weakImageView.frame.size.width / ratio};
            weakImageView.frame = (CGRect){weakImageView.frame.origin, newSize};
        }
        weakImageView.image = image;
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        //
    }];
}


- (void)addSummary
{
    CGRect frame = CGRectMake(LINE_DEFAULT_MARGIN, Y_BEGIN + 10, LINE_DEFAULT_WIDTH, 20);
    NSString *content = [NSString stringWithFormat:@"简介 : %@", self.musicModel.summary];
    
    UILabel *summaryLabel = [UILabel makeAutoResizeLabel:content frame:frame tag:TAG_SUMMARY];
    
    [self.scroller addSubview:summaryLabel];
}

- (void)loadMusicSubjectFinished:(DoubanMusicModel *)musicModel withError:(NSError *)error
{
    // TODO: hander error
    self.musicModel = musicModel;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    [self configureNavigationBarTitle:self.musicModel.title];
    [self addMusicModel];
    [self addSummary];

}

- (void)viewDidUnload {
    
    [self setPostImageView:nil];
    [self setAuthorLabel:nil];
    [self setGenresLabel:nil];
    [self setVersionLabel:nil];
    [self setMediaLabel:nil];
    [self setPubdateLabel:nil];
    [self setPublisherLabel:nil];
    [self setRatingLabel:nil];
    [super viewDidUnload];
}
@end
