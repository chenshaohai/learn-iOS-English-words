//
//  SWWordFrame.m
//  IOS背单词
//
//  Created by Sword on 14-5-17.
//  Copyright (c) 2014年 Sword. All rights reserved.
//

#import "SWWordFrame.h"
#import "SWWord.h"
#import "NSString+Extension.h"

@implementation SWWordFrame


//重写SET方法
-(void)setOneWord:(SWWord *)oneWord
{
    _oneWord = oneWord;
    CGFloat CellW = [UIScreen mainScreen].bounds.size.width;
    //1.设置单词
    CGFloat wordX = 0;
    CGFloat wordY = SWCellTopPadding;
    CGFloat wordW = CellW * 0.45 ;
    CGFloat wordH = [oneWord.word sizeWithFont:SWBigFont].height;
    
    self.wordLabelF = CGRectMake(wordX, wordY, wordW, wordH);
    
    //2.设置音标
    CGFloat phoneticX = wordW;
    CGFloat phoneticY = SWCellTopPadding + 5 ;
    CGFloat phoneticW = CellW * 0.55 - 40;
    CGFloat phoneticH =[oneWord.phonetic sizeWithFont:SWCommonFont].height;
    
    self.phoneticLabelF = CGRectMake(phoneticX, phoneticY, phoneticW, phoneticH);
    
    
    
    //3.设置类别
    NSString  *tagsStr = [NSString stringWithFormat:@"类别：%@",oneWord.tags];
    CGFloat tagsX = SWPadding;
    CGFloat tagsY = CGRectGetMaxY(self.wordLabelF) + SWPadding;
    CGFloat tagsW = CellW * 0.5;
    CGFloat tagsH =[tagsStr sizeWithFont:SWCommonFont].height;
    
    self.tagsLabelF = CGRectMake(tagsX, tagsY, tagsW, tagsH);
    
    
    //4.设置喇叭图标
    
    CGFloat soundW = 30;
    CGFloat soundX = CellW - 80;
    CGFloat soundY =  tagsY;
    CGFloat soundH = soundW;
    
    self.soundButtonF = CGRectMake(soundX, soundY, soundW, soundH);
    //5.设置词义
    CGFloat transX = SWPadding;
    CGFloat transY = SWPadding + MAX( CGRectGetMaxY(self.mistakesLabelF) , CGRectGetMaxY(self.tagsLabelF));
    CGSize transSize  = [oneWord.trans sizeWithFont:SWCommonFont maxSize:CGSizeMake(CellW, CGFLOAT_MAX)];
    
    self.transLabelF = CGRectMake(transX, transY, CellW, transSize.height);
    
    // 6 . 设置分割线2
    CGFloat secondX = SWPadding ;
    CGFloat secondY =  SWPadding +  CGRectGetMaxY(self.transLabelF);
    CGFloat secondW = CellW - 2 * SWPadding;
    CGFloat secondH = 1;
    
    self.divideViewF = CGRectMake(secondX, secondY, secondW, secondH);
    
    // 7 . Cell高度
    self.CellHight = CGRectGetMaxY(self.divideViewF) ;
}

@end
