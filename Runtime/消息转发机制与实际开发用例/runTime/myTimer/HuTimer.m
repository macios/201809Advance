//
//  HuTimer.m
//  runTime
//
//  Created by ac hu on 2018/6/18.
//  Copyright © 2018年 ac hu. All rights reserved.
//

#import "HuTimer.h"
#import "HuWeekProxy.h"

@interface HuTimer ()

@property (strong, nonatomic) NSTimer *timer;

@end

@implementation HuTimer
- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}

- (instancetype)initWithFireDate:(NSDate *)date interval:(NSTimeInterval)ti target:(id)t selector:(SEL)s userInfo:(id)ui repeats:(BOOL)rep runloopMode:(NSRunLoopMode)mode {
    if (self = [super init]) {
        HuWeekProxy *weakProxy = [HuWeekProxy weakWithTarget:t];
        
        _timer = [[NSTimer alloc] initWithFireDate:date interval:ti target:weakProxy selector:s userInfo:ui repeats:rep];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:mode];
    }
    
    return self;
}

+ (instancetype)timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo runloopMode:(NSRunLoopMode)mode {
    HuTimer *timer = [[HuTimer alloc] initWithFireDate:[NSDate distantFuture] interval:ti target:aTarget selector:aSelector userInfo:userInfo repeats:yesOrNo runloopMode:mode];
    return timer;
}
+ (instancetype)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo runloopMode:(NSRunLoopMode)mode {
    HuTimer *timer = [[HuTimer alloc] initWithFireDate:[NSDate distantPast] interval:ti target:aTarget selector:aSelector userInfo:userInfo repeats:yesOrNo runloopMode:mode];
    return timer;
    
}

- (void)fire {
    [self.timer setFireDate:[NSDate distantPast]];
}
- (NSDate *)fireDate {
    return self.timer.fireDate;
}
- (void)setFireDate:(NSDate *)date {
    [self.timer setFireDate:date];
}
- (NSTimeInterval)timeInterval {
    return self.timer.timeInterval;
}
- (void)invalidate {
    [self.timer invalidate];
    self.timer = nil;
}

@end
