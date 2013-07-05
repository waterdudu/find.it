//
//  DoubanMovieModel.h
//  find.it
//
//  Created by dudu on 13-6-24.
//  Copyright (c) 2013年 dudu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DoubanMovieRating.h"

@interface DoubanMovieModel : NSObject

// copy from DoubanMovie class
@property (nonatomic, strong) DoubanMovieRating * rating;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, assign) int collect_count;
@property (nonatomic, copy) NSString * original_title;
@property (nonatomic, copy) NSString * subtype;
@property (nonatomic, copy) NSString * year;
@property (nonatomic, copy) NSString *alt;
@property (nonatomic, copy) NSString *movieId; // id in json

@property (nonatomic, copy) NSString *imageSmall;
@property (nonatomic, copy) NSString *imageLarge;
@property (nonatomic, copy) NSString *imageMedium;

// new from api.douban.com/v2/movie/subject/id
@property (nonatomic, assign) int wish_count;
@property (nonatomic, copy) NSString *douban_site;
@property (nonatomic, copy) NSString *mobile_url;
@property (nonatomic, assign) int do_count;
@property (nonatomic, assign) int season_count;
@property (nonatomic, copy) NSString *schedule_url;
@property (nonatomic, assign) int episodes_count;

@property (nonatomic, strong) NSArray *genres;
@property (nonatomic, strong) NSArray *countries;

@property (nonatomic, strong) NSArray *casts; // [{avatars:{small:''},alt:'',id:'',name:''}, {}]
@property (nonatomic, strong) NSArray *directors;


@property (nonatomic, copy) NSString *summary;
@property (nonatomic, assign) int comments_count;
@property (nonatomic, assign) int ratings_count;


@end
