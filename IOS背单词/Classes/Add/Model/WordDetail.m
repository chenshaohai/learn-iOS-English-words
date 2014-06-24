//
//  WordDetail.m
//
//
//  Created by Sword on 14-1-2.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "WordDetail.h"

@implementation WordDetail

+ (instancetype)wordDetailWithType:(NSString *)type content:(NSString *)content
{
    WordDetail *wd = [[WordDetail alloc] init];

    wd.type = type;
    wd.content = content;

    return wd;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<WordDetail: %p, type: %@, content: %@>", self, _type, _content];
}

@end
