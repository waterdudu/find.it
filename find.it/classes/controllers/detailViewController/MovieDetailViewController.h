//
//  MovieDetailViewController.h
//  find.it
//
//  Created by dudu on 13-6-24.
//  Copyright (c) 2013年 dudu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoubanMovieModel.h"
#import "DoubanDetailViewController.h"

@interface MovieDetailViewController : DoubanDetailViewController

@property (nonatomic, copy) NSString *movieId;

@property (strong, nonatomic) IBOutlet UIImageView *postImageView;
@property (strong, nonatomic) IBOutlet UILabel *directorLabel;
@property (weak, nonatomic) IBOutlet UILabel *castsLabel;
@property (weak, nonatomic) IBOutlet UILabel *genresLabel;
@property (weak, nonatomic) IBOutlet UILabel *countriesLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;


@end
