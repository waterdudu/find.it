//
//  NSDictionary+DoubanMovie.h
//  find.it
//
//  Created by dudu on 13-6-22.
//  Copyright (c) 2013年 dudu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DoubanMovie.h"
#import "DoubanMovieModel.h"
#import "DoubanMusicModel.h"
#import "DoubanMovieRating.h"
#import "DoubanMovieDirector.h"
#import "DoubanMusicRating.h"
#import "DoubanMovieCast.h"
#import "DoubanMusicModel.h"
#import "DoubanMusic.h"
#import "DoubanBook.h"

@interface NSDictionary (DoubanMovie)

- (DoubanMovieRating *)doubanMovieRating;
- (DoubanMovieRating *)doubanBookRating;
- (DoubanMusicRating *)doubanMusicRating;

- (DoubanMovie *)doubanMovie;
- (DoubanBook *)doubanBook;
- (DoubanMusic *)doubanMusic;

- (NSArray *)doubanMovies;
- (NSArray *)doubanBooks;
- (NSArray *)doubanMusics;

- (DoubanMovieModel *)doubanMovieModel;
- (DoubanMusicModel *)doubanMusicModel;
//- (DoubanBookModel *)doubanBookModel;

- (DoubanMovieDirector *)doubanMovieDirector;
- (DoubanMovieCast *)doubanMovieCast;



@end
