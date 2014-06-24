//
//  SWTabBar.h
//  IOS背单词
//
//  Created by Sword on 14-5-16.
//  Copyright (c) 2014年 Sword. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  SWTabBar;

@protocol SWTabBarDelegate <NSObject>

@optional

- (void)tabBar:(SWTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to;
-(void)tabBarWithPlusButtonClick:(SWTabBar *)tabBar ;

@end


@interface SWTabBar : UIView
@property(nonatomic,strong)UITabBarItem *item;
@property(nonatomic,weak)id <SWTabBarDelegate> delegate;
+(instancetype)tabBar;

-(void)addTabBarButtonWithItem:(UITabBarItem *)item;
@end
