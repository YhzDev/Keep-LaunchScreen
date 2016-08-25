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
    
    //添加定时器
    [self addTimer];
}

#pragma mark  - scrollviewDelegate
//滚动就会触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat scrollW = self.bounds.size.width;
    int page = (scrollView.contentOffset.x + scrollW * 0.5) / scrollW;
    page --;
    self.pageControl.currentPage = page;
}

//开始拖拽视图
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

//完成拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}

//滚动动画停止时执行,代码改变时出发,也就是setContentOffset改变时
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollViewDidStop:scrollView];
}

//减速停止了时执行，手触摸时执行执行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidStop:scrollView];
}


- (void)scrollViewDidStop:(UIScrollView *)scrollView
{
    CGFloat scrollW = [UIScreen mainScreen].bounds.size.width;
    int page = (self.contentOffset.x + 0.5 * scrollW) / scrollW;
    if (page == 0){
        [self setContentOffset:CGPointMake(scrollW * self.titles.count, 0)];
    } else if (page == (self.titles.count + 1)) {
        [self setContentOffset:CGPointMake(scrollW , 0)];
    }
}

- (void)nextImage
{
    NSInteger page = 0;
    if (self.pageControl.currentPage == self.titles.count) {
        page = 0;
    } else {
        page = self.pageControl.currentPage + 1;
    }
    CGFloat offsetX = (page + 1) * self.bounds.size.width;
    CGPoint offset = CGPointMake(offsetX, 0);
    
    [self setContentOffset:offset animated:YES];
    
}

- (void)addTimer
{
    //Timer会被加入到当前线程的Run Loop中，且模式是默认的NSDefaultRunLoopMode。而如果当前线程就是主线程，比如UIScrollView的拖动操作，会将Run Loop切换成NSEventTrackingRunLoopMode模式，在这个过程中，默认的NSDefaultRunLoopMode模式中注册的事件是不会被执行的。也就是说，此时使用scheduledTimerWithTimeInterval添加到Run Loop中的Timer就不会执行。
    
    self.timer = [NSTimer timerWithTimeInterval:3.0f target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)dealloc
{
    [self removeTimer];
}


@end
