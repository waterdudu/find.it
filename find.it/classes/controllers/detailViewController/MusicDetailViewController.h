//
//  MovieDetailViewController.h
//  find.it
//
//  Created by dudu on 13-6-24.
//  Copyright (c) 2013年 dudu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoubanSearchDelegate.h"
#import "DoubanDetailViewController.h"
#import "DoubanMusicModel.h"

@interface MusicDetailViewController : DoubanDetailViewController

@property (nonatomic, copy) NSString *musicId;
@property (nonatomic, strong) DoubanMusicModel *musicModel;


@property (strong, nonatomic) IBOutlet UIImageView *postImageView;

@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *genresLabel;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UILabel *mediaLabel;
@property (weak, nonatomic) IBOutlet UILabel *pubdateLabel;
@property (weak, nonatomic) IBOutlet UILabel *publisherLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@end
