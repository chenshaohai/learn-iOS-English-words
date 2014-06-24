//
//  SWWordsReadWriteTool.m
//  IOS背单词
//
//  Created by Sword on 14-5-18.
//  Copyright (c) 2014年 Sword. All rights reserved.
//

#import "SWWordsReadWriteTool.h"


@implementation SWWordsReadWriteTool


#pragma mark  总体单词写入文件
/**
 *  总体单词写入文件
 */
+(void)wordsToFile:(NSArray *)wordsArray
{
    NSString *path = SWFilePath;
    [NSKeyedArchiver archiveRootObject:wordsArray toFile:path] ;
}
#pragma mark  总体单词读取
/**
 *  总体单词读取
 */
+(NSMutableArray *)wordsFromFile
{
     NSString *path = SWFilePath;
    return  [NSKeyedUnarchiver   unarchiveObjectWithFile:path];
}


#pragma mark  已学的单词写入
/**
 *  已学的单词写入
 */
+(void)wordsReviseToFile:(NSArray *)wordsArray
{
    NSString *path = SWReviseFilePath;
    [NSKeyedArchiver archiveRootObject:wordsArray toFile:path] ;
}

#pragma mark  已学的单词读取
/**
 *  已学的单词读取
 */
+(NSMutableArray *)wordsReviseFromFile
{
    NSString *path = SWReviseFilePath;
    return  [NSKeyedUnarchiver   unarchiveObjectWithFile:path];
}

#pragma mark  未学习单词写入
/**
 *  未学习单词写入
 */
+(void)wordsRemainToFile:(NSArray *)wordsArray
{
    
    NSString *path = SWRemainFilePath;
    [NSKeyedArchiver archiveRootObject:wordsArray toFile:path] ;
}

#pragma mark   未学习单词读取
/**
 *   未学习单词读取读取
 */
+(NSMutableArray *)wordsRemainFromFile
{
    NSString *path = SWRemainFilePath;
    return  [NSKeyedUnarchiver   unarchiveObjectWithFile:path];
}

@end
