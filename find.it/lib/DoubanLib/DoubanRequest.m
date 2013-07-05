//
//  DoubanRequest.m
//  find.it
//
//  Created by dudu on 13-6-22.
//  Copyright (c) 2013年 dudu. All rights reserved.
//

#import "DoubanRequest.h"
#import "DoubanAPISearch.h"
#import "AFJSONRequestOperation.h"
#import "NSDictionary+DoubanMovie.h"
//#import "DoubanMusicModel.h"
@implementation DoubanRequest


- (void)searchMusic:(NSString *)q withTag:(NSString *)tag startFrom:(int)start count:(int)count
{
    NSString *musicURL = [NSString stringWithFormat:@"%@?q=%@&start=%d&count=%d",
                         kMusicSearchURL,
                         [q stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                         start, count];
    
    NSURL *url = [NSURL URLWithString:musicURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    __block NSArray *musics = nil;
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            // convert json to array of movies
            // TODO: use RestKit API
            NSDictionary *musicDict = (NSDictionary *)JSON;
            // NSLog(@"%@", movieDict);
            musics = [musicDict doubanMusics];
            // call delegate method, pass movies to delegate (ViewController)
            if (self.delegate) {
                dispatch_async(mainQueue, ^() {
                    [self.delegate loadMusicFinished:musics withError:nil];
                });
            }
        }
        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            if (self.delegate) {
                dispatch_async(mainQueue, ^() {
                    [self.delegate loadMusicFinished:musics withError:error];
                });
            }
        }];
    
    [operation start];
    

}

- (void)searchBook:(NSString *)q withTag:(NSString *)tag startFrom:(int)start count:(int)count
{
    NSString *bookURL = [NSString stringWithFormat:@"%@?q=%@&start=%d&count=%d",
                          kBookSearchURL,
                          [q stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                          start, count];
    
    NSURL *url = [NSURL URLWithString:bookURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    __block NSArray *books = nil;
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            // convert json to array of movies
            // TODO: use RestKit API
            NSDictionary *bookDict = (NSDictionary *)JSON;
            // NSLog(@"%@", movieDict);
            books = [bookDict doubanBooks];
            // call delegate method, pass movies to delegate (ViewController)
            if (self.delegate) {
                dispatch_async(mainQueue, ^() {
                    [self.delegate loadBookFinished:books withError:nil];
                });
            }
        }

        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            if (self.delegate) {
                dispatch_async(mainQueue, ^() {
                    [self.delegate loadBookFinished:books withError:error];
                });
            }
        }];

    [operation start];

}

- (void)searchMovie:(NSString *)q withTag:(NSString *)tag startFrom:(int)start count:(int)count
{
    NSString *movieURL = [NSString stringWithFormat:@"%@?q=%@&start=%d&count=%d",
                          kMovieSearchURL,
                          [q stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                          start, count];
    
    NSURL *url = [NSURL URLWithString:movieURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    __block NSArray *movies = nil;
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            // convert json to array of movies
            // TODO: use RestKit API
            NSDictionary *movieDict = (NSDictionary *)JSON;
           // NSLog(@"%@", movieDict);
            movies = [movieDict doubanMovies];
            // call delegate method, pass movies to delegate (ViewController)
            if (self.delegate) {
//                dispatch_async(mainQueue, ^() {
                    [self.delegate loadMovieFinished:movies withError:nil];
//                });
            }
        }
     
        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            /////////////////////////////////////////////////
            //          NSError => string
            /////////////////////////////////////////////////
            // [NSString stringWithFormat:@"%@",error]
            if (self.delegate) {
                dispatch_async(mainQueue, ^() {
                    [self.delegate loadMovieFinished:nil withError:error];
                });
            }
        }];
 
    [operation start];
}

- (void)loadMovieSubject:(NSString *)movieId
{
    NSString *movieSubjectURL = [NSString stringWithFormat:@"%@%@",
                          kMovieSubjectURL, movieId];
                       
    
    NSURL *url = [NSURL URLWithString:movieSubjectURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    __block DoubanMovieModel *movieModel = nil;
  
    
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
 
            NSDictionary *movieSubjectDict = (NSDictionary *)JSON;
            movieModel = [movieSubjectDict doubanMovieModel];
         
            // call delegate method, pass movies to delegate (ViewController)
            if (self.delegate) {
 
                dispatch_async(dispatch_get_main_queue(), ^() {
                    [self.delegate loadMovieSubjectFinished:movieModel withError:nil];
                });
            }
        }

        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
 
            /////////////////////////////////////////////////
            //          NSError => string
            /////////////////////////////////////////////////
            if (self.delegate) {
                 dispatch_async(dispatch_get_main_queue(), ^() {
                    [self.delegate loadMovieSubjectFinished:nil withError:error];
                });
            }
        }];
    
    [operation start];

}

- (void)loadBookSubject:(NSString *)bookId
{}

- (void)loadMusicSubject:(NSString *)musicId
{
    NSString *musicSubjectURL = [NSString stringWithFormat:@"%@%@",
                                 kMusicSubjectURL, musicId];
    
    
    NSURL *url = [NSURL URLWithString:musicSubjectURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    __block DoubanMusicModel *model = nil;
    
    
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            
            NSDictionary *musicSubjectDict = (NSDictionary *)JSON;
            model = [musicSubjectDict doubanMusicModel];
            
            // call delegate method, pass movies to delegate (ViewController)
            if (self.delegate) {
                
                dispatch_async(dispatch_get_main_queue(), ^() {
                    [self.delegate loadMusicSubjectFinished:model withError:nil];
                });
            }
        }

        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            
            /////////////////////////////////////////////////
            //          NSError => string
            /////////////////////////////////////////////////
            if (self.delegate) {
                dispatch_async(dispatch_get_main_queue(), ^() {
                    [self.delegate loadMusicSubjectFinished:nil withError:error];
                });
            }
        }];
    
    [operation start];

}

@end
