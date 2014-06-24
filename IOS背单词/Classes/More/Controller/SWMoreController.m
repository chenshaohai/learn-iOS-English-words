//
//  SWMoreController.m
//  IOS背单词
//
//  Created by Sword on 14-5-16.
//  Copyright (c) 2014年 Sword. All rights reserved.
//

#import "SWMoreController.h"
#define  SWPading 10

@interface SWMoreController ()

@end

@implementation SWMoreController

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
    
    [self  setupContent];
}

-(void)setupContent
{
    
    UILabel *label = [[UILabel alloc]init];
    CGFloat  labelX = SWPading;
    CGFloat  labelY = IOS7 ? 94 :30 ;
    CGFloat  labelW = self.view.frame.size.width - 2 * labelX;
    CGFloat  labelH = 150;
    label.frame = CGRectMake(labelX, labelY, labelW, labelH);
    [self.view addSubview:label];
    label.textColor = [UIColor blackColor];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:20];
    label.text = @"     掌握常用的500个左右的词汇量，iOS开发基本没有什么障碍，总体词库是作者3个月逐个累计添加的。按照每天5个单词的节奏来的，100天左右完全可以搞定！";
    
    UILabel *label2 = [[UILabel alloc]init];
    CGFloat  label2X = labelX;
    CGFloat  label2Y = CGRectGetMaxY(label.frame) + SWPading ;
    CGFloat  label2W = labelW;
    CGFloat  label2H = 170;
    label2.frame = CGRectMake(label2X, label2Y, label2W, label2H);
    [self.view addSubview:label2];
    label2.textColor = [UIColor blackColor];
    label2.numberOfLines = 0;
    label2.font = [UIFont systemFontOfSize:20];
    label2.text = @"     部分单词的解析顺序被调整了，iOS开发中的词义被放到了最前面。这个是为了突出重点，可能会不习惯，但一段时间后的复习预览会很有效率！每个单词都值得细读，特别的后面详细的相关例句，是复习iOS开发各知识点的利器！";
    
    SWLog(@"%@",NSStringFromCGRect( label.frame));
    
    
    

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
