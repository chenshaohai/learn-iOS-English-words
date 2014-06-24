//
//  SWSimpleViewController.m
//  IOS背单词
//
//  Created by Sword on 14-5-17.
//  Copyright (c) 2014年 Sword. All rights reserved.
//

#import "SWSimpleViewController.h"
#import "SWWord.h"
#import "NSString+Extension.h"
#import "SWSoundTool.h"



@interface SWSimpleViewController ()
#pragma mark  喇叭
/**
 *  喇叭
 */
@property (weak, nonatomic)  UIButton *soundButton;
#pragma mark  单词
/**
 *  单词
 */
@property (weak, nonatomic)  UILabel *wordLabel;
#pragma mark  音标
/**
 *  音标
 */
@property (weak, nonatomic)  UILabel *phoneticLabel;
#pragma mark  词义
/**
 *  词义
 */
@property (weak, nonatomic)  UILabel *transLabel;

#pragma mark  类别
/**
 *  类别
 */
@property (weak, nonatomic)  UILabel *tagsLabel;
#pragma mark  showLabel
/**
 *  showLabel
 */
@property (weak, nonatomic)  UILabel *showLabel;
#pragma mark 添加分割线
/**
 * 添加分割线
 */
@property (weak, nonatomic)  UIView *divideViewFirst;
#pragma mark 添加分割线
/**
 * 添加分割线
 */
@property (weak, nonatomic)  UIView *divideViewsecond;

@end

@implementation SWSimpleViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //0.改变用户交互
    self.view.userInteractionEnabled = YES;
    
    //1.添加单词Label
    UILabel *wordLabel = [[UILabel alloc]init];
    [self.view addSubview:wordLabel];
    self.wordLabel = wordLabel;
    self.wordLabel.textColor = [UIColor blackColor];
    self.wordLabel.font = SWBigFont;
    self.wordLabel.textAlignment = NSTextAlignmentCenter;
    
    
    
    //2.添加音标Label
    UILabel *phoneticLabel = [[UILabel alloc]init];
    [self.view addSubview:phoneticLabel];
    self.phoneticLabel = phoneticLabel;
    self.phoneticLabel.font = SWCommonFont;
    self.phoneticLabel.textAlignment = NSTextAlignmentCenter;
   
    
    //3.添加词义Label
    UILabel *transLabel = [[UILabel alloc]init];
    [self.view addSubview:transLabel];
    self.transLabel = transLabel;
    transLabel.numberOfLines = 0 ;
     self.transLabel.font = SWCommonFont;
    self.transLabel.textAlignment = NSTextAlignmentLeft;
    
    
    
    //4.添加类别Label
    UILabel *tagsLabel = [[UILabel alloc]init];
    [self.view addSubview:tagsLabel];
    self.tagsLabel = tagsLabel;
     self.tagsLabel.font = SWCommonFont;
    self.tagsLabel.textAlignment = NSTextAlignmentCenter;
    
    //5.添加showLabel
   
    UILabel *showLabel = [[UILabel alloc]init];
    [self.view addSubview:showLabel];
    self.showLabel = showLabel;
    self.showLabel.font = SWCommonFont;
    self.showLabel.textAlignment = NSTextAlignmentCenter;
    showLabel.hidden = YES;
    
    //6.添加喇叭按钮
    UIButton *soundButton = [[UIButton alloc]init];
    [self.view addSubview:soundButton];
    self.soundButton = soundButton;
    [soundButton setImage:[UIImage imageNamed:@"sound"] forState:UIControlStateNormal];
    [soundButton setImage:[UIImage imageNamed:@"sound-h"] forState:UIControlStateHighlighted];
    [soundButton  addTarget:self action:@selector(soundButtonclick) forControlEvents:UIControlEventTouchUpInside];
    
    //7.添加分割线
    UIView *divideViewFirst = [[UIView alloc]init];
    [self.view addSubview:divideViewFirst];
    self.divideViewFirst = divideViewFirst;
    [divideViewFirst setBackgroundColor: [UIColor blackColor]];
    divideViewFirst.alpha = 0.5;
    
    //8.添加分割线
    UIView *divideViewsecond = [[UIView alloc]init];
    [self.view addSubview:divideViewsecond];
    self.divideViewsecond = divideViewsecond;
    [divideViewsecond setBackgroundColor: [UIColor blackColor]];
    divideViewFirst.alpha = 0.5;
    
    //自动发音
    [self soundButtonclick];
}
-(void)soundButtonclick
{
    
    [[[SWSoundTool alloc]init]  soundWithString:self.oneWord.word];
}

