//
//  SWFirstController.m
//  IOS背单词
//
//  Created by Sword on 14-5-17.
//  Copyright (c) 2014年 Sword. All rights reserved.
//

#import "SWFirstController.h"
#import "SWWord.h"
#import "NSString+Prefix.h"
#import "SWTabBarController.h"
#import "SWWordsReadWriteTool.h"
#define  SWFirstImageCount  3

#define fourInch ([UIScreen mainScreen].bounds.size.height == 568)

@interface SWFirstController ()< NSXMLParserDelegate, UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;
#pragma mark  当前单词
/**
 *  当前单词
 */
@property(nonatomic,copy)SWWord   *currentWord;
#pragma mark  单词顺序
/**
 *  单词顺序
 */
@property(nonatomic,assign)NSInteger *order;
#pragma mark  XML解析出来的临时字符串
/**
 *  XML解析出来的临时字符串
 */
@property(nonatomic,copy)NSMutableString   *elementString;
#pragma mark  XML解析出来的数组
/**
 *  XML解析出来的数组
 */
@property(nonatomic,strong)NSMutableArray  *dataList;
#pragma mark  XML解析出来的数组取出前面的空格和回车键以后的Word数组
/**
 *  XML解析出来的Word数组
 */
@property(nonatomic,strong)NSMutableArray  *wordArray;

@end

@implementation SWFirstController

#pragma mark  懒加载wordArray
/**
 *   懒加载wordArray
 */
-(NSMutableArray *)wordArray
{
    if(nil == _wordArray)
    {
        _wordArray = [NSMutableArray array ];
        
    }
    return _wordArray;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // 0.解析XML文件
    [self xmlParse];
    
    // 1.添加UISrollView
    [self setupScrollView];
    
    // 2.添加pageControl
    [self setupPageControl];
}

#pragma mark  解析XML文件
/**
 *  解析XML文件
 */
-(void)xmlParse
{
    // 1. 确定地址
    NSString *str =[[NSBundle mainBundle]pathForResource:@"word.xml" ofType:nil];
    
    NSURL *url = [NSURL fileURLWithPath:str];
    NSData *data = [NSData dataWithContentsOfURL:url];
    // 2. 创建NSXMLPaser的实例，
    NSXMLParser *paser = [[NSXMLParser alloc]initWithData:data];
    // 3. 定义解析器代理
    [paser setDelegate:self];
    
    // 4. 解析器解析
    [paser parse];
    
    // 5. 通过代理方法进行解析
}
#pragma mark - XML解析器代理方法
#pragma mark   1. 开始解析元素
/**
 *   1. 开始解析元素
 */
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"item"]) {
        // 初始化当前节点
        _currentWord = [[SWWord alloc]init];
    }
}
#pragma mark   2. 文本节点
/**
 *   2. 文本节点
 */
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    // 因为是多次的，所以，在多次节点内容是，我们做拼接字符串的工作
    [_elementString appendString:string];
}
#pragma mark   3. 结束某个节点
/**
 *   3. 结束某个节点
 */
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    NSString *string = [NSString stringWithString:_elementString];
    
    if ([elementName isEqualToString:@"word"]) {
        [_currentWord setWord:string];
    } else if ([elementName isEqualToString:@"trans"]) {
        [_currentWord setTrans:string];
    } else if ([elementName isEqualToString:@"phonetic"]) {
        [_currentWord setPhonetic:string];
    } else if ([elementName isEqualToString:@"tags"]) {
        [_currentWord setTags:string];
    } else if ([elementName isEqualToString:@"progress"]) {
        [_currentWord setProgress:string];
    } else if ([elementName isEqualToString:@"item"]) {
        // 这是一个完整节点，需要在这里将Word对象添加到数组！
        [_dataList addObject:_currentWord];
    }
    
    // 清空_elementString
    [_elementString setString:@""];
}
#pragma mark   4. 开始解析XML文档
/**
 *   4. 开始解析XML文档
 */
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    // 初始化成员变量
    if (_elementString == nil) {
        _elementString = [[NSMutableString alloc]init];
    }
    
    // 初始化数组
    if (_dataList == nil) {
        _dataList = [NSMutableArray array];
    }
}
#pragma mark   5. 解析XML文档完成 转换成前面无空格无回车的单词数组
/**
 *   5. 解析XML文档完成 转换成前面无空格无回车的单词数组
 */
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    for (SWWord *word in self.dataList) {
        
        SWWord *tempWord = [[SWWord alloc]init];
       
        tempWord.word = [word.word  removePrefixEnterAndSpace];
        
        
        tempWord.progress = [word.progress  removePrefixEnterAndSpace];
        tempWord.phonetic =  [word.phonetic  removePrefixEnterAndSpace];
        tempWord.tags = [word.tags  removePrefixEnterAndSpace];
        tempWord.trans =  [word.trans  removePrefixEnterAndSpace];
        tempWord.mistakes = 0;
        tempWord.revise = NO;
        [self.wordArray addObject:tempWord];
    }
    
    //存档总体单词
    [SWWordsReadWriteTool wordsToFile:self.wordArray ];
    //存档未学单词
    [SWWordsReadWriteTool wordsRemainToFile:self.wordArray];
    //SWLog(@"%d",self.wordArray.count);
}


