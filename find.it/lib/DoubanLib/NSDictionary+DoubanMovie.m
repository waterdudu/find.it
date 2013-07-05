//
//  NSDictionary+DoubanMovie.m
//  find.it
//
//  Created by dudu on 13-6-22.
//  Copyright (c) 2013年 dudu. All rights reserved.
//

#import "NSDictionary+DoubanMovie.h"
#import "NSArray+DoubanMovieCasts.h"


@implementation NSDictionary (DoubanMovie)

- (NSArray *)doubanMovies
{
    int count = (int)[self objectForKey:@"count"];
    
    NSMutableArray *r = [[NSMutableArray alloc] initWithCapacity:count];
    
    NSArray *movieArray = (NSArray *)[self objectForKey:@"subjects"];
    for (NSDictionary *d in movieArray) {
        [r addObject:[d doubanMovie]]; // movie call several category methods
    }
    
    return [NSArray arrayWithArray:r];  // or simple return r; // outer can modify r
}

- (NSArray *)doubanBooks
{
    int count = (int)[self objectForKey:@"count"];
    
    NSMutableArray *r = [[NSMutableArray alloc] initWithCapacity:count];
    
    NSArray *bookArray = (NSArray *)[self objectForKey:@"books"];
    for (NSDictionary *d in bookArray) {
        [r addObject:[d doubanBook]];
    }
    
    return [NSArray arrayWithArray:r];

}
- (NSArray *)doubanMusics
{
    int count = (int)[self objectForKey:@"count"];
    
    NSMutableArray *r = [[NSMutableArray alloc] initWithCapacity:count];
    
    NSArray *musicArray = (NSArray *)[self objectForKey:@"musics"];
    for (NSDictionary *d in musicArray) {
        [r addObject:[d doubanMusic]];
    }
    
    return [NSArray arrayWithArray:r];

}

- (DoubanMusic *)doubanMusic
{
    DoubanMusic *r = [[DoubanMusic alloc] init];
    r.title          = self[@"title"];
    r.alt_title      = self[@"alt_title"];
    r.image          = self[@"image"];
    r.author         = self[@"author"]; // TODO:[{name:"a1"},{},] => ["","",]
    // TODO:tags
    r.musicId        = self[@"id"];
    
    r.rating         = [self[@"rating"] doubanMusicRating];
    
    // TODO:attrs
    return r;
}

- (DoubanMusicModel *)doubanMusicModel
{
    DoubanMusicModel *r = [[DoubanMusicModel alloc] init];
    r = [self doubanMusic];
    r.summary = self[@"summary"];
    
    NSLog(@"=======    %@", self);
    NSLog(@"hhhhhhhhhhhhh          %@", self[@"summary"]);
    return r;
}
- (DoubanMovie *)doubanMovie
{
    DoubanMovie *r = [[DoubanMovie alloc] init];
    r.title          = self[@"title"];
    r.original_title = self[@"original_title"];
    r.collect_count  = (int)(self[@"coolect_count"]);
    r.subtype        = self[@"subtype"];
    r.year           = self[@"year"];
    r.alt            = self[@"alt"];
    r.movieId        = self[@"id"];
    
    r.imageSmall     = self[@"images"][@"small"];
    r.imageLarge     = self[@"images"][@"large"];
    r.imageMedium    = self[@"images"][@"medium"];
    
    r.rating         = [self[@"rating"] doubanMovieRating];
    
    return r;
}

- (DoubanBookRating *)doubanBookRating
{
    DoubanBookRating *r = [[DoubanBookRating alloc] init];
    r.max       = (int)self[@"max"];
    r.min       = (int)self[@"min"];
    r.numRaters = [self[@"numRaters"] intValue];
    r.average   = [self[@"average"] floatValue];
    return r;

}

