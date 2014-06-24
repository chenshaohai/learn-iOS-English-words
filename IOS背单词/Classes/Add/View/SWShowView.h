//
//  SWShowView.h
//  IOS背单词
//
//  Created by Sword on 14-5-20.
//  Copyright (c) 2014年 Sword. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SWWord;
@class SWShowView;
@protocol SWShowViewDelegate  <NSObject>
@optional

-(void)showViewMissControllerButtonClick:(SWShowView *)showView;


@end


@interface SWShowView : UIView
@property(nonatomic,strong)SWWord *word;
@property(nonatomic,weak)id <SWShowViewDelegate> delegate;

#pragma mark  类方法快创建
/**
 *  类方法快创建
 */
+(SWShowView *)showView;
@end
