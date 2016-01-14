//
//  ViewController.m
//  loopScrollDemo
//
//  Created by qianzhan on 15/12/8.
//  Copyright © 2015年 qianzhan. All rights reserved.
//

#import "ViewController.h"
#import "YKLoopView.h"
#import "YKMarqueeView.h"

@interface ViewController ()<UIScrollViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    YKLoopView *loopView = [[YKLoopView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 150)];
    NSArray *arr = @[@"0.jpg", @"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg"];
    loopView.imageArr = arr;
    [self.view addSubview:loopView];
    
    
    YKMarqueeView *marqueeView = [[YKMarqueeView alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 30)];
    marqueeView.message = @"说到减肥啦大家是否了解阿萨德浪费";
    marqueeView.speed = 5;
    [self.view addSubview:marqueeView];
    [marqueeView start];
    
   UIScrollView *_scrollView = [[UIScrollView alloc] init];
    _scrollView.frame = CGRectMake(0, 350, 200, 100);
    _scrollView.delegate = self;
    _scrollView.backgroundColor = [UIColor blueColor];
    _scrollView.minimumZoomScale = 0.5;
    _scrollView.maximumZoomScale = 1.5;
    _scrollView.bouncesZoom = NO;
    [self.view addSubview:_scrollView];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, 200, 100);
    imageView.image = [UIImage imageNamed:@"2.jpg"];
    [_scrollView addSubview:imageView];
}

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return (UIImageView*)[scrollView.subviews firstObject];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
