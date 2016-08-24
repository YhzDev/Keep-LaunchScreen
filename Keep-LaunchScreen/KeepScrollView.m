//
//  KeepScrollView.m
//  Keep-LaunchScreen
//
//  Created by wubang_dev on 16/8/23.
//  Copyright © 2016年 Yhz_Dev. All rights reserved.
//

#import "KeepScrollView.h"
#import "KeepLabel.h"

@interface KeepScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation KeepScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        
        self.delegate = self;
        self.scrollsToTop = NO;
    }
    return self;
}

- (void)setTitles:(NSArray *)titles{
    
    _titles = titles;
    self.pageControl.numberOfPages = self.titles.count;
    [self setbanner];
}

- (void)setbanner
{
    //所有的父视图都调用removeFromSuperview方法
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat W = [UIScreen mainScreen].bounds.size.width;
    CGFloat H = 30;
    CGFloat Y = self.bounds.size.height - H;
    
    KeepLabel *lastLabel = [[KeepLabel alloc] init];
    
    KeepLabel *firstLabel = [[KeepLabel alloc] init];
    
    for (NSInteger i = 0; i < self.titles.count; i ++) {
        
        KeepLabel *label = [[KeepLabel alloc] init];
        
        CGFloat X = i * W + W ;
        label.frame = CGRectMake(X, Y, W, H);
        label.text = self.titles[i];
        
        if (i == 0) {
            lastLabel.text = self.titles[i];
        }
        if (i == self.titles.count - 1) {
            lastLabel.text = self.titles[i];
        }
        
        [self addSubview:label];
    }
    
    lastLabel.frame = CGRectMake(0, Y, W, H);
    [self addSubview:lastLabel];
    firstLabel.frame = CGRectMake((self.titles.count + 1) * W, Y, W, H);
    [self addSubview:firstLabel];
    
    self.contentSize = CGSizeMake((self.titles.count + 2) * W, 0);
    
    self.showsHorizontalScrollIndicator = NO;
    
    self.pagingEnabled = YES;
    
    self.pageControl.currentPage = 0;
    
    [self setContentOffset:CGPointMake(W, 0)];
    
}

#pragma mark  - scrollviewDelegate
//滚动就会触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat scrollW = self.bounds.size.width;
    int page = (scrollView.contentOffset.x + scrollW * 0.5) / scrollW;
    page --;
    self.pageControl.currentPage = page;
}


@end
