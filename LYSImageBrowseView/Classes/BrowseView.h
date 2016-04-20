//
//  BrowseView.h
//  BrowseImagesImplementation
//
//  Created by shuang on 15/5/21.
//  Copyright (c) 2015年 shuang. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 BigViewDelegate
 
 */
@protocol BrowseViewDelegate <NSObject>

/*
 - (void)browseViewDisappear:(id)sender
 主要实现：在 视图消失的时候，需要做的操作。
 
 */
- (void)browseViewDisappear:(id)sender;
/*
 - (void)longPressActionWithImageView:(UIImageView *)imageView;
 主要实现：长按事件。
 */
- (void)longPressActionWithImageView:(UIImageView *)imageView;

@end

@interface BrowseView : UIView

/*
 创建View时需要设置的属性：
 currentIndex：当前点击的图片索引。
 imagesArray：所有图片的数组
 delegate：视图消失 和 长按事件。
 pageControl：需要设置pageControl 的numberOfPages和currentPage。
 */
@property (nonatomic,assign) NSInteger currentIndex;//当前图片
@property (nonatomic,strong) NSArray * imagesArray;//图片数组
@property (nonatomic,assign) id<BrowseViewDelegate> delegate;
@property (nonatomic,strong) UIPageControl * pageControl;//pageControl


/*
 视图将要出现时调用此方法。
 参数sender：为toBrowseImageView 
 */
- (void)browseViewAppear:(id)sender imageArrayCount:(int)imageArrayCount;

- (void)browseViewAppear:(id)sender imagesArray:(NSArray *)imagesArray indext:(int)indext;


@end