-(void)setOneWord:(SWWord *)oneWord
{
    _oneWord = oneWord;
    
    //这个时候控制器的View还没有加载，主动掉一下self.view才调用viewDidLoad加载子控件，后面的设置才有用！
    CGFloat  viewW =  self.view.frame.size.width;
    
     //1.设置单词
    self.wordLabel.text = oneWord.word;
    CGFloat wordX = SWPadding;
    CGFloat wordY = SWTopPadding;
    CGFloat wordW = viewW * 0.5 ;
    CGFloat wordH = [self.wordLabel.text sizeWithFont:SWBigFont].height;
    
    self.wordLabel.frame = CGRectMake(wordX, wordY, wordW, wordH);
    
    
    //2.设置喇叭图标
    
    CGFloat soundW = 30;
    CGFloat soundX = viewW - 80;
    CGFloat soundY =  SWTopPadding;
    CGFloat soundH = soundW;
    
    self.soundButton.frame = CGRectMake(soundX, soundY, soundW, soundH);
    
    // 3 . 设置分割线1
    CGFloat FirstX = SWPadding ;
    CGFloat FirstY =  SWPadding + MAX( CGRectGetMaxY(self.soundButton.frame) , CGRectGetMaxY(self.wordLabel.frame));
    CGFloat FirstW = viewW - 2 * SWPadding;
    CGFloat FirstH = 1;
    
    self.divideViewFirst.frame = CGRectMake(FirstX, FirstY, FirstW, FirstH);

    //4.设置音标
    self.phoneticLabel.text = oneWord.phonetic;
    CGFloat phoneticX = SWPadding;
    CGFloat phoneticY = CGRectGetMaxY( self.divideViewFirst.frame ) + SWPadding ;
    CGFloat phoneticW = viewW * 0.6 ;
    CGFloat phoneticH =[self.phoneticLabel.text sizeWithFont:SWCommonFont].height;
    
    self.phoneticLabel.frame = CGRectMake(phoneticX, phoneticY, phoneticW, phoneticH);
    
  
        //5.设置类别
    NSString  *tagsStr = [NSString stringWithFormat:@"类别:%@",oneWord.tags];
    self.tagsLabel.text = tagsStr;
    CGFloat tagsX = viewW * 0.5;
    CGFloat tagsY = phoneticY;
    CGFloat tagsW = viewW * 0.5;
    CGFloat tagsH =[self.tagsLabel.text sizeWithFont:SWCommonFont].height;
    
    self.tagsLabel.frame = CGRectMake(tagsX, tagsY, tagsW, tagsH);
    // 6 . 设置分割线2
    CGFloat secondX = SWPadding ;
    CGFloat secondY =  SWPadding +  CGRectGetMaxY(self.tagsLabel.frame);
    CGFloat secondW = viewW - 2 * SWPadding;
    CGFloat secondH = 1;
    
    self.divideViewsecond.frame = CGRectMake(secondX, secondY, secondW, secondH);
    
  
    //7.设置词义
    self.transLabel.text = oneWord.trans;
    CGFloat transX = SWPadding;
    CGFloat transY = CGRectGetMaxY(self.divideViewsecond.frame) + SWPadding;
    CGSize transSize  = [oneWord.trans sizeWithFont:SWCommonFont maxSize:CGSizeMake(self.view.frame.size.width, CGFLOAT_MAX)];
    
    self.transLabel.frame = CGRectMake(transX, transY, self.view.frame.size.width, transSize.height);

}



@end
