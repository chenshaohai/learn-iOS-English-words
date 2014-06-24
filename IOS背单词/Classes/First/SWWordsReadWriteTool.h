//
//  SWWordSReadWriteTool
//  IOS背单词
//
//  Created by Sword on 14-5-18.
//  Copyright (c) 2014年 Sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWWordSReadWriteTool : NSObject

+(NSArray *)wordSFromFile;

+(void)wordsToFile:(NSArray *)wordsArray;
@end
