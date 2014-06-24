//
//  SWAddController.m
//  IOS背单词
//
//  Created by Sword on 14-5-16.
//  Copyright (c) 2014年 Sword. All rights reserved.
//

#import "SWAddController.h"
#import "SWWordSearchTool.h"
#import "SWWord.h"
#import "SWShowView.h"

@interface SWAddController ()<UITextFieldDelegate,SWShowViewDelegate>
#pragma mark 搜索栏
/**
 *  搜索栏
 */
@property(nonatomic,weak)UITextField *searchField;
#pragma mark 添加单词View
/**
 *  添加单词View
 */
@property(nonatomic,strong)SWShowView *showView;

@end

@implementation SWAddController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //设置顶部导航栏主题
    [self setupNavigationgTheme];
    
    
    // 添加顶部搜索栏
    [self  setupSearchField];
    
    // 加载中间的各控件
    [self setupMiddleView];
    
}
#pragma mark  设置顶部导航栏主题

/**
 *  设置顶部导航栏主题

 */
-(void)setupNavigationgTheme
{
 self.navigationItem.title = @"查询/添加";
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(showViewMissControllerButtonClick:)];
}

#pragma mark  添加顶部搜索栏
/**
 *  添加顶部搜索栏
 */
-(void)setupSearchField
{
    UITextField  *searchField = [[UITextField alloc]init];
    searchField.delegate = self;
    
    [self.view addSubview:searchField];
    self.searchField = searchField;
    
    CGFloat  searchFieldW = self.view.frame.size.width * 0.6;
    CGFloat  searchFieldY = IOS7 ? 70 : 50;
    CGFloat  searchFieldH = 30;
    CGFloat  searchFieldX   = (self.view.frame.size.width - searchFieldW) * 0.5;
    
    searchField.frame = CGRectMake(searchFieldX , searchFieldY, searchFieldW, searchFieldH);
    
    searchField.placeholder = @"请输入单词网络搜索";
    
    searchField.font = [UIFont systemFontOfSize:13];
    searchField.background = [UIImage resizedImageWithName:@"searchbar_textfield_background"];
    // 左边的放大镜图标
    UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageWithName:@"searchbar_textfield_search_icon"]];
    searchField.leftView = iconView;
    searchField.leftViewMode = UITextFieldViewModeAlways;
    iconView.contentMode = UIViewContentModeCenter;
    // 右边的清除按钮
    searchField.clearButtonMode = UITextFieldViewModeAlways;
    // 设置键盘右下角按钮的样式
    searchField.returnKeyType = UIReturnKeySearch;
    searchField.enablesReturnKeyAutomatically = YES;
    

}
#pragma mark  加载中间的各控件
/**
 *  加载中间的各控件
 */
-(void)setupMiddleView
{
    SWShowView *showView = [SWShowView showView];
    [self.view addSubview:showView];
    self.showView = showView;
    self.showView.delegate = self;

    showView.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height * 0.4);

}

#pragma mark  中间的View按钮点击时间的代理方法
/**
 *  中间的View按钮点击时间的代理方法
 */
-(void)showViewMissControllerButtonClick:(SWShowView *)showView
{

    [self  dismissViewControllerAnimated:YES completion:nil];

}



#pragma mark - 文本框代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view  endEditing:YES];
    // 如果文本框没有内容，不要联网搜索
    if (textField.text.length > 0) {
        
        // 1.向工具类发送请求
        [[[SWWordSearchTool alloc]init] wordSearch:textField.text success:^(SWWord *oneWord) {
            //给showView传递模型
            self.showView.word = oneWord;
            
        } failure:^(NSError *error) {
#warning  TODO
         SWWord *mistakeWord =  [[SWWord alloc]init];
            mistakeWord.trans = @"网络不给力，请稍后再试！";
            self.showView.word = mistakeWord;
        }];
        
        
        // 退出键盘
        [textField resignFirstResponder];
    }
    
    return YES;
}

@end
