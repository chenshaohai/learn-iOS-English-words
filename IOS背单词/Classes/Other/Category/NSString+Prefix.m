//
//  NSString+Prefix.m
//  单词第二版3.24
//
//  Created by Sword on 14-4-30.
//  Copyright (c) 2014年 Sword. All rights reserved.
//

#import "NSString+Prefix.h"

@implementation NSString (Prefix)
-(NSString *)removePrefixEnterAndSpace
{
    if ( 0 == self.length) return self;
    
    NSMutableString  *temp = [self copy];
    while ('\n' == [temp characterAtIndex:0] || ' ' == [temp characterAtIndex:0] || 9 == [temp characterAtIndex:0]) {

        temp = [[temp substringFromIndex:1] mutableCopy];
        //防止删光了
        if  (temp.length < 2) break;
    }

       return temp;
}
@end
