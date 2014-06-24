//
//  SWDetailCell.h
//  IOS背单词
//
//  Created by Sword on 14-5-18.
//  Copyright (c) 2014年 Sword. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SWWordFrame;

@interface SWDetailCell : UITableViewCell

+(SWDetailCell *)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)SWWordFrame *wordFrame;

@end
