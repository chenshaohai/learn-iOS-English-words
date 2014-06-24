//
//  SWWordCell.h
//  IOS背单词
//
//  Created by Sword on 14-5-16.
//  Copyright (c) 2014年 Sword. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SWWord;

@interface SWWordCell : UITableViewCell
+(SWWordCell *)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)SWWord *oneWord;
@end
