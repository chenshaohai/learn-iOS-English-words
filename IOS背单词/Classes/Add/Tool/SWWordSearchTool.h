//
//  SWWordSearchTool.h
//  IOS背单词
//
//  Created by Sword on 14-5-19.
//  Copyright (c) 2014年 Sword. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  SWWord;
typedef void (^SeartchSuccess)(SWWord * oneWord);
typedef void (^SeartchFailure)(NSError *error);


@interface SWWordSearchTool : NSObject
#pragma mark  接收单词  返回black
/**
 *  接收单词  返回black
 */
- (void)wordSearch:(NSString *)word success:(SeartchSuccess)success failure:(SeartchFailure)failure;



@end
