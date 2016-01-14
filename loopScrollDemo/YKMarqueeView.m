//
//  YKMarqueeView.m
//  loopScrollDemo
//
//  Created by qianzhan on 15/12/8.
//  Copyright © 2015年 qianzhan. All rights reserved.
//

#import "YKMarqueeView.h"


@interface YKMarqueeView (){
    UILabel *label;
    CGFloat durationTime;
}

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation YKMarqueeView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _speed = 5;
    }
    return self;
}

- (void)initScrollView{
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.frame = CGRectMake(0, 0, width, height);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.backgroundColor = [UIColor orangeColor];
    _scrollView.scrollEnabled = NO;
    [self addSubview:_scrollView];
}

- (void)setMessage:(NSString *)message{
    _message = message;
    
    if (message && message.length>0) {
        [self initScrollView];
        
        label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:15];
        label.text = _message;
        label.textColor = [UIColor whiteColor];
        [_scrollView addSubview:label];
        
        CGFloat width = [_message boundingRectWithSize:CGSizeMake(1000, 30) options:0 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.width;
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width*2+width, 0);
        label.frame = CGRectMake(self.scrollView.frame.size.width, 0, width, self.scrollView.frame.size.height);
        
    }
}

- (void)setSpeed:(CGFloat)speed{
    _speed = speed;
    
}

- (void)start{
    durationTime = ((label.frame.size.width+label.frame.size.width)/_speed )*0.1;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:durationTime target:self selector:@selector(startAnimation) userInfo:nil repeats:YES];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:_timer forMode:NSRunLoopCommonModes];
    [_timer fire];
    
}

- (void)stop{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)startAnimation{
    
    CGPoint fromPoint = CGPointMake(_scrollView.frame.size.width+label.frame.size.width/2, label.frame.size.height/2);
    //路径曲线
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPoint];
    [movePath addLineToPoint:CGPointMake(-label.frame.size.width/2, label.frame.size.height/2)];
    
    //关键帧
    CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnim.path = movePath.CGPath;
    moveAnim.removedOnCompletion = YES;
    moveAnim.duration = durationTime;
    [moveAnim setDelegate:self];
    [label.layer addAnimation:moveAnim forKey:nil];
}
@end
