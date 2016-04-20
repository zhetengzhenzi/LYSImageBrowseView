//
//  BrowseView.m
//  BrowseImagesImplementation
//
//  Created by shuang on 15/5/21.
//  Copyright (c) 2015年 shuang. All rights reserved.
//

#import "BrowseView.h"
#import "Header.h"
#import "BrowseTopScrollView.h"
#import "ToBrowseImageView.h"

@interface BrowseView ()<UIScrollViewDelegate,UIActionSheetDelegate,BrowseTopScrollViewDelegate>

@property (nonatomic,strong) UIView * panelView;//最底层的View
@property (nonatomic,strong) UIView * markView;//标记
@property (nonatomic,strong) UIScrollView * myScrollView;//底部的scrollView


@end

@implementation BrowseView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
}
- (void)layoutSubviews
{
    self.alpha = 0;
    //设置大图
    self.panelView = [[UIView alloc] initWithFrame:self.bounds];
    self.panelView.backgroundColor = [UIColor clearColor];
    self.panelView.alpha = 0;
    [self addSubview:self.panelView];
    
    self.markView = [[UIView alloc] initWithFrame:self.panelView.bounds];
    self.markView.backgroundColor = [UIColor clearColor];
    self.markView.alpha = 0;
    [self.panelView addSubview:self.markView];
    
    //滚动视图
    self.myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Width+20, Height)];
    [self.panelView addSubview:self.myScrollView];
    self.myScrollView.pagingEnabled = YES;
    self.myScrollView.delegate = self;
    self.myScrollView.contentInset = UIEdgeInsetsMake(0, 1, 0, 1);
    
    //pageController
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(10, Height-50, Width-20, 30)];
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.userInteractionEnabled= NO;
    [self addSubview:self.pageControl];
    

}

#pragma mark -- 显示大图的视图出现的时候
- (void)browseViewAppear:(id)sender imageArrayCount:(int)imageArrayCount
{
    //隐藏系统自带的状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];

    self.alpha = 1;
    _panelView.alpha = 1.0;
    
    //scrollView的contentSize
    CGSize contentSize = self.myScrollView.contentSize;
    contentSize.height = self.bounds.size.height;
    contentSize.width = (Width+20) * imageArrayCount;
    self.myScrollView.contentSize = contentSize;
    
    //一张图片时隐藏pageControl
    if (imageArrayCount<=1) {
        self.pageControl.hidden = YES;
    }else{
        self.pageControl.hidden = NO;
    }
    //pageController的Pages
    self.pageControl.numberOfPages = imageArrayCount;
    
    //sender
    ToBrowseImageView * tmpView = sender;
    
    //转换后的rect
    CGRect convertRect = [[tmpView superview] convertRect:tmpView.frame toView:self.superview];
    CGPoint contentOffset = _myScrollView.contentOffset;
    contentOffset.x = _currentIndex*(Width+20);
    _myScrollView.contentOffset = contentOffset;
    
    //添加小图到大视图上
    [self addSubImgView:tmpView.superview imageArrayCount:imageArrayCount];
    //设置big imageView
    BrowseTopScrollView *browseTopScroll = [[BrowseTopScrollView alloc] initWithFrame:(CGRect){contentOffset,_myScrollView.bounds.size}];
    [browseTopScroll setContentWithFram:convertRect];
    [browseTopScroll setImage:tmpView.image];
    [_myScrollView addSubview:browseTopScroll];
    browseTopScroll.bigDelegate = self;
    
    [self performSelector:@selector(setOriginFrame:) withObject:browseTopScroll afterDelay:0.1];
    
    //设置pageControl 的currentPage
    self.pageControl.currentPage = _currentIndex;
    
}

#pragma mark - custom method
#pragma mark --- 将小图放到大的视图的方法
- (void)addSubImgView:(id)sender imageArrayCount:(int)imageArrayCount
{
    //清除上次加载过的图片
    for (UIView *tmpView in _myScrollView.subviews)
    {
        [tmpView removeFromSuperview];
    }
    
    //遍历新的数组
    for (int i = 0; i < imageArrayCount; i ++)
    {
        if (i == _currentIndex)
        {
            continue;
        }
        //通过数组索引，判断图片视图tag值，创建图片
        ToBrowseImageView *toBrowseImageView = (ToBrowseImageView *)[sender viewWithTag:1000 + i];
        
        //转换后的rect
        CGRect convertRect = [[toBrowseImageView superview] convertRect:toBrowseImageView.frame toView:self.superview];
        BrowseTopScrollView *browseTopScroll = [[BrowseTopScrollView alloc] initWithFrame:(CGRect){i*_myScrollView.bounds.size.width,0,_myScrollView.bounds.size}];
        [browseTopScroll setImage:toBrowseImageView.image];
        [browseTopScroll setContentWithFram:convertRect];
        [_myScrollView addSubview:browseTopScroll];
        browseTopScroll.bigDelegate = self;
        [browseTopScroll setAnimationRect];
    }
}


