//
//  MovieDetailViewController.m
//  find.it
//
//  Created by dudu on 13-6-24.
//  Copyright (c) 2013年 dudu. All rights reserved.
//

#import "BookDetailViewController.h"
#import "AppDelegate.h"
#import "DoubanMovieModel.h"

#import "UILabel+autoresize.h"
#import "UITextView+autoresize.h"


#import "DoubanRequest.h"

#import "UIImageView+AFNetworking.h"
#import "NSArray+DoubanMovieCasts.h"
#import "StyleDefines.h"

@interface BookDetailViewController ()
{
    UILabel *_myRatingLabel;

}

@end

@implementation BookDetailViewController

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
    [self loadBookModel];
   
}

#pragma mark - book box


- (void)addBookSummary
{

    CGRect frame = CGRectMake(LINE_DEFAULT_MARGIN, Y_BEGIN + 10, LINE_DEFAULT_WIDTH, 20);
    NSString *content = [NSString stringWithFormat:@"简介 : %@", self.bookModel.summary];

    self.summaryLabel = [UILabel makeAutoResizeLabel:content frame:frame tag:TAG_SUMMARY];
  
    [self.scroller addSubview:self.summaryLabel];    
}
- (void)addAuthorIntro
{
 
    CGRect frame = self.summaryLabel.frame;
    CGRect authFrame = (CGRect){frame.origin.x, frame.origin.y+frame.size.height,frame.size.width,20};
    
    NSString *author_intro = [NSString stringWithFormat:@"\n作者简介 : %@", self.bookModel.author_intro];
    self.authIntroLabel = [UILabel makeAutoResizeLabel:author_intro frame:authFrame tag:TAG_SUMMARY];
    [self.scroller addSubview:self.authIntroLabel];
    
}

#pragma mark - load book model
- (void)loadBookModel
{
    // do nothing, use bookmodel
    self.authorLabel.text = [self.bookModel.author arrayToNSString];
    self.publisherLabel.text = self.bookModel.publisher;
    self.originTitleLabel.text = self.bookModel.origin_title;
    self.translatorLabel.text = [self.bookModel.translator arrayToNSString];
    self.pubdateLabel.text = self.bookModel.pubdate;
    self.pagesLabel.text = self.bookModel.pages;
    
    self.ratingLabel.text = [NSString stringWithFormat:@"%.1f", self.bookModel.rating.average];
    
    
    NSURL *url = [NSURL URLWithString:self.bookModel.imageLarge];
    [self.postImageView setImageWithURL:url placeholderImage:PLACEHOLDER_IMAGE];
    
    [self configureNavigationBarTitle:self.bookModel.title];

    ////////////////////////////////////////
    //  add summary
    ////////////////////////////////////////
    
    [self addBookSummary];
    [self addAuthorIntro];
    
}

- (void)viewDidUnload {
    
    [self setPostImageView:nil];
    [self setRatingLabel:nil];
    [self setAuthorLabel:nil];
    [self setPublisherLabel:nil];
    [self setOriginTitleLabel:nil];
    [self setTranslatorLabel:nil];
    [self setPubdateLabel:nil];
    [self setPagesLabel:nil];
    [self setRatingLabel:nil];
    [super viewDidUnload];
}
@end
