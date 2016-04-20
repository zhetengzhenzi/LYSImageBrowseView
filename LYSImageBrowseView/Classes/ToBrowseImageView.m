//
//  ToBrowseImageView.m
//  BrowseImagesImplementation
//
//  Created by shuang on 15/5/21.
//  Copyright (c) 2015年 shuang. All rights reserved.
//

#import "ToBrowseImageView.h"

@implementation ToBrowseImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //添加轻怕手势
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageAction:)];
        [self addGestureRecognizer:tap];
        self.clipsToBounds = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.userInteractionEnabled = YES;
        
        
    }
    return self;
}

- (void)tapImageAction:(UITapGestureRecognizer*)tapGesture
{
    if ([self.delegate respondsToSelector:@selector(tappedToBrowseImageViewAction:)]) {
        [self.delegate tappedToBrowseImageViewAction:self];
    }
}
@end