#pragma mark ----
#pragma mark ---- 没有ToBrowseImageView的时候
#pragma mark -- 显示大图的视图出现的时候
- (void)browseViewAppear:(id)sender imagesArray:(NSArray *)imagesArray indext:(int)indext
{
    //隐藏系统自带的状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    
    self.alpha = 1.0;
    _panelView.alpha = 1.0;
    
    //scrollView的contentSize
    CGSize contentSize = self.myScrollView.contentSize;
    contentSize.height = self.bounds.size.height;
    contentSize.width = (Width+20) * imagesArray.count;
    self.myScrollView.contentSize = contentSize;
    
    //一张图片时隐藏pageControl
    if (imagesArray.count <= 1) {
        self.pageControl.hidden = YES;
    }else{
        self.pageControl.hidden = NO;
    }
    //pageController的Pages
    self.pageControl.numberOfPages = imagesArray.count;
    
    //sender
    //转换后的rect
    CGRect convertRect = [sender convertRect:CGRectMake(Width/2-10, Height/2-10, 10, 10) toView:self.superview];
    CGPoint contentOffset = _myScrollView.contentOffset;
    contentOffset.x = _currentIndex*(Width+20);
    _myScrollView.contentOffset = contentOffset;
    
    //添加小图到大视图上
    [self addSubImgView:sender imageArray:imagesArray];
    //设置big imageView
    BrowseTopScrollView *browseTopScroll = [[BrowseTopScrollView alloc] initWithFrame:(CGRect){contentOffset,_myScrollView.bounds.size}];
    [browseTopScroll setContentWithFram:convertRect];
    [browseTopScroll setImage:[imagesArray objectAtIndex:indext]];
    [_myScrollView addSubview:browseTopScroll];
    browseTopScroll.bigDelegate = self;
    
    [self performSelector:@selector(setOriginFrame:) withObject:browseTopScroll afterDelay:0.1];
    
    //设置pageControl 的currentPage
    self.pageControl.currentPage = _currentIndex;
    
}
#pragma mark - custom method
#pragma mark --- 将小图放到大的视图的方法
- (void)addSubImgView:(id)sender imageArray:(NSArray *)imagesArray
{
    //清除上次加载过的图片
    for (UIView *tmpView in _myScrollView.subviews)
    {
        [tmpView removeFromSuperview];
    }
    
    //遍历新的数组
    for (int i = 0; i < imagesArray.count; i ++)
    {
        if (i == _currentIndex)
        {
            continue;
        }
        //通过数组索引，判断图片视图tag值，创建图片
        
        //转换后的rect
        CGRect convertRect = [sender convertRect:CGRectMake(Width/2-10, Height/2-10, 10, 10) toView:self.superview];
        BrowseTopScrollView *browseTopScroll = [[BrowseTopScrollView alloc] initWithFrame:(CGRect){i*_myScrollView.bounds.size.width,0,_myScrollView.bounds.size}];
        [browseTopScroll setImage:[imagesArray objectAtIndex:i]];
        [browseTopScroll setContentWithFram:convertRect];
        [_myScrollView addSubview:browseTopScroll];
        browseTopScroll.bigDelegate = self;
        [browseTopScroll setAnimationRect];
    }
}



- (void) setOriginFrame:(BrowseTopScrollView *) sender
{
    [UIView animateWithDuration:0.4 animations:^{
        [sender setAnimationRect];
        _markView.alpha = 1.0;
    }];
}



#pragma mark ----bigImageScrollViewDelegate
#pragma mark == tap
- (void)singleTappedBigImageViewAction:(id)sender
{
    BrowseTopScrollView *browseTopScroll = sender;
    __block BrowseView *weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.alpha = 0;
        _markView.alpha = 0;
        [browseTopScroll rechangeInitRect];
    } completion:^(BOOL finished) {
        _panelView.alpha = 0;
        weakSelf.alpha = 0;
        weakSelf.pageControl.hidden = YES;
        weakSelf.pageControl.numberOfPages = 0;
        if ([weakSelf.delegate respondsToSelector:@selector(browseViewDisappear:)]) {
            [weakSelf.delegate browseViewDisappear:weakSelf];
        }
    }];
    
}
#pragma mark == double tap
- (void)doubleTappedBigImageViewAction:(id)sender
{
    BrowseTopScrollView * browseTopScroll = sender;
    //zs is zoomScale 缩放比例
    CGFloat zs = browseTopScroll.zoomScale;
    zs = (zs == 1.0) ? 2.0 : 1.0;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    browseTopScroll.zoomScale = zs;
    [UIView commitAnimations];
    
    
}
#pragma mark == long press
- (void)longPressBigImageViweAction:(id)sender
{
   //点击的imageView
    UIImageView * imageView = sender;
    
    if ([self.delegate respondsToSelector:@selector(longPressActionWithImageView:)]) {
        [self.delegate longPressActionWithImageView:imageView];
    }
    
}


#pragma mark - scroll delegate
#pragma mark ---- 
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //计算currentIndex
    CGFloat pageWidth = scrollView.frame.size.width;
    _currentIndex = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    //当scrollView滚动结束后，将所有的缩放都还原到原始比例：1.0
    if (scrollView == self.myScrollView){
        for (UIScrollView *s in scrollView.subviews){
            if ([s isKindOfClass:[UIScrollView class]]){
                [s setZoomScale:1.0];
            }
        }
    }
    //设置pageControl随scrollView的滚动，跳到相应的页
    self.pageControl.currentPage = scrollView.contentOffset.x/Width;
    
}



@end
