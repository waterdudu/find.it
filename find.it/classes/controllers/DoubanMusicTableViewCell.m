//
//  DoubanMovieTableViewCell.m
//  find.it
//
//  Created by dudu on 13-6-23.
//  Copyright (c) 2013年 dudu. All rights reserved.
//

#import "DoubanMusicTableViewCell.h"
//#import "DLStarRatingControl.h"
@interface DoubanMusicTableViewCell()
{
}

@property (nonatomic, strong) DLStarRatingControl *starRatingControl;
@end

@implementation DoubanMusicTableViewCell


@synthesize titleLabel, ratingLabel, thumbnailImageView;
@synthesize rating;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
//    CGRect frame = self.starRatingControl.frame;
    if (!self.starRatingControl) {
        [self configureStarRatingView];
      }
    self.starRatingControl.rating = self.rating / 2.0;
    
#if 0
//    self.starRatingControl.isFractionalRatingEnabled = YES;
    // Custom Number of Stars
 
    NSLog(@" ##  %f %f %f %f", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
/*
    // Set Custom Stars
    [self.starRatingControl setStar:nil highlightedStar:[UIImage imageNamed:@"star_highlighted-darker.png"] atIndex:0];
    [self.starRatingControl setStar:nil highlightedStar:[UIImage imageNamed:@"star_highlighted-darker.png"] atIndex:2];
    [self.starRatingControl setStar:nil highlightedStar:[UIImage imageNamed:@"star_highlighted-darker.png"] atIndex:4];
    */
//    self.starRatingControl.backgroundColor = [UIColor lightGrayColor];
    self.starRatingControl.backgroundColor = [UIColor clearColor];
    self.starRatingControl.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    self.starRatingControl.rating = self.rating/2.0;


    //
#endif
}

- (void)configureStarRatingView
{
    CGRect frame = CGRectMake(self.titleLabel.frame.origin.x - 8, self.thumbnailImageView.frame.origin.y+self.thumbnailImageView.frame.size.height - 25,112, 25);
    
    // Initialization code
    self.starRatingControl = [[DLStarRatingControl alloc] initWithFrame:frame andStars:5 isFractional:YES];
    //    self.starRatingControl.delegate = self;
    self.starRatingControl.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.starRatingControl.autoresizingMask =  //UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    [self.contentView addSubview:self.starRatingControl];
}

@end
