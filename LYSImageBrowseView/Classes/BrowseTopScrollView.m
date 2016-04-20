//
//  BrowseTopScrollView.m
//  BrowseImagesImplementation
//
//  Created by shuang on 15/5/21.
//  Copyright (c) 2015年 shuang. All rights reserved.
//

#import "BrowseTopScrollView.h"
#import "Header.h"

@interface BrowseTopScrollView ()<UIScrollViewDelegate>
{
    UIImageView *imgView;
    
    //记录自己的位置
    CGRect scaleOriginRect;
    
    //图片的大小
    CGSize imgSize;
    
    //缩放前大小
    CGRect initRect;
}

@end

@implementation BrowseTopScrollView

#pragma mark---- 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.delegate = self;
        self.bouncesZoom = YES;
        self.backgroundColor = [UIColor clearColor];
        
        self.minimumZoomScale = 1.0;
        self.maximumZoomScale = 2.0;
        imgView = [[UIImageView alloc] init];
        imgView.clipsToBounds = YES;
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:imgView];
        imgView.userInteractionEnabled = YES;
        
        //长按手势
        UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressScrollViewChangedAction:)];
        //        longPress.minimumPressDuration = 0.5;
        [imgView addGestureRecognizer:longPress];
    
    }
    
    return self;
}

#pragma mark----设置content frame
- (void)setContentWithFram:(CGRect)rect
{
    imgView.frame = rect;
    initRect = rect;
    
    
}
- (void)setImage:(UIImage *)image
{
    if (image) {
        imgView.image = image;
        imgSize = image.size;
        
        //判断缩放的值
        float scaleX = Width / imgSize.width;
        float scaleY = Height /imgSize.height;
        
        //倍数小的先到边缘
        if (scaleX > scaleY) {
            //y方向先到边缘
            //计算放大后的imageView的宽度
            float imgViewWidth = scaleY*imgSize.width;
            //计算最大缩放比例
//            self.maximumZoomScale = Width / imgViewWidth;
            //记录放大后位置，y方向到最上端
            scaleOriginRect = (CGRect){Width/2 - imgViewWidth/2,0,imgViewWidth,Height};
            
        }else{
            
            //x方向先到边缘
            float imgViewHeight = scaleX*imgSize.height;
//            self.maximumZoomScale = Height / imgViewHeight;
            scaleOriginRect = (CGRect){0,Height/2 - imgViewHeight/2,Width,imgViewHeight};
            
        }
    }
}
//放大
- (void)setAnimationRect
{
    imgView.frame = scaleOriginRect;
}
//返回原来大小
- (void)rechangeInitRect
{
    self.zoomScale = 1.0;
    /*
     1、回到原来界面的初始位置
     imgView.frame = initRect;
     */
    
    /*
     1、回到原来界面的中心点位置
     imgView.frame = CGRectMake(Width/2, Height/2, 0, 0);
     */
    
    //由于图片的初始位置超出了屏幕的边缘，返回到初始位置用户体验不太好，所以选择返回中心点位置。
    imgView.frame = CGRectMake(Width/2, Height/2, 0, 0);
    
}


#pragma mark ----scrollViewDelegate
//在那个视图上缩放
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return imgView;
}
//缩放的位置
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGSize boundSize = CGSizeMake(Width, Height);
    CGSize contentSize = scrollView.contentSize;
    CGRect imageFrame = imgView.frame;
    
    //中心点
    CGPoint centerPoint = CGPointMake(contentSize.width/2, contentSize.height/2);
    
    //水平中心
    if (imageFrame.size.width <= boundSize.width) {
        centerPoint.x = boundSize.width/2;
    }
    //垂直中心
    if (imageFrame.size.height <= boundSize.height) {
        centerPoint.y = boundSize.height/2;
    }
    
    imgView.center = centerPoint;
    
    
}
//缩放到边界值，停止缩放
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    CGFloat zs = scrollView.zoomScale;
    zs = MAX(zs, 0.5);//最小
    zs = MIN(zs, 2.0);//最大
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    scrollView.zoomScale = zs;
    [UIView commitAnimations];
}

#pragma mark ---- touch end 点击大图--缩回小图
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [[event allTouches] anyObject];
    NSTimeInterval delayTime = 0.5;
    switch ([touch tapCount]) {
        case 1:
            //单击事件
            [self performSelector:@selector(singleTap) withObject:nil afterDelay:delayTime];
            break;
        case 2:{
            //消除单击事件
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(singleTap) object:nil];
            //走双击事件
            [self performSelector:@selector(doubleTap) withObject:nil afterDelay:delayTime];
        }
            break;
        default:
            break;
    }
}

- (void)singleTap
{
    //单击
    if ([self.bigDelegate respondsToSelector:@selector(singleTappedBigImageViewAction:)]) {
        [self.bigDelegate singleTappedBigImageViewAction:self];
    }
    
}
- (void)doubleTap
{
    //双击
    if ([self.bigDelegate respondsToSelector:@selector(doubleTappedBigImageViewAction:)]) {
        [self.bigDelegate doubleTappedBigImageViewAction:self];
    }
    
}

#pragma mark == longPress Gesture
- (void)longPressScrollViewChangedAction:(UIPanGestureRecognizer *)panGesture
{
    //long press 会在开始和结束时 都会调用一次
    //将状态区分开，只调用一次即可
    
    if (panGesture.state == UIGestureRecognizerStateEnded) {
        //结束的时候，跳出
        return;
    }else if (panGesture.state == UIGestureRecognizerStateBegan){
        //开始的时候，调用
        if ([self.bigDelegate respondsToSelector:@selector(longPressBigImageViweAction:)]) {
            [self.bigDelegate longPressBigImageViweAction:imgView];
        }
    }
    
}









@end
