//
//  SWWordsReadWriteTool.h
//  IOS背单词
//
//  Created by Sword on 14-5-18.
//  Copyright (c) 2014年 Sword（ 陈小海 ）. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWWordsReadWriteTool : NSObject

#pragma mark  总体单词写入文件
/**
 *  总体单词写入文件
 */
+(void)wordsToFile:(NSArray *)wordsArray;

#pragma mark  总体单词读取
/**
 *  总体单词读取
 */
+(NSMutableArray *)wordsFromFile;



#pragma mark  已学的单词写入
/**
 *  已学的单词写入
*/
+(void)wordsReviseToFile:(NSArray *)wordsArray;

#pragma mark  已学的单词读取
/**
 *  已学的单词读取
 */
+(NSMutableArray *)wordsReviseFromFile;



#pragma mark  未学习单词写入
/**
 *  未学习单词写入
 */
+(void)wordsRemainToFile:(NSArray *)wordsArray;

#pragma mark   未学习单词读取
/**
 *   未学习单词读取读取
 */
+(NSMutableArray *)wordsRemainFromFile;


@end
