//
//  MovieDetailViewController.h
//  find.it
//
//  Created by dudu on 13-6-24.
//  Copyright (c) 2013年 dudu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoubanBook.h"
#import "DoubanSearchDelegate.h"
#import "DoubanDetailViewController.h"

@interface BookDetailViewController : DoubanDetailViewController

@property (nonatomic, copy) NSString *bookId;
@property (nonatomic, strong) DoubanBook *bookModel;

@property (strong, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *publisherLabel;
@property (weak, nonatomic) IBOutlet UILabel *originTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *translatorLabel;
@property (weak, nonatomic) IBOutlet UILabel *pubdateLabel;
@property (weak, nonatomic) IBOutlet UILabel *pagesLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *authIntroLabel;

@end
