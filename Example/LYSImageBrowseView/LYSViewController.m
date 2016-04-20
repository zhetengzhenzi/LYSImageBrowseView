//
//  LYSViewController.m
//  LYSImageBrowseView
//
//  Created by liuyushuang@duia.com on 04/20/2016.
//  Copyright (c) 2016 liuyushuang@duia.com. All rights reserved.
//

#import "LYSViewController.h"
#import "BrowseImageFramework.h"


@interface LYSViewController ()<UIScrollViewDelegate,ToBrowseImageViewDelegate,BrowseViewDelegate,UIActionSheetDelegate>
@property (nonatomic,strong) BrowseView *browseView;
@property (nonatomic,strong) NSArray *imgArray;


@end

@implementation LYSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    //设置小图片
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, Width , (Width-40)/3+20)];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor grayColor];
    
    //图片的数组
    self.imgArray = [[NSArray alloc]init];
    //        UIImage * souceImage1 = [UIImage imageNamed:@"1.jpg"];
    
    self.imgArray = @[[UIImage imageNamed:@"1.jpg"],[UIImage imageNamed:@"2.jpg"],[UIImage imageNamed:@"3.jpg"],[UIImage imageNamed:@"4.jpg"],[UIImage imageNamed:@"5.jpg"],[UIImage imageNamed:@"6.jpg"],[UIImage imageNamed:@"7.jpg"],[UIImage imageNamed:@"8.jpg"],[UIImage imageNamed:@"9.jpg"],[UIImage imageNamed:@"10.jpg"],[UIImage imageNamed:@"11.jpg"]];
    
    //    self.imgArray = @[[UIImage imageNamed:@"1.jpg"]];
    
    //加载imageView
    for (int i = 0; i<self.imgArray.count; i++) {
        ToBrowseImageView * imageView = [[ToBrowseImageView alloc] initWithFrame:CGRectMake(10+10*i+(Width-40)/3*i, 10, (Width-40)/3, (Width-40)/3)];
        imageView.image = self.imgArray[i];
        imageView.tag = 1000+i;
        imageView.delegate = self;
        [view addSubview:imageView];
    }
    
    //加载放大的视图
    self.browseView = [[BrowseView alloc] initWithFrame:self.view.bounds];
    self.browseView.imagesArray = self.imgArray;
    self.browseView.delegate = self;
    [self.view addSubview:self.browseView];
    
    
    
}


#pragma mark ----ToBrowseImageViewDelegate
- (void)tappedToBrowseImageViewAction:(id)sender
{
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    ToBrowseImageView *toBrowserView = sender;
    
    self.browseView.currentIndex = toBrowserView.tag - 1000;
    
    for (int i; i<self.imgArray.count; i++) {
        if (self.browseView.currentIndex == i) {
            [self.browseView browseViewAppear:(ToBrowseImageView*)[self.view viewWithTag:i+1000] imageArrayCount:self.browseView.imagesArray.count];
            self.browseView.pageControl.currentPage = i;
        }
    }
    
    [self.browseView browseViewAppear:toBrowserView imageArrayCount:self.browseView.imagesArray.count];
    
    
}

#pragma mark ---- browseView   Delegate
#pragma mark --- Disappear
- (void)browseViewDisappear:(id)sender
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark --- action
- (void)longPressActionWithImageView:(UIImageView *)imageView
{
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"保存" otherButtonTitles:nil, nil];
    
    [actionSheet showInView:self.view];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
