//
//  ViewController.m
//  RunLoop源source操作
//
//  Created by ac-hu on 2018/9/23.
//  Copyright © 2018年 ac-hu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSPortDelegate>
@property(nonatomic,strong)NSPort *mainPort;
@property(nonatomic,strong)NSPort *subPort;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    自定义source0，只能自定义source0的源,source1不行
//    触摸事件、自定义输入源、performSelector:onThread:
//    [self source0Test];
    
//    使用source1端口port线程间通讯
    [self source1Test];
}

#pragma mark - 自定义source0，只能自定义source0的源,source1不行
- (void)source0Test {
    //    CFIndex    version;
    //    void *    info;
    //    const void *(*retain)(const void *info);
    //    void    (*release)(const void *info);
    //    CFStringRef    (*copyDescription)(const void *info);
    //    Boolean    (*equal)(const void *info1, const void *info2);
    //    CFHashCode    (*hash)(const void *info);
    //    void    (*schedule)(void *info, CFRunLoopRef rl, CFRunLoopMode mode);
    //    void    (*cancel)(void *info, CFRunLoopRef rl, CFRunLoopMode mode);
    //    void    (*perform)(void *info);
    CFRunLoopSourceContext context = {
        0,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        schedule,
        cancel,
        perform
    };
    
    //    只能自定义source0的源
    CFRunLoopSourceRef source0 = CFRunLoopSourceCreate(CFAllocatorGetDefault(), 0, &context);
    
    CFRunLoopAddSource(CFRunLoopGetCurrent(), source0, kCFRunLoopDefaultMode);//触发schedule
    CFRunLoopSourceSignal(source0);//触发perform
    CFRunLoopWakeUp(CFRunLoopGetCurrent());//CFRunLoopGetCurrent当前RunLoop已经醒着的，其实不用这句话呢
    CFRunLoopRemoveSource(CFRunLoopGetCurrent(), source0, kCFRunLoopDefaultMode);//移除时触发cancel
    CFRelease(source0);//CF类注意销毁
}

void schedule(void *info, CFRunLoopRef rl, CFRunLoopMode mode){
    NSLog(@"%s",__func__);
}
void cancel(void *info, CFRunLoopRef rl, CFRunLoopMode mode){
    NSLog(@"%s",__func__);
}

void perform(void *info){
    NSLog(@"%s",__func__);
}

#pragma mark - 使用source1:端口port线程间通讯
- (void)source1Test {
//    NSPort线程间通信类，需要基于NSRunLoop,添加到NSRunLoop；
//    他有三个子类。NSMachPort、NSMessagePort只支持本地通信，NSSocketPort支持本地与远程通信（多耗费些资源）；
//    结束时必须移除释放，不然和timer类似可能会有内存泄漏
    _mainPort = [NSPort port];
    _mainPort.delegate = self;
    [[NSRunLoop mainRunLoop] addPort:_mainPort forMode:NSDefaultRunLoopMode];
    [NSThread mainThread].name = @"主线程";
    
    NSThread *thread = [[NSThread alloc]initWithBlock:^{
        self.subPort = [NSPort port];
        self.subPort.delegate = self;
        [[NSRunLoop currentRunLoop] addPort:self.subPort forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    }];
    thread.name = @"子线程";
    [thread start];
}


-(void)handlePortMessage:(id)message{
    NSMutableArray *dataArr = [message valueForKey:@"components"];
    NSString *comStr;
    if (dataArr.count) {
        comStr = [[NSString alloc]initWithData:dataArr.firstObject encoding:NSUTF8StringEncoding];
    }
    NSLog(@"%@ %@",[NSThread currentThread].name,comStr);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //主线程给子线程发送消息
    NSMutableArray *com = @[].mutableCopy;
    NSData *data = [@"主线程给子线程发送消息" dataUsingEncoding:NSUTF8StringEncoding];
    [com addObject:data];
    [self.subPort sendBeforeDate:[NSDate date] components:com from:self.mainPort reserved:0];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //子线程给主线程发送消息
    NSMutableArray *com = @[].mutableCopy;
    NSData *data = [@"子线程给主线程发送消息" dataUsingEncoding:NSUTF8StringEncoding];
    [com addObject:data];
    [self.mainPort sendBeforeDate:[NSDate date] components:com from:self.subPort reserved:0];
}

-(void)dealloc{
    [_subPort invalidate];
    [_mainPort invalidate];
    _subPort = nil;
    _mainPort = nil;
}
@end


