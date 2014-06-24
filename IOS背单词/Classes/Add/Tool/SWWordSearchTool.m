//
//  SWWordSearchTool.m
//  IOS背单词
//
//  Created by Sword on 14-5-19.
//  Copyright (c) 2014年 Sword. All rights reserved.
//

#import "SWWordSearchTool.h"
#import "NSString+Regex.h"
#import "SWWord.h"
#import "NSArray+Log.h"
#import "WordDetail.h"

#define kBaseURL        @"http://dict.cn/"

@interface SWWordSearchTool ()
#pragma mark  查询的单词
/**
 *  查询的单词
 */
@property(nonatomic,copy)NSString *spiderWord;

#pragma mark  当前解析的单词
/**
 *  当前解析的单词
 */
@property(nonatomic,strong)SWWord *currentWord;

@end
@implementation SWWordSearchTool

/*
 1. 给定一个单词，将网页的所有内容抓下来
 2. 将需要进一步分析的html从完整的html中抽取出来
 
 */

#pragma mark - 网页抓取方法
#pragma mark 获得内容部分的html
- (NSString *)contentWithHTML:(NSString *)html
{
    // 使用正则表达式
    NSString *pattern = @"<div class=\"word\">(.*?)<div id=\"dshared\">";
    
    return [html firstMatchWithPattern:pattern];
}

#pragma mark 获得单词音标
- (void)phoneticWithHTML:(NSString *)html word:(SWWord *)word
{
    // 1. 取出音标部分的内容
    NSString *content = [html firstMatchWithPattern:@"<div class=\"phonetic\">(.*?)</div>"];
    
    // 2. 依次取出音标
    NSArray *array = [content matchsWithPattern:@"<bdo lang=\"EN-US\">(.*?)</bdo>"];
    
    if (array.count > 0) {
        NSTextCheckingResult *r1 = array[0];
        
        word.phonetic = [content substringWithRange:[r1 rangeAtIndex:1]];
    }
}

#pragma mark 基本释义
- (NSArray *)basicDescWithHTML:(NSString *)html
{
    // 1. 取出基本释义部分的内容
    NSString *pattern = @"<ul class=\"dict-basic-ul\">(.*?)</ul>";
    NSString *basicContent = [html firstMatchWithPattern:pattern];
    
    // 2. 依次取出解释释义
    pattern = @"<li><span>(.*?)</span><strong>(.*?)</strong></li>";
    NSArray *array = [basicContent matchsWithPattern:pattern];
    
    NSMutableArray *arrayM = nil;
    
    if (array) {
        arrayM = [NSMutableArray arrayWithCapacity:array.count];
        
        for (NSTextCheckingResult *result in array) {
            NSRange r1 = [result rangeAtIndex:1];
            NSRange r2 = [result rangeAtIndex:2];
            
            WordDetail *wd = [WordDetail wordDetailWithType:[basicContent substringWithRange:r1] content:[basicContent substringWithRange:r2]];
            
            [arrayM addObject:wd];
        }
    }
    
    return arrayM;
}
#pragma mark 处理单词完整的html内容
- (SWWord *)dealWithHTML:(NSString *)html
{
    // 1. 获得内容部分的html
    NSString *content = [self contentWithHTML:html];
    
    // 2. 取出基本释义内容
    NSArray *basic = [self basicDescWithHTML:content];
    
    // 如果包含基本释义，说明单词拼写正确
    if (basic == nil) {
        NSLog(@"没有找到 %@ 的解释。", _spiderWord);
        return  nil;
    }
    
    // 实例化单词对象
    self.currentWord = [[SWWord alloc] init];
    self.currentWord.word = _spiderWord;
    
    // 3. 获取单词音标
    [self phoneticWithHTML:html word:self.currentWord];
    
    // 4. 基本释义
   
    WordDetail *detail = basic[0];
    NSString *str1 = detail.type;
    NSString *str2 = detail.content;
    NSString *trans = [NSString  stringWithFormat:@"%@ . %@",str1,str2];
    self.currentWord.trans = trans;;
  
    
    return self.currentWord;

}
#pragma mark  接收单词  返回black
/**
 *  接收单词  返回black
 */
- (void)wordSearch:(NSString *)word success:(SeartchSuccess)success failure:(SeartchFailure)failure
{
    
    _spiderWord = word;
    // 1. URL
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBaseURL, word];
    // 防止出现中文
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 2. URLRequest
    // 提示，超时时长不要太短
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0f];
    
    // 3. 请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data != nil) {
            // 解析HTML文件内容个，获取到需要的SWWord模型信息
           SWWord *oneWord = [self dealWithHTML:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
            SWLog(@"%@",oneWord);
            //调用者有success Block就调用并返回oneWord
            if (success) {
                success(oneWord);
            }
        } else if (connectionError == nil) {
            NSLog(@"空数据");
        } else {
            NSLog(@"连接错误 -> 编号: %d 描述: %@", connectionError.code, connectionError.localizedDescription);
            if (failure) {
                failure(connectionError);
            }
        }
    }];
}
@end

