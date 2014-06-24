//
//  NSString+Prefix.h
//  单词第二版3.24
//
//  Created by Sword on 14-4-30.
//  Copyright (c) 2014年 Sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Prefix)
#pragma mark  删除字符串前面的空格及回车键
/**
 *  删除字符串前面的空格及回车键及制表符
 */
-(NSString *)removePrefixEnterAndSpace;
@end
