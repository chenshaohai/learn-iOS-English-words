//
//  XHWord.m
//  单词第二版3.24
//
//  Created by Sword on 14-3-24.
//  Copyright (c) 2014年 Sword. All rights reserved.
//

#import "SWWord.h"

@implementation SWWord

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.word forKey:@"word"];
    [encoder encodeObject:self.phonetic forKey:@"phonetic"];
    [encoder encodeObject:self.trans forKey:@"trans"];
    
    [encoder encodeObject:self.tags forKey:@"tags"];
    [encoder encodeObject:self.progress forKey:@"progress"];
    
    [encoder encodeInt:self.mistakes forKey:@"mistakes"];
    [encoder encodeBool:self.revise forKey:@"revise"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        // 读取文件的内容
        self.word = [decoder decodeObjectForKey:@"word"];
        self.mistakes = [decoder decodeIntForKey:@"mistakes"];
        
        self.phonetic = [decoder decodeObjectForKey:@"phonetic"];
        self.trans = [decoder decodeObjectForKey:@"trans"];
        self.progress = [decoder decodeObjectForKey:@"progress"];
        self.tags = [decoder decodeObjectForKey:@"tags"];
        self.revise = [decoder decodeBoolForKey:@"revise"];
    }
    return self;
}

@end
