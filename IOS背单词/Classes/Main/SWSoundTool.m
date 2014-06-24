//
//  SWSoundTool.m
//  IOS背单词
//
//  Created by Sword on 14-5-18.
//  Copyright (c) 2014年 Sword. All rights reserved.
//

#import "SWSoundTool.h"
#import <AVFoundation/AVFoundation.h>
@interface SWSoundTool ()

#pragma mark  IOS6中访问网络
/**
 *  IOS6中访问网络
 */
@property(nonatomic,strong )UIWebView *webView;
#pragma mark  语音合成器
/**
 *  语音合成器
 */
@property(nonatomic,strong)AVSpeechSynthesizer *synthesizer;
#pragma mark  实例化说话的语言，说中文、英文
/**
 *  实例化说话的语言，说中文、英文
 */
@property(nonatomic,strong)AVSpeechSynthesisVoice *voice;
@end


@implementation SWSoundTool
-(void)soundWithString:(NSString *)word
{
    
    //ios7 本地发音
    if (IOS7) {
        // 实例化说话的语言，
        self.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"];
        
        // 要朗诵，需要一个语音合成器
        self.synthesizer = [[AVSpeechSynthesizer alloc] init];
        
        // 朗诵文本框中的内容
        // 实例化发声的对象，及朗读的内容
        AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:word];
        
        utterance.voice = _voice;
        utterance.rate = 0.1;
        
        [_synthesizer speakUtterance:utterance];

        
    }else{//ios6 访问网络发音
        
        self.webView = [[UIWebView alloc]init];
        
        //拼接路径
        NSString *str = [NSString stringWithFormat:@"http://dict.youdao.com/dictvoice?type=1&audio=%@",word];
        
        
        NSURL *url = [NSURL URLWithString:str];
        NSURLRequest  *request = [NSURLRequest requestWithURL:url];
        //获取读音
        [self.webView loadRequest:request];
    }
    
}

@end
