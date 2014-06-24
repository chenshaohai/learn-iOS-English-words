//
//  SWRevisesController.m
//  IOS背单词
//
//  Created by Sword on 14-5-18.
//  Copyright (c) 2014年 Sword. All rights reserved.
//

#import "SWRevisesController.h"
#import "SWWordsReadWriteTool.h"
#import "SWWord.h"
#import "SWSoundTool.h"
#define  SWCommonFont  [UIFont systemFontOfSize:16]

@interface SWRevisesController ()
/*当日学习的个数*/
@property(nonatomic,assign)int count;
/* 显示已经当天已经学习的个数*/
@property(nonatomic,weak)UILabel *countLabel;
#pragma mark  提示按钮
/**
 *  提示按钮
 */
@property (weak, nonatomic)  UILabel *showLabel;



@end

@implementation SWRevisesController




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //初始化每天应该学习的单词个数
    self.count = 0 ;


    //  加载当天学习的View
    [self  loadTodayView];
    
    //  加载当天学习的数据
    [self  loadTodayData];
}

#pragma mark   加载当天学习的View
/**
 *    加载当天学习的View
 */
-(void)loadTodayView
{
   
    //0.提示
    UILabel *showLabel =  [[UILabel alloc]init];
    showLabel.hidden = YES;
    self.showLabel = showLabel;
    [self.view addSubview:showLabel];
    
    showLabel.backgroundColor = SWColor(117, 117, 117, 0.5);
    showLabel.textAlignment = NSTextAlignmentCenter;
    
    CGFloat showLabelY = self.view.frame.size.height * 0.65 ;
    CGFloat showLabelW = self.view.frame.size.width * 0.40;
    CGFloat showLabelX = (self.view.frame.size.width - showLabelW) * 0.5;
    CGFloat showLabelH = SWCommonH;
    showLabel.font = SWCommonFont;
    self.showLabel.text = @"按进度效果更好";
    self.showLabel.frame = CGRectMake(showLabelX, showLabelY, showLabelW, showLabelH);
    
    
    
    //1.增加换单词按钮
    UIButton  *exchangBtn = [[UIButton alloc]init];
    [self.view addSubview:exchangBtn];
    
    CGFloat exchangBtnX = 50;
    CGFloat exchangBtnY = CGRectGetMaxY(self.showLabel.frame) + SWPadding;
    CGFloat exchangBtnW = self.view.frame.size.width * 0.2;
    CGFloat exchangBtnH = SWCommonH;
    
    exchangBtn.frame = CGRectMake(exchangBtnX, exchangBtnY, exchangBtnW, exchangBtnH);
    
    [exchangBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [exchangBtn setTitle:@"换单词" forState:UIControlStateNormal];
    [exchangBtn setBackgroundImage:[UIImage resizedImageWithName:@"navigationbar_button_background_pushed"] forState:UIControlStateNormal];
    exchangBtn.titleLabel.font = SWCommonFont;
    [exchangBtn setTitleColor:SWColor(215, 110, 45, 1) forState:UIControlStateNormal];
      [exchangBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];

    [exchangBtn setBackgroundImage:[UIImage resizedImageWithName:@"new_feature_finish_button" ] forState:UIControlStateHighlighted];
    
    [exchangBtn  addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];

    //3.增加提示按钮
    UILabel  *countLabel = [[UILabel alloc]init];
    [self.view addSubview:countLabel];
    self.countLabel = countLabel;
    
    CGFloat countLabelX = 175;
    CGFloat countLabelY = exchangBtnY;
    CGFloat countLabelW = self.view.frame.size.width * 0.35;
    CGFloat countLabelH = SWCommonH;
    
    countLabel.frame = CGRectMake(countLabelX, countLabelY, countLabelW, countLabelH);
    NSString  *countStr = [NSString stringWithFormat:@"本次已学%d个",self.count];
    countLabel.font  = SWCommonFont;

    countLabel.textAlignment = NSTextAlignmentCenter;
    countLabel.text = countStr;
    countLabel.backgroundColor = SWColor(117, 117, 117, 0.5);;
    
    //4.加载底部提示文字
    UIButton  *buttomBtn = [[UIButton alloc]init];
    [self.view addSubview:buttomBtn];
    
    CGFloat buttomViewX = 0;
    CGFloat buttomViewY = self.view.frame.size.height -  90;
    CGFloat buttomViewW = self.view.frame.size.width;
    CGFloat buttomViewH = 40;
    
    buttomBtn.frame = CGRectMake(buttomViewX, buttomViewY, buttomViewW, buttomViewH);
    [buttomBtn setTitle:@"每天五个单词，3个月搞定iOS开发英语" forState:UIControlStateNormal];
    buttomBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [buttomBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    buttomBtn.backgroundColor = SWColor(117, 117, 117, 0.5);
    
    
}

#pragma mark   实现换单词点按钮击时间
/**
 *  实现换单词点按钮击时间
 */
-(void)buttonClick
{
    //换单词
    [self loadTodayData];
  

}
#pragma mark   加载当天学习的数据
/**
 *  加载当天学习的数据
 */
-(void)loadTodayData

{
    //当天的学习单词个数
    self.count++;
    if (self.count > 5) {
        self.showLabel.hidden = NO;
        if (self.count > 10) {
            self.showLabel.textColor = [UIColor redColor];
        }
    }
    
    self.countLabel.text = [NSString stringWithFormat:@"本次已学%d个",self.count];
    
    
    //取出未学的单词
    NSMutableArray *remainArray = [SWWordsReadWriteTool  wordsRemainFromFile];
    
    //判断是否是最后一个单词，如果是弹框
    
    if (remainArray.count > 1) {
       
    //随机加载单词
    int index =  arc4random() % remainArray.count;
    SWWord  *oneWord = remainArray[index];
    
    //标识为已经学
    oneWord.revise = YES;
    
    //从未学单词删除
    [remainArray removeObjectAtIndex:index];
    
    //存档
    
    [SWWordsReadWriteTool wordsRemainToFile:remainArray];
    
    
    //取出已经学的单词
    NSMutableArray  *reviseArray  = [SWWordsReadWriteTool wordsReviseFromFile];
    //已学单词中增加
    //第一次存储，为空
    if (nil ==  reviseArray) {
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:oneWord];
         [SWWordsReadWriteTool wordsReviseToFile:array];
    }else {
        //第一次以后用这个
        [reviseArray addObject:oneWord];
         [SWWordsReadWriteTool wordsReviseToFile:reviseArray];
    }
    
    
    self.oneWord = oneWord;
    
    [[[SWSoundTool alloc]init]  soundWithString:oneWord.word]; 
    }else {
    
        self.view.userInteractionEnabled = NO;
        self.countLabel.text = @"恭喜你全部学完了！";
    
    }
    
}


@end
