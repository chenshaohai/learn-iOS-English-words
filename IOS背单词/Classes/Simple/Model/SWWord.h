//
//  SWWord.h
//  单词第二版3.24
//
//  Created by Sword on 14-3-24.
//  Copyright (c) 2014年 Sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWWord : NSObject <NSCoding>

#pragma mark  单词
/**
 *   单词
 */
@property (nonatomic, copy)NSString * word;

#pragma mark  音标
/**
 *   音标
 */
@property (nonatomic, copy)NSString * phonetic;

#pragma mark  词意及例句
/**
 *   词意及例句
 */
@property (nonatomic, copy)NSString * trans;

#pragma mark  类别
/**
 *   类别
 */
@property (nonatomic, copy)NSString * tags;

#pragma mark  进度
/**
 *   进度
 */
@property (nonatomic, copy)NSString * progress;

#pragma mark  错误累计
/**
 *   错误累计
 */
@property (nonatomic, assign)int  mistakes;
#pragma mark  学习过与否
/**
 *   学习过与否
 */
@property (nonatomic, assign , setter = isRevise:)BOOL  revise;


@end
