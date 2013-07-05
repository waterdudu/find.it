//
//  DoubanBookRating.h
//  find.it
//
//  Created by dudu on 13-6-28.
//  Copyright (c) 2013年 dudu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DoubanBookRating : NSObject

@property (nonatomic, assign) int max;
@property (nonatomic, assign) float average;
@property (nonatomic, assign) int numRaters;
@property (nonatomic, assign) int min;

@end
