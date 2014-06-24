//
//  NSString+Regex.h
//  
//
//  Created by Sword on 14-1-1.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Regex)

/**
 *  查找字符串中第一个匹配项
 *
 *  @param pattern 匹配方案
 *
 *  @return 第一个匹配字符串
 */
- (NSString *)firstMatchWithPattern:(NSString *)pattern;

/**
 *  查找字符串中所有匹配项
 *
 *  @param pattern 匹配方案
 *
 *  @return 匹配数组（NSTextCheckingResult）
 */
- (NSArray *)matchsWithPattern:(NSString *)pattern;

/**
 *  截断收尾空白字符
 *
 *  @return 截断首位空白字符后的字符串
 */
- (NSString *)trimString;

@end
