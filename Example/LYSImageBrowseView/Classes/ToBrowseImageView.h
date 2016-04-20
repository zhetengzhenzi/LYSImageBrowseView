//
//  ToBrowseImageView.h
//  BrowseImagesImplementation
//
//  Created by shuang on 15/5/21.
//  Copyright (c) 2015年 shuang. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 ToBrowseImageViewDelegate
 用于点击ToBrowseImageView时调用
 */
@protocol ToBrowseImageViewDelegate <NSObject>
/*
 - (void)tappedToBrowseImageViewAction:(id)sender;
 用于imageView的点击事件
 参数seder：为 ToBrowseImageView
 */
- (void)tappedToBrowseImageViewAction:(id)sender;

@end

@interface ToBrowseImageView : UIImageView

/*
 delegate:用于点击事件
 */
@property (nonatomic,assign) id<ToBrowseImageViewDelegate> delegate;

/*
 identifier 用来标记ToBrowseImageView
 */
@property (nonatomic,strong) id identifier;

@end
