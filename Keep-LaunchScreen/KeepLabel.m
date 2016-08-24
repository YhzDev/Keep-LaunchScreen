//
//  KeepLabel.m
//  Keep-LaunchScreen
//
//  Created by wubang_dev on 16/8/24.
//  Copyright © 2016年 Yhz_Dev. All rights reserved.
//

#import "KeepLabel.h"

@implementation KeepLabel

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.font = [UIFont fontWithName:@"Helvetica" size:23.0];
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor whiteColor];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
