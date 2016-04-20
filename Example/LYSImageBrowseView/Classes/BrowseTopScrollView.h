//
//  BrowseTopScrollView.h
//  BrowseImagesImplementation
//
//  Created by shuang on 15/5/21.
//  Copyright (c) 2015年 shuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BrowseTopScrollViewDelegate <NSObject>
//单击事件代理
- (void)singleTappedBigImageViewAction:(id)sender;
//双击事件代理
- (void)doubleTappedBigImageViewAction:(id)sender;
//长按事件代理
- (void)longPressBigImageViweAction:(id)sender;

@end

@interface BrowseTopScrollView : UIScrollView
@property (nonatomic,assign) id<BrowseTopScrollViewDelegate> bigDelegate;

//设置当前的frame
- (void)setContentWithFram:(CGRect)rect;
//设置image
- (void)setImage:(UIImage *)image;
//设置出现时的动画
- (void)setAnimationRect;
//设置返回时动画
- (void)rechangeInitRect;


@end
