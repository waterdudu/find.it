//
//  DoubanMovieTableViewCell.h
//  find.it
//
//  Created by dudu on 13-6-23.
//  Copyright (c) 2013年 dudu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLStarRatingControl.h"

@interface DoubanMovieTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *originalTitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *ratingLabel;
@property (nonatomic, strong) IBOutlet UIImageView *thumbnailImageView;
//@property (nonatomic, strong) IBOutlet DLStarRatingControl *starRatingControl;


@property (nonatomic, assign) float rating;

@end
