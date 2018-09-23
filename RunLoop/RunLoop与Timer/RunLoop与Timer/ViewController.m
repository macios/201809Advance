//
//  ViewController.m
//  RunLoop与Timer
//
//  Created by ac-hu on 2018/9/23.
//  Copyright © 2018年 ac-hu. All rights reserved.
//

#import "ViewController.h"
#import "MyThread.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //线程默认没有开启RunLoop
    MyThread *thread = [[MyThread alloc]initWithBlock:^{
        [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"timer在运行");
            
            [NSThread exit];//停止当前线程
        }];
        //timer已经加到RunLoop里面了，只是没有开启，所以不会执行timer，需要手动开启RunLoop
        [[NSRunLoop currentRunLoop] run];//这样线程就不会死了，线程保护
        NSLog(@"这是一个打印");
    }];
    [thread start];

    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
