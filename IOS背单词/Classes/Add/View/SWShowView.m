//
//  SWShowView.m
//  IOS背单词
//
//  Created by Sword on 14-5-20.
//  Copyright (c) 2014年 Sword. All rights reserved.
//

#import "SWShowView.h"
#import "SWWord.h"
#import "SWSoundTool.h"
#import "SWWordsReadWriteTool.h"
@interface SWShowView ()
@property (weak, nonatomic) IBOutlet UITextField *wordLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneticField;
@property (weak, nonatomic) IBOutlet UITextView *tansField;
@property (weak, nonatomic) IBOutlet UITextField *tagsField;
- (IBAction)add;
- (IBAction)cancle;
- (IBAction)soundBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end

@implementation SWShowView

-(void)setWord:(SWWord *)word
{
    _word = word;
    self.wordLabel.text = word.word;
    self.wordLabel.userInteractionEnabled = NO;
    self.phoneticField.text = word.phonetic;
    self.phoneticField.userInteractionEnabled = NO;
    self.tansField.text = word.trans;
    self.tagsField.text = @"未分类";
    self.addBtn.enabled = YES;
    [self soundBtn];
}

+(SWShowView *)showView
{
    SWShowView *showView = [[NSBundle mainBundle]loadNibNamed:@"SWShowView"owner:nil options:nil][0];
    
    return showView;
}
#pragma mark   添加按钮点击
/**
 *  添加按钮点击
 */
- (IBAction)add {
    
    //如果有值
    if (self.word.word) {
        //添加word属性
        self.word.trans = self.tansField.text ;
        self.word.tags = self.tagsField.text;
        self.word.revise = YES;
        self.word.mistakes = 0;
        //添加到总体词库
        NSMutableArray  *totleArray =   [SWWordsReadWriteTool  wordsFromFile];
        [totleArray addObject:self.word];
        [SWWordsReadWriteTool  wordsToFile:totleArray];
        //添加到已学词库
        NSMutableArray  *ReviseArray = [SWWordsReadWriteTool wordsReviseFromFile];
        [ReviseArray addObject:self.word];
        [SWWordsReadWriteTool wordsReviseToFile:ReviseArray];
        
        
        
    }
    
    //销毁控制
    if ([self.delegate respondsToSelector:@selector(showViewMissControllerButtonClick:)]) {
        [self.delegate showViewMissControllerButtonClick:self];
    }
    
}

- (IBAction)cancle {
    if ([self.delegate respondsToSelector:@selector(showViewMissControllerButtonClick:)]) {
    [self.delegate showViewMissControllerButtonClick:self];
}

}
#pragma mark  读
/**
 * 读
 */
- (IBAction)soundBtn {
    [[[SWSoundTool  alloc]init] soundWithString: self.word.word];
}
@end
