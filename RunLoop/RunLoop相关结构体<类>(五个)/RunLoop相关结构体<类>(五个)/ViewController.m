//
//  ViewController.m
//  RunLoop相关结构体<类>(五个)
//
//  Created by ac-hu on 2018/9/23.
//  Copyright © 2018年 ac-hu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    1.CFRunLoopRef;__CFRunLoop结构体
//    2.CFRunLoopModeRef;
//    3.CFRunLoopSourceRef;
//    4.CFRunLoopTimerRef;
//    5.CFRunLoopObserverRef;
    
//    一个RunLoop管理者 管理多个mode，一个mode下有多个<set>source、<arr>observe、<arr>timer；
    
    CFRunLoopRef r1 = CFRunLoopGetCurrent();
    CFRunLoopMode mode = CFRunLoopCopyCurrentMode(r1);
    NSLog(@"mode = %@",mode);
    
    CFArrayRef arr = CFRunLoopCopyAllModes(r1);
    NSLog(@"AllModes = %@",arr);
//    UITrackingRunLoopMode,//界面滑动模式。
//    GSEventReceiveRunLoopMode,//接收系统事件、用不上
//    kCFRunLoopDefaultMode,//默认模式
//    kCFRunLoopCommonModes//共用模式：前面的所有模式
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
