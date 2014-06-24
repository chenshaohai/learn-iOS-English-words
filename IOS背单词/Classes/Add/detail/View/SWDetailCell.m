//
//  SWDetailCell.m
//  IOS背单词
//
//  Created by Sword on 14-5-18.
//  Copyright (c) 2014年 Sword. All rights reserved.
//

#import "SWDetailCell.h"
#import "SWWordFrame.h"
#import "SWWord.h"
#import "SWSoundTool.h"
@interface SWDetailCell()
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
//
//#pragma mark  错误次数
///**
// *  错误次数
// */
//@property (weak, nonatomic)  UILabel *mistakesLabel;
#pragma mark  分割线
/**
 *  分割线 
 */
@property (weak, nonatomic)  UIView *divideView;
@end
@implementation SWDetailCell
+(SWDetailCell *)cellWithTableView:(UITableView *)tableView
{
    static  NSString *ID = @"detail";
    SWDetailCell  *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SWDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
    
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {//1.添加单词Label
        UILabel *wordLabel = [[UILabel alloc]init];
        [self.contentView addSubview:wordLabel];
        self.wordLabel = wordLabel;
        self.wordLabel.textColor = [UIColor blackColor];
        self.wordLabel.font = SWBigFont;
        self.wordLabel.textAlignment = NSTextAlignmentCenter;
        
        
        
        //2.添加音标Label
        UILabel *phoneticLabel = [[UILabel alloc]init];
        [self.contentView addSubview:phoneticLabel];
        self.phoneticLabel = phoneticLabel;
        self.phoneticLabel.font = SWCommonFont;
        self.phoneticLabel.textAlignment = NSTextAlignmentCenter;
        
        
        //3.添加词义Label
        UILabel *transLabel = [[UILabel alloc]init];
        [self.contentView addSubview:transLabel];
        self.transLabel = transLabel;
        transLabel.numberOfLines = 0 ;
        self.transLabel.font = SWCommonFont;
        self.transLabel.textAlignment = NSTextAlignmentLeft;
        
        
        
        //4.添加类别Label
        UILabel *tagsLabel = [[UILabel alloc]init];
        [self.contentView addSubview:tagsLabel];
        self.tagsLabel = tagsLabel;
        self.tagsLabel.font = SWCommonFont;
        self.tagsLabel.textAlignment = NSTextAlignmentCenter;
        
//        //5.添加错误累计Label
//        UILabel *mistakesLabel = [[UILabel alloc]init];
//        [self.contentView addSubview:mistakesLabel];
//        self.mistakesLabel = mistakesLabel;
//        self.mistakesLabel.font = SWCommonFont;
//        self.mistakesLabel.textAlignment = NSTextAlignmentCenter;
        
        //6.添加喇叭按钮
        UIButton *soundButton = [[UIButton alloc]init];
        [self.contentView addSubview:soundButton];
        self.soundButton = soundButton;
        [soundButton setImage:[UIImage imageNamed:@"sound"] forState:UIControlStateNormal];
        [soundButton setImage:[UIImage imageNamed:@"sound-h"] forState:UIControlStateHighlighted];
        [soundButton  addTarget:self action:@selector(soundButtonclick) forControlEvents:UIControlEventTouchUpInside];
        
        //7.添加分割线
        UIView *divideView = [[UIView alloc]init];
        [self.contentView addSubview:divideView];
        self.divideView = divideView;
        [divideView setBackgroundColor: [UIColor blackColor]];
        divideView.alpha = 0.5;
        
       
    }
    return self;
}
-(void) soundButtonclick
{
  
    [[[SWSoundTool alloc]init] soundWithString:self.wordFrame.oneWord.word];
}

-(void)setWordFrame:(SWWordFrame *)wordFrame
{
    _wordFrame = wordFrame;
    SWWord *oneWord = wordFrame.oneWord;
    
    //1.设置单词
    self.wordLabel.text = oneWord.word;
    
    self.wordLabel.frame = wordFrame.wordLabelF;
    
    //2.设置音标
    self.phoneticLabel.text = oneWord.phonetic;
    
    self.phoneticLabel.frame = wordFrame.phoneticLabelF;
    
    //3.设置喇叭图标
  
    
    self.soundButton.frame = wordFrame.soundButtonF;
    
    
//    
//    //5.设置错误累计
//    
//    self.mistakesLabel.text =[NSString stringWithFormat:@"累计错误：%d",oneWord.mistakes];
//   
//    self.mistakesLabel.frame = wordFrame.mistakesLabelF;
    
    //6.设置类别
    self.tagsLabel.text = [NSString stringWithFormat:@"类别：%@",oneWord.tags];
    
    self.tagsLabel.frame = wordFrame.tagsLabelF;
    
    
    
    
    //8.设置词义
    self.transLabel.text = oneWord.trans;
    
    self.transLabel.frame = wordFrame.transLabelF;

    // 4 . 设置分割线1
    
    self.divideView.frame = wordFrame.divideViewF;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
