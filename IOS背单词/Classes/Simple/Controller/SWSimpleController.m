//
//  SWSimpleController.m
//  IOS背单词
//
//  Created by Sword on 14-5-16.
//  Copyright (c) 2014年 Sword. All rights reserved.
//

#import "SWSimpleController.h"
#import "SWWord.h"
#import "SWWordCell.h"
#import "SWSimpleViewController.h"
#import "SWWordsReadWriteTool.h"

@interface SWSimpleController ()
/**
 *  Word数组
 */
@property(nonatomic,strong)NSArray  *wordArray;


@end

@implementation SWSimpleController


#pragma mark  每次进入都重新获取数据刷新表格
/**
 *  每次进入都重新获取数据刷新表格
 */
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.wordArray = [SWWordsReadWriteTool  wordsReviseFromFile];
    
    
    [self.tableView reloadData];

}


- (void)viewDidLoad
{
    [super viewDidLoad];
   // self.view.backgroundColor = [UIColor whiteColor];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.wordArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWWordCell *cell = [SWWordCell  cellWithTableView:tableView];
    SWWord *oneWord = self.wordArray[indexPath.row];
    cell.oneWord = oneWord;
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
   SWSimpleViewController *simpleVC =  [[SWSimpleViewController alloc]init];
    SWWord *oneWord = self.wordArray[indexPath.row];
    simpleVC.oneWord = oneWord;
    
    [self.navigationController  pushViewController:simpleVC animated:YES];
    
}
@end
