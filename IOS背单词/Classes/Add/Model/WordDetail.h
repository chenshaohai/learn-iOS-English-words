//
//  WordDetail.h
//  
//
//  Created by Sword on 14-1-2.
//  Copyright (c) 2014年 itcast. All rights reserved.
//
//  单词明细信息
//
//  基本释义：   词性+解释
//  详细释义：   词性+解释
//  例句：      词性+例句
//  词语搭配：   null+搭配用例
//  近/反义词：  类型+单词
//

#import <Foundation/Foundation.h>

@interface WordDetail : NSObject

/**
 *  工厂方法
 *
 *  @param type    明细类型，例如名词、形容词、动词
 *  @param content 明细内容，例如解释、例句等
 *
 *  @return 单词明细内容
 */
+ (instancetype)wordDetailWithType:(NSString *)type content:(NSString *)content;

/**
 *  类型
 */
@property (nonatomic, strong) NSString *type;
/**
 *  内容
 */
@property (nonatomic, strong) NSString *content;

@end
