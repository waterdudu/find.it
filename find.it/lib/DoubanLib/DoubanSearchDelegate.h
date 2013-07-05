//
//  DoubanMusicSearchDelegate.h
//  find.it
//
//  Created by dudu on 13-6-22.
//  Copyright (c) 2013年 dudu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DoubanMovieModel;
@class DoubanMusicModel;

@protocol DoubanSearchDelegate <NSObject>

@optional
- (void)loadMusicFinished:(NSArray *)musics withError:(NSError *)error;
- (void)loadBookFinished:(NSArray *)books withError:(NSError *)error;
- (void)loadMovieFinished:(NSArray *)movies withError:(NSError *)error;



- (void)loadMovieSubjectFinished:(DoubanMovieModel *)movieModel withError:(NSError *)error;
- (void)loadMusicSubjectFinished:(DoubanMusicModel *)musicModel withError:(NSError *)error;



@end
