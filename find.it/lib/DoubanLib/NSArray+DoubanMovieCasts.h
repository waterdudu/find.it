//
//  NSArray+DoubanMovieCasts.h
//  find.it
//
//  Created by dudu on 13-6-24.
//  Copyright (c) 2013年 dudu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (DoubanMovieCasts)

- (NSArray *)doubanMovieCasts;

- (NSArray *)doubanMovieDirectors;



- (NSString *)directorNames;

- (NSString *)genresNames;
- (NSString *)countriesNames;
- (NSString *)allCastsNames;

- (NSArray *)nameArray;

- (NSString *)arrayToNSString;
- (NSString *)musicAuthor2NSString;

@end
