//
//  NSString+Regex.m
//
//
//  Created by Sword on 14-1-1.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "NSString+Regex.h"

@implementation NSString (Regex)

#pragma mark 查找字符串中第一个匹配项
- (NSString *)firstMatchWithPattern:(NSString *)pattern
{
    // 1. 实例化正则
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:pattern
                                  options:NSRegularExpressionCaseInsensitive
                                  | NSRegularExpressionDotMatchesLineSeparators
                                  error:&error];

    if (error) {
        NSLog(@"匹配模式不正确");

        return nil;
    }

    // 2. 匹配一项内容
    NSTextCheckingResult *firstMatch = [regex firstMatchInString:self
                                                         options:NSMatchingReportCompletion
                                                           range:NSMakeRange(0, self.length)];

    if (firstMatch) {
        // 返回第一个分组中内容
        NSRange range = [firstMatch rangeAtIndex:1];

        return [self substringWithRange:range];
    } else {
        NSLog(@"没有找到匹配内容");
    }

    return nil;
}

#pragma mark 查找字符串中所有匹配项
- (NSArray *)matchsWithPattern:(NSString *)pattern
{
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive | NSRegularExpressionDotMatchesLineSeparators error:&error];

    if (error) {
        NSLog(@"匹配模式不正确");

        return nil;
    }

    // 匹配所有内容
    NSArray *array = [regex matchesInString:self
                                    options:NSMatchingReportCompletion
                                      range:NSMakeRange(0, self.length)];

    if (array == nil) {
        NSLog(@"没有找到匹配内容");
    }
    
    return array;
}

#pragma mark 截断收尾空白字符
- (NSString *)trimString
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
