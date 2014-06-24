//
//  SWWordCell.m
//  IOS背单词
//
//  Created by Sword on 14-5-16.
//  Copyright (c) 2014年 Sword. All rights reserved.
//

#import "SWWordCell.h"
#import "SWWord.h"

@implementation SWWordCell

+(SWWordCell *)cellWithTableView:(UITableView *)tableView
{
    static  NSString *ID = @"word";
    SWWordCell  *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SWWordCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //设置CELL右边箭头
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageWithName:@"navigationbar_more_highlighted"]];
      }
    return self;
}

-(void)setOneWord:(SWWord *)oneWord
{
    _oneWord = oneWord;

    self.textLabel.text = oneWord.word;
  
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
   [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
