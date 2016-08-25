//
//  ViewController.m
//  Keep-LaunchScreen
//
//  Created by wubang_dev on 16/8/20.
//  Copyright © 2016年 Yhz_Dev. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "KeepView.h"

@interface ViewController ()

@property (nonatomic,strong)MPMoviePlayerController *moviePlayCtl;
@property (nonatomic,strong)KeepView *keepView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //工程里读取MP4
    NSString *moviePath = [[NSBundle mainBundle] pathForResource:@"keep" ofType:@"mp4"];
    
    self.moviePlayCtl.contentURL = [[NSURL alloc] initFileURLWithPath:moviePath];
    [self.moviePlayCtl play];
    
    [self.moviePlayCtl.view bringSubviewToFront:self.keepView];
}

- (KeepView *)keepView{
    
    if (!_keepView) {
        _keepView = [[KeepView alloc] init];
        _keepView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        [self.moviePlayCtl.view addSubview:_keepView];
    }
    return _keepView;
}

#pragma mark - moviePlay通知
- (void)playbackStateChange{
    
    //获取当前播放器的播放状态
    MPMoviePlaybackState playbackState = [self.moviePlayCtl playbackState];
    
    if (playbackState == MPMoviePlaybackStateStopped || playbackState == MPMoviePlaybackStatePaused) {
        [self.moviePlayCtl play];
    }
}

#pragma mark - 初始化movieCtl
- (MPMoviePlayerController *)moviePlayCtl{
    
    if (!_moviePlayCtl) {
        
        _moviePlayCtl = [[MPMoviePlayerController alloc] init];
        
        //自动播放
        [_moviePlayCtl setShouldAutoplay:YES];
        //设置播放文件的类型
        _moviePlayCtl.movieSourceType = MPMovieSourceTypeFile;
        _moviePlayCtl.fullscreen = YES;
        
        //是否循环播放
        _moviePlayCtl.repeatMode = MPMovieRepeatModeOne;
        //设置没有播放控件
        _moviePlayCtl.controlStyle = MPMovieControlStyleNone;
        
        _moviePlayCtl.view.frame = [UIScreen mainScreen].bounds;
        
        [self.view addSubview:_moviePlayCtl.view];
        
        //视频开播的监听
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackStateChange) name:MPMoviePlayerNowPlayingMovieDidChangeNotification object:nil];
        
    }
    
    return _moviePlayCtl;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
