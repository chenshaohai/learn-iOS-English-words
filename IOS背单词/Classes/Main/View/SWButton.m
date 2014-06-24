//
//  SWButton.m
//  IOS背单词
//
//  Created by Sword on 14-5-16.
//  Copyright (c) 2014年 Sword. All rights reserved.
//

#import "SWButton.h"
#import "UIImage+MJ.h"
// 图标的比例
#define SWTabBarButtonImageRatio 0.6
// 按钮的默认文字颜色
#define  SWTabBarButtonTitleColor (IOS7 ? [UIColor blackColor] : [UIColor whiteColor])
// 按钮的选中文字颜色
#define  SWTabBarButtonTitleSelectedColor (IOS7 ? SWColor(234, 103, 7 ,1.0) : SWColor(248, 139, 0 , 1.0))

@implementation SWButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 图标居中
        self.imageView.contentMode = UIViewContentModeCenter;
        // 文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 字体大小
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        // 文字颜色
        [self setTitleColor:SWTabBarButtonTitleColor forState:UIControlStateNormal];
        [self setTitleColor:SWTabBarButtonTitleSelectedColor forState:UIControlStateSelected];
        
        if (!IOS7) { // 非iOS7下,设置按钮选中时的背景
            [self setBackgroundImage:[UIImage imageWithName:@"tabbar_slider"] forState:UIControlStateSelected];
        }    }
    return self;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * SWTabBarButtonImageRatio;
    return CGRectMake(0, 0, imageW, imageH);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * SWTabBarButtonImageRatio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
    
}

-(void)setItem:(UITabBarItem *)item
{
    _item = item ;
    // 设置文字
    [self setTitle:item.title forState:UIControlStateSelected];
    [self setTitle:item.title forState:UIControlStateNormal];
    
    // 设置图片
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateSelected];
}

@end
