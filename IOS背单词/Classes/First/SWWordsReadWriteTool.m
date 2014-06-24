//
//  SWWordSReadWriteTool
//  IOS背单词
//
//  Created by Sword on 14-5-18.
//  Copyright (c) 2014年 Sword. All rights reserved.
//

#import "SWWordSReadWriteTool.h"

@implementation SWWordSReadWriteTool

+(NSArray *)wordSFromFile
{
    //取出存档文件
    NSString *path = SWFilePath;
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
}
+(void)wordsToFile:(NSArray *)wordsArray
{
    //存档
    NSString *path = SWFilePath;
    [NSKeyedArchiver archiveRootObject:wordsArray toFile:path];
    
}

@end