- (DoubanBook *)doubanBook
{
    DoubanBook *r = [[DoubanBook alloc] init];
    r.title          = self[@"title"];
    //   r.original_title = self[@"original_title"];
    // r.collect_count  = (int)(self[@"coolect_count"]);
    r.alt            = self[@"alt"];
    r.bookId        = self[@"id"];
    r.author         = self[@"author"];
    r.pages          = self[@"pages"];
    
    r.imageSmall     = self[@"images"][@"small"];
    r.imageLarge     = self[@"images"][@"large"];
    r.imageMedium    = self[@"images"][@"medium"];
    
    r.pubdate        = self[@"pubdate"];
    r.rating         = (DoubanBookRating *)[self[@"rating"] doubanBookRating];
    // TODO: tags
    r.origin_title   = self[@"origin_title"];
    r.binding        = self[@"binding"];
    r.translator     = self[@"translator"];
    r.catalog        = self[@"catalog"];
    
    r.publisher      = self[@"publisher"];
    r.isbn10         = self[@"isbn10"];
    r.isbn13         = self[@"isbn13"];
    r.title          = self[@"title"];
    r.alt_title      = self[@"alt_title"];
    r.author_intro   = self[@"author_intro"];
    r.summary        = self[@"summary"];
    
    r.price          = self[@"price"];
    
    return r;
}

- (DoubanMusicRating *)doubanMusicRating
{
    DoubanMusicRating *r = [[DoubanMusicRating alloc] init];
    r.max     = (int)self[@"max"];
    r.min     = (int)self[@"min"];
    r.numRaters = (int)self[@"numRaters"];
    r.average = [self[@"average"] floatValue];
    return r;

}
- (DoubanMovieRating *)doubanMovieRating
{
    DoubanMovieRating *r = [[DoubanMovieRating alloc] init];
    r.max     = (int)self[@"max"];
    r.min     = (int)self[@"min"];
    r.stars   = [self[@"stars"] intValue];
    r.average = [self[@"average"] floatValue];
//    movieRating.average = self[@"average"];
    return r;
}


// api [book/music/movie]/subject

- (DoubanMovieModel *)doubanMovieModel
{
    DoubanMovieModel *movieModel = [[DoubanMovieModel alloc] init];
    
    // from doubanMovie method
    movieModel.title          = self[@"title"];
    movieModel.original_title = self[@"original_title"];
    movieModel.collect_count  = (int)(self[@"coolect_count"]);
    movieModel.subtype        = self[@"subtype"];
    movieModel.year           = self[@"year"];
    movieModel.alt            = self[@"alt"];
    movieModel.movieId        = self[@"id"];
//    NSLog(@">>>>>>>>>>>>> 1");
    
    movieModel.imageSmall     = self[@"images"][@"small"];
    movieModel.imageLarge     = self[@"images"][@"large"];
    movieModel.imageMedium    = self[@"images"][@"medium"];
//    NSLog(@">>>>>>>>>>>>> 2");
    
    movieModel.rating         = [self[@"rating"] doubanMovieRating];
    
    // new
//    movieModel.casts          = self[@"casts"];
    movieModel.genres         = self[@"genres"];
    movieModel.countries      = self[@"countries"];

    movieModel.casts          = [(NSArray *)self[@"casts"] doubanMovieCasts];

    // convert to directos
    movieModel.directors      = [(NSArray *)self[@"directors"] doubanMovieDirectors];
    
    movieModel.summary        = self[@"summary"];
    movieModel.comments_count = [self[@"comments_count"] intValue];
    movieModel.ratings_count  = [self[@"ratings_count"] intValue];
    
    return movieModel;
}

- (DoubanMovieCast *)doubanMovieCast
{
    DoubanMovieCast *cast = [[DoubanMovieCast alloc] init];
    cast.name     = self[@"name"];
    cast.peopleId = self[@"id"];
    cast.alt      = self[@"alt"];
//    if (self[@"avatars"] != [NSNull null]) {
    if (self[@"avatars"] != [NSNull null]) {
        cast.avatarsLarge  = self[@"avatars"][@"large"];
        cast.avatarsSmall  = self[@"avatars"][@"small"];
        cast.avatarsMedium = self[@"avatars"][@"medium"];
    }
    
    return cast;
}

- (DoubanMovieDirector *)doubanMovieDirector
{
    DoubanMovieDirector *d = [[DoubanMovieDirector alloc] init];
    d.name     = self[@"name"];
    d.peopleId = self[@"id"];  // this could be nil
    d.alt      = self[@"alt"]; // this could be nil
    if (self[@"avatars"] != [NSNull null]) {
        d.avatarsLarge  = self[@"avatars"][@"large"];  // could be nil
        d.avatarsSmall  = self[@"avatars"][@"small"];  // could be nil
        d.avatarsMedium = self[@"avatars"][@"medium"]; // could be nil
    }
    return d;
}



@end