/**
 *  添加pageControl
 */
- (void)setupPageControl
{
    // 1.添加
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = SWFirstImageCount;
    CGFloat centerX = self.view.frame.size.width * 0.5;
    CGFloat centerY = self.view.frame.size.height - 30;
    pageControl.center = CGPointMake(centerX, centerY);
    pageControl.bounds = CGRectMake(0, 0, 100, 30);
    pageControl.userInteractionEnabled = NO;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
    // 2.设置圆点的颜色
    pageControl.currentPageIndicatorTintColor = SWColor(253, 98, 42 , 1.0);
    pageControl.pageIndicatorTintColor = SWColor(189, 189, 189 , 1.0);
}

/**
 *  添加UISrollView
 */
- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    // 2.添加图片
    CGFloat imageW = scrollView.frame.size.width;
    CGFloat imageH = scrollView.frame.size.height;
    for (int index = 0; index < SWFirstImageCount; index++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        
        NSString  *name = nil;
        if (fourInch) {
            name = [NSString stringWithFormat:@"new_feature_%d", index + 1];
        }else {
            name = [NSString stringWithFormat:@"feature_%d", index + 1];

        }
        // 设置图片
        imageView.image = [UIImage imageWithName:name];
        
        // 设置frame
        CGFloat imageX = index * imageW;
        imageView.frame = CGRectMake(imageX, 0, imageW, imageH);
        
        [scrollView addSubview:imageView];
        
        // 在最后一个图片上面添加按钮
        if (index == SWFirstImageCount - 1) {
            [self setupLastImageView:imageView];
        }
    }
    
    // 3.设置滚动的内容尺寸
    scrollView.contentSize = CGSizeMake(imageW * SWFirstImageCount, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
}

/**
 *  添加内容到最后一个图片
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    // 0.让imageView能跟用户交互
    imageView.userInteractionEnabled = YES;
    
    // 1.添加开始按钮
    UIButton *startButton = [[UIButton alloc] init];
    [startButton setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    
    // 2.设置frame
    CGFloat centerX = imageView.frame.size.width * 0.5;
    CGFloat centerY = imageView.frame.size.height * 0.6;
    startButton.center = CGPointMake(centerX, centerY);
    startButton.bounds = (CGRect){CGPointZero, startButton.currentBackgroundImage.size};
    
    // 3.设置文字
    [startButton setTitle:@"开始单词" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startButton];
    
}

/**
 *  开始单词
 */
- (void)start
{
    // 显示状态栏
    [UIApplication sharedApplication].statusBarHidden = NO;
    // 切换窗口的根控制器
    self.view.window.rootViewController = [[SWTabBarController alloc] init];
}



/**
 *  只要UIScrollView滚动了,就会调用
 *
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 1.取出水平方向上滚动的距离
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 2.求出页码
    double pageDouble = offsetX / scrollView.frame.size.width;
    int pageInt = (int)(pageDouble + 0.5);
    self.pageControl.currentPage = pageInt;
}


@end
