
# Keep-LaunchScreen
##这是一个模仿keep的启动动画，看了别人写的,自己重写了一遍.

效果图如下：

![效果图](https://github.com/yu137988395/Keep-LaunchScreen/blob/master/keep.gif)


##如何使用
###1.导入头文件
```objc
#import "KeepView.h"
#import "KeepScrollView.h"
#import "KeepLabel.h"
```
###2.在控制器里面设置
(1).实例化一个moviePlay
```objc
    //工程里读取MP4
    NSString *moviePath = [[NSBundle mainBundle] pathForResource:@"keep" ofType:@"mp4"];
    
    self.moviePlayCtl.contentURL = [[NSURL alloc] initFileURLWithPath:moviePath];
    [self.moviePlayCtl play];

```

(2).设置播放状态和通知
```objc
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
```

###v0.0.1
  
  * 首次提交：实现动画

## 不足之处，还请指正。     邮箱:YhzDev@gmail.com

##License
This project is under MIT License. See LICENSE file for more information.
