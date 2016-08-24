//
//  KeepView.m
//  Keep-LaunchScreen
//
//  Created by wubang_dev on 16/8/23.
//  Copyright © 2016年 Yhz_Dev. All rights reserved.
//

#import "KeepView.h"
#import "KeepScrollView.h"

@interface KeepView ()

@property (nonatomic,strong)UIImageView *myImageView;
@property (nonatomic,strong)KeepScrollView *keepScrollView;
@property (nonatomic,strong)UIPageControl *keepPageCtl;
@property (nonatomic,strong)UIButton *loginButton;
@property (nonatomic,strong)UIButton *registerButton;

@end

@implementation KeepView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.myImageView];
        [self addSubview:self.keepScrollView];
        [self addSubview:_keepPageCtl];
        [self addSubview:self.loginButton];
        [self addSubview:self.registerButton];
        
        self.keepScrollView.titles = @[@"全程记录你的健身数据",@"规范你的训练过程",@"陪伴你迈出跑步的第一步",@"分享汗水后你的性感"];
        
        self.keepPageCtl.numberOfPages = self.keepScrollView.titles.count;
    }
    return self;
}

//注册和登陆
- (void)registerClick
{
    
}

- (void)login
{
    
}

#pragma mark - 懒加载
- (UIImageView *)myImageView{
    
    if (!_myImageView) {
        UIImage *image = [UIImage imageNamed:@"keep"];
        _myImageView = [[UIImageView alloc] initWithImage:image];
        CGFloat X = ([UIScreen mainScreen].bounds.size.width - image.size.width) * 0.5;
        CGFloat Y = [UIScreen mainScreen].bounds.size.height * 0.25;
        _myImageView.frame = CGRectMake(X, Y, image.size.width, image.size.height);
        [self addSubview:_myImageView];
    }
    return _myImageView;
}
- (UIButton *)registerButton
{
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat margin = 20;
        CGFloat X = margin;
        CGFloat H = 50;
        CGFloat W = ([UIScreen mainScreen].bounds.size.width - 3 * margin) * 0.5;
        CGFloat Y = [UIScreen mainScreen].bounds.size.height - H - 15;
        _registerButton.frame = CGRectMake(X, Y, W, H);
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton setBackgroundColor:[UIColor blackColor]];
        _registerButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_registerButton addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
        _registerButton.layer.cornerRadius = 3.0f;
        _registerButton.alpha = 0.4f;
    }
    return _registerButton;
}

- (UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat margin = 20;
        CGFloat X = CGRectGetMaxX(self.registerButton.frame) + margin;
        CGFloat H = 50;
        CGFloat W = ([UIScreen mainScreen].bounds.size.width - 3 * margin) * 0.5;
        CGFloat Y = [UIScreen mainScreen].bounds.size.height - H - 15;
        _loginButton.frame = CGRectMake(X, Y, W, H);
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_loginButton setBackgroundColor:[UIColor whiteColor]];
        [_loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:18];
        _loginButton.layer.cornerRadius = 3.0f;
        _loginButton.alpha = 0.4f;
    }
    return _loginButton;
}

- (KeepScrollView *)keepScrollView{
    
    if (!_keepScrollView) {
        _keepScrollView = [[KeepScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 105)];
        _keepScrollView.pageControl = self.keepPageCtl;
    }
    return _keepScrollView;
}
- (UIPageControl *)keepPageCtl{
    if (!_keepPageCtl) {
        _keepPageCtl = [[UIPageControl alloc] init];
        CGFloat W = self.keepScrollView.titles.count * 5;
        _keepPageCtl.frame = CGRectMake(0, CGRectGetMaxY(self.keepScrollView.frame) + 10, W, 10);
        _keepPageCtl.currentPage = 0;
        [self addSubview:_keepPageCtl];
    }
    return _keepPageCtl;
}

@end
