//
//  YKMarqueeView.h
//  loopScrollDemo
//
//  Created by qianzhan on 15/12/8.
//  Copyright © 2015年 qianzhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKMarqueeView : UIView
@property (nonatomic, strong) NSString *message;
@property (nonatomic, assign) CGFloat speed;
- (void)start;
- (void)stop;

@end
