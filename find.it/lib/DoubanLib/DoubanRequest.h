//
//  DoubanRequest.h
//  find.it
//
//  Created by dudu on 13-6-22.
//  Copyright (c) 2013年 dudu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DoubanSearchDelegate.h"

@interface DoubanRequest : NSObject
{
    
    //    __unsafe_unretained id<DoubanSearchDelegate> _delegate;
}

// for ios < 5, use unsafe_unretained
//@property (nonatomic, unsafe_unretained) id<DoubanSearchDelegate> delegate;
@property (nonatomic, weak) id<DoubanSearchDelegate> delegate;

- (void)searchMusic:(NSString *)q
            withTag:(NSString *)tag
          startFrom:(int)start
              count:(int)count;

- (void)searchBook:(NSString *)q
           withTag:(NSString *)tag
         startFrom:(int)start
             count:(int)count;




- (void)searchMovie:(NSString *)q
            withTag:(NSString *)tag
          startFrom:(int)start
              count:(int)count;

- (void)loadBookSubject:(NSString *)bookId;
- (void)loadMusicSubject:(NSString *)musicId;
- (void)loadMovieSubject:(NSString *)movieId;



@end
