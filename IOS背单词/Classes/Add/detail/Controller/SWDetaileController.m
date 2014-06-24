//
//  SWDetaileController.m
//  IOS背单词
//
//  Created by Sword on 14-5-16.
//  Copyright (c) 2014年 Sword. All rights reserved.
//

#import "SWDetaileController.h"
#import "SWWord.h"
#import "SWDetailCell.h"
#import "SWWordFrame.h"

@interface SWDetaileController ()
@property(nonatomic,strong)NSArray *wordArray;
@end

@implementation SWDetaileController

#pragma mark  加载wordArray
/**
 *  加载wordArray
 */
-(NSArray *)wordArray
{
    if (nil == _wordArray) {
        //取出存档文件
        NSString *path = SWFilePath;
        NSArray *array   = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        NSMutableArray *mutableArray = [NSMutableArray array];
        for (SWWord *oneWord in array) {
            SWWordFrame  * wordFrame = [[SWWordFrame alloc]init];
            wordFrame.oneWord = oneWord;
            [mutableArray addObject:wordFrame];
        }
        _wordArray = mutableArray;
    }
    
    return _wordArray;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.allowsSelection = NO; // 不允许选中
    
    
}



#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.wordArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    SWDetailCell *cell = [SWDetailCell  cellWithTableView:tableView];
    SWWordFrame *WordFrame = self.wordArray[indexPath.row];
    cell.wordFrame = WordFrame;
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWWordFrame *WordFrame = self.wordArray[indexPath.row];
    return  WordFrame.CellHight;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
