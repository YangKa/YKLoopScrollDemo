//
//  LoopView.m
//  loopScrollDemo
//
//  Created by qianzhan on 15/12/8.
//  Copyright © 2015年 qianzhan. All rights reserved.
//

#import "YKLoopView.h"


@interface YKLoopView ()<UIScrollViewDelegate>{
    
}

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *scrollArr;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation YKLoopView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)setImageArr:(NSArray *)imageArr{
    _imageArr = imageArr;
    if (!_imageArr || _imageArr.count == 0) {
        return;
    }

    _scrollArr = [NSMutableArray array];
    [_scrollArr addObject:imageArr[imageArr.count-1]];
    [_scrollArr addObjectsFromArray:imageArr];
    [_scrollArr addObject:imageArr[0]];
    
    [self initScrollView];
    [self initPageControl];
   // [self initTimer];
}

- (void)initScrollView{
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.frame = CGRectMake(0, 0, width, height);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(width*_scrollArr.count, 0);
    _scrollView.backgroundColor = [UIColor redColor];


    [self addSubview:_scrollView];
    

    for (int i = 0; i < _scrollArr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(width*i, 0, width, height);
        imageView.image = [UIImage imageNamed:_scrollArr[i]];
        [_scrollView addSubview:imageView];
    }

    _scrollView.contentOffset = CGPointMake(width, 0);
    
}

- (void)initPageControl{
    
    CGFloat width = self.frame.size.width;
    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.frame = CGRectMake(width/2-50, self.frame.size.height-20, 100, 20);
    _pageControl.numberOfPages = _imageArr.count;
    _pageControl.currentPage = 0;
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [self addSubview:_pageControl];
}

- (void)initTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(scrollToNextPage) userInfo:nil repeats:YES];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)scrollToNextPage{
    CGFloat width = self.scrollView.frame.size.width;
    NSInteger index = (_scrollView.contentOffset.x+width/2)/width;
    
    if (index == _scrollArr.count-1) {
        index = 1;
    }
    if (index == 0) {
        index = _imageArr.count;
    }
    [_scrollView setContentOffset:CGPointMake(width*(index+1), 0) animated:YES];
}

#pragma mark -------------UIScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat width = self.scrollView.frame.size.width;
    NSInteger index = (scrollView.contentOffset.x+width/2)/width;
    
    NSInteger page;
    if (index == _scrollArr.count-1) {
        page = 1;
    }else if (index == 0) {
        page = _imageArr.count-1;
    }else{
        page = index-1;
    }
    
    _pageControl.currentPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_timer invalidate];
    _timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self initTimer];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollViewDidEndDecelerating:scrollView];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat width = self.scrollView.frame.size.width;
    int index = (scrollView.contentOffset.x+width/2)/width;
    
    if (index == (_scrollArr.count-1)) {
        [self.scrollView setContentOffset:CGPointMake(width, 0) animated:NO];
    } else if (index == 0) {
        [self.scrollView setContentOffset:CGPointMake(_imageArr.count * width, 0) animated:NO];
    }
}



@end
