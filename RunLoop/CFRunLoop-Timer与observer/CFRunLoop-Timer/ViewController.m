//
//  ViewController.m
//  CFRunLoop-Timer
//
//  Created by ac-hu on 2018/9/23.
//  Copyright © 2018年 ac-hu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,assign)CFRunLoopTimerRef timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self testTimer];
    [self testObserver];
}


- (void)testTimer {
    _timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, 0, 1, 0, 0, ^(CFRunLoopTimerRef timer) {
        NSLog(@"timer在运行");
    });
    CFRunLoopAddTimer(CFRunLoopGetCurrent(), _timer, kCFRunLoopCommonModes);
}

#pragma mark - 监听RenLoop的状态

//1UL << 0位移 2的0次 1UL << 5 2的五次
//typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
//    kCFRunLoopEntry = (1UL << 0),//即将进入runloop
//    kCFRunLoopBeforeTimers = (1UL << 1),即将处理timer时间
//    kCFRunLoopBeforeSources = (1UL << 2),即将处理source事件
//    kCFRunLoopBeforeWaiting = (1UL << 5),即将进入睡眠
//    kCFRunLoopAfterWaiting = (1UL << 6),runloop被唤醒
//    kCFRunLoopExit = (1UL << 7),runloop退出
//    kCFRunLoopAllActivities = 0x0FFFFFFFU所有状态
//};
-(void)testObserver{
    CFRunLoopObserverRef obser = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"%lu",activity);
    });
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), obser, kCFRunLoopCommonModes);
}

-(void)dealloc{
//    CFRunLoop
}

@end
