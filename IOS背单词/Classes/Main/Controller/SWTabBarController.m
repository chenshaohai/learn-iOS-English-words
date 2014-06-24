//
//  SWTabBarController.m
//  IOS背单词
//
//  Created by Sword on 12-5-16.
//  Copyright (c) 2012年 Sword. All rights reserved.
//

#import "SWTabBarController.h"
#import "SWTabBar.h"
#import "SWSimpleController.h"
#import "SWDetaileController.h"
#import "SWAddController.h"
#import "SWRevisesController.h"
#import "SWMoreController.h"
#import "SWNavigationController.h"
#import "UIImage+MJ.h"


@interface SWTabBarController ()<SWTabBarDelegate>
/**
 *  自定义的tabbar
 */
@property (nonatomic, weak) SWTabBar *customTabBar;

@end

@implementation SWTabBarController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化tabbar
    [self setupTabbar];
    
    // 初始化所有的子控制器
    [self setupAllChildViewControllers];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

/**
 *  初始化tabbar
 */
- (void)setupTabbar
{
    SWTabBar *customTabBar = [[SWTabBar alloc] init];
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
}
#pragma mark - 代理方法

/**
 *  监听tabbar按钮的改变
 *  @param from   原来选中的位置
 *  @param to     最新选中的位置
 */
- (void)tabBar:(SWTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to
{
    self.selectedIndex = to;
    
}
#pragma mark 代理方法加号按钮点击
/**
 * 代理方法加号按钮点击
 */
-(void)tabBarWithPlusButtonClick:(SWTabBar *)tabBar
{
    //加号控制器包装一个导航控制器，modal进入
    SWAddController *addVC = [[SWAddController alloc]init];
    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:addVC];

    [self presentViewController:nvc animated:YES completion:nil];

}


/**
 *  初始化所有的子控制器
 */
- (void)setupAllChildViewControllers
{
    
    // 1.今日学习
    SWRevisesController *revise = [[SWRevisesController alloc] init];
    [self setupChildViewController:revise title:@"本次学习" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    
    
    // 2.复习
    SWSimpleController *simple = [[SWSimpleController alloc] init];
    [self setupChildViewController:simple title:@"复习" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    
    // 3.详细汇总
    SWDetaileController *detaile = [[SWDetaileController alloc] init];
    [self setupChildViewController:detaile title:@"详细汇总" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
       
    // 4.更多
    SWMoreController *more = [[SWMoreController alloc] init];
    [self setupChildViewController:more title:@"说明" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
}

/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.设置控制器的属性
    childVc.title = title;
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageWithName:imageName];
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageWithName:selectedImageName];
    if (IOS7) {
        childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    } else {
        childVc.tabBarItem.selectedImage = selectedImage;
    }
    
    // 2.包装一个导航控制器
    SWNavigationController *nav = [[SWNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    // 3.添加tabbar内部的按钮
    [self.customTabBar addTabBarButtonWithItem:childVc.tabBarItem];
}
@end
