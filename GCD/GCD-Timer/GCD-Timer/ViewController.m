//
//  ViewController.m
//  GCD-Timer
//
//  Created by ac-hu on 2018/9/24.
//  Copyright © 2018年 ac-hu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong)dispatch_source_t timer;
@end

@implementation ViewController

//1.NSTimer不准时的原因：（1）.RunLoop循环处理时间，每次循环是固定时间，只有在这段时间才会去查看NSTimer；（2）.RunLoop模式会有影响，设置模式（这个不是不准时的原因，只是影响）；
//
//2.GCD-Timer准时原因：源不一样dispatch_source_t
//
//区别：一个是RunLoop的源，一个是dispatch源；GCD不需要加入mode下，不受模式印象；GCDTimer需要写全局延长生命周期，因为RunLoop会把它释放；如果GCDTimer写在主线程也会受RunLoop影响<看堆栈就可以了>，子线程不会;

- (void)viewDidLoad {
    [super viewDidLoad];
    //如果直接写不会执行，需要写全局延长生命周期，因为RunLoop会把它释放
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(_timer, ^{
        NSLog(@"timer在运行");
    });
    //启动-默认是关闭的
    dispatch_resume(_timer);
}

-(void) pauseTimer{
    if(_timer){
        dispatch_suspend(_timer);
    }
}
-(void) resumeTimer{
    if(_timer){
        dispatch_resume(_timer);
    }
}
-(void) stopTimer{
    if(_timer){
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

@end
