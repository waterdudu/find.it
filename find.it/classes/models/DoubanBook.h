//
//  DoubanBook.h
//  find.it
//
//  Created by dudu on 13-6-28.
//  Copyright (c) 2013年 dudu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DoubanBookRating.h"

@interface DoubanBook : NSObject

@property (nonatomic, strong) DoubanBookRating *rating;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *pubdate;
@property (nonatomic, strong) NSArray *author;

@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, copy) NSString *origin_title;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *binding;
@property (nonatomic, strong) NSArray *translator;

@property (nonatomic, copy) NSString *catalog;
@property (nonatomic, copy) NSString *pages;

@property (nonatomic, copy) NSString *alt;

@property (nonatomic, copy) NSString *imageSmall;
@property (nonatomic, copy) NSString *imageLarge;
@property (nonatomic, copy) NSString *imageMedium;

@property (nonatomic, copy) NSString *bookId;
@property (nonatomic, copy) NSString *publisher;

@property (nonatomic, copy) NSString *isbn10;
@property (nonatomic, copy) NSString *isbn13;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *alt_title;
@property (nonatomic, copy) NSString *author_intro;
@property (nonatomic, copy) NSString *summary;

@property (nonatomic, copy) NSString *price;

@end
