//
//  DouBanMusic.h
//  find.it
//
//  Created by dudu on 13-6-22.
//  Copyright (c) 2013年 dudu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DouBanMusicRating.h"
@class DoubanMusic;
@interface DoubanMusicModel : NSObject

@property (nonatomic, strong) DoubanMusicRating * rating;
@property (nonatomic, strong) NSArray * author; // not used
@property (nonatomic, copy)   NSString * alt_title;
@property (nonatomic, copy)   NSString * image;
@property (nonatomic, copy)   NSString * mobile_link;

@property (nonatomic, copy)   NSString * title;
@property (nonatomic, copy)   NSString *alt;
@property (nonatomic, copy)   NSString *musicId; // id in json

// tag. i.e count:4, name:"流行"
@property (nonatomic, strong) NSDictionary * tags;
// attrs
@property (nonatomic, copy)   NSString *publisher;
@property (nonatomic, strong) NSArray *singer;
@property (nonatomic, copy) NSString *version;
@property (nonatomic, copy) NSString *pubdate;
@property (nonatomic, strong) NSArray *media;
@property (nonatomic, strong) NSArray *tracks;

@property (nonatomic, copy) NSString *summary;
//@property

- (DoubanMusicModel *)initWithMusic:(DoubanMusic *)music;

@end
