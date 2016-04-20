//
//  BrowseImageFramework.h
//  BrowseImageFramework
//
//  Created by shuang on 15/5/21.
//  Copyright (c) 2015年 shuang. All rights reserved.
//


/*
 
 *******BrowseImageFramework 使用说明********
 
 1、导入：#import <BrowseImageFramework/BrowseImageFramework.h>
 
 2、根据需要创建ToBrowseImageView（一个/多个），并实现其代理方法：
 
     1） - (void)tappedToBrowseImageViewAction:(id)sender;
     用于imageView的点击事件
     参数seder：为 ToBrowseImageView
 
 注意：ToBrowseImageView的tag值必须从1000+i开始。
 
 
 3、创建BrowseView，根据需要实现其代理方法：
 
     1） - (void)browseViewDisappear:(id)sender
     主要实现：在 视图消失的时候，需要做的操作。
     
     2） - (void)longPressActionWithButtonIndex:(NSUInteger)buttonIndex;
     主要实现：长按事件中，弹出的action sheet中的按钮的点击事件。
     目前点击事件有：保存图片 和 取消。
 
 
 */


#import <UIKit/UIKit.h>
#import "BrowseView.h"
#import "ToBrowseImageView.h"
#import "Header.h"

