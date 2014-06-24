//
//  SWWordFrame.h
//  IOS背单词
//
//  Created by Sword on 14-5-17.
//  Copyright (c) 2014年 Sword. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SWWord;
@interface SWWordFrame : NSObject
#pragma mark  喇叭
/**
 *  喇叭
 */
@property (assign, nonatomic) CGRect soundButtonF;
#pragma mark  单词
/**
 *  单词
 */
@property (assign, nonatomic)  CGRect wordLabelF;
#pragma mark  音标
/**
 *  音标
 */
@property (assign, nonatomic)  CGRect phoneticLabelF;
#pragma mark  词义
/**
 *  词义
 */
@property (assign, nonatomic)  CGRect transLabelF;

#pragma mark  类别
/**
 *  类别
 */
@property (assign, nonatomic)CGRect tagsLabelF;

#pragma mark  错误次数
/**
 *  错误次数
 */
@property (assign, nonatomic)CGRect mistakesLabelF;


#pragma mark 分割线
/**
 *  分割线
 */
@property (assign, nonatomic)CGRect divideViewF;
#pragma mark CELL高度
/**
 *  CELL高度
 */
@property(nonatomic,assign)float  CellHight;

@property(nonatomic,strong)SWWord *oneWord;


@end
