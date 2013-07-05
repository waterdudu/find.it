//
//  NSArray+DoubanMovieCasts.m
//  find.it
//
//  Created by dudu on 13-6-24.
//  Copyright (c) 2013年 dudu. All rights reserved.
//

#import "NSArray+DoubanMovieCasts.h"
#import "NSDictionary+DoubanMovie.h"

@implementation NSArray (DoubanMovieCasts)

// not used
- (NSArray *)doubanMovieCasts
{
    NSMutableArray *casts = [[NSMutableArray alloc] init];
    for (NSDictionary *d in self)
    {
        [casts addObject:[d doubanMovieCast]];
    }
    
    return casts;
}

- (NSArray *)doubanMovieDirectors
{
    NSMutableArray *r = [[NSMutableArray alloc] init];
    
    for (NSDictionary *d in self) {
        [r addObject:[d doubanMovieDirector]];
    }
    return r;
}

- (NSString *)directorNames
{
    NSMutableString *names = [[NSMutableString alloc] init];
    for (DoubanMovieDirector *d in self) {
        [names appendString:d.name];
        NSLog(@"#######  %@", d.name);
        [names appendString:@"，"];
    }
    if (names.length > 1) {
        return [names substringToIndex:names.length - 1];
    }
    return names; // empty string
    
}

- (NSArray *)nameArray
{
    NSMutableArray * r = [[NSMutableArray alloc] initWithCapacity:[self count]];
    
    for (DoubanMovieDirector *d in self) {
        [r addObject:d.name];
    }
    
    return [NSArray arrayWithArray:r];
}

- (NSString *)countriesNames
{
    NSMutableString *names = [[NSMutableString alloc] init];
    
    for (NSString *name in self) {
        [names appendString:name];
        [names appendString:@","];
    }
    if (names.length > 1) {
        return [names substringToIndex:names.length - 1];
    }
    return names; // empty string
    
}

- (NSString *)genresNames
{
    NSMutableString *names = [[NSMutableString alloc] init];
    
    for (NSString *name in self) {
        [names appendString:name];
        [names appendString:@","];
    }
    
    if (names.length > 1) {
        return [names substringToIndex:names.length - 1];
    }
    return names; // empty string
    
}

// deprecated
- (NSString *)allCastsNames
{
    NSMutableString *names = [[NSMutableString alloc] init];
    
    for (DoubanMovieCast *cast in self) {
        [names appendString:cast.name];
        [names appendString:@","];
    }
    if (names.length > 1) {
        return [names substringToIndex:names.length - 1];
    }
    return names; // empty string
 
}

- (NSString *)musicAuthor2NSString
{
    NSMutableString *r = [[NSMutableString alloc] init];
    
    for (NSDictionary *d in self) {
        [r appendString:d[@"name"]];
        [r appendString:@","];
    }
    if (r.length > 1) {
        return [r substringToIndex:r.length - 1];
    }
    return r; // empty string

}

- (NSString *)arrayToNSString
{
    NSMutableString *r = [[NSMutableString alloc] init];
    
    for (NSString *s in self) {
        [r appendString:s];
        [r appendString:@","];
    }
    if (r.length > 1) {
        return [r substringToIndex:r.length - 1];
    }
    return r; // empty string
}
@end
