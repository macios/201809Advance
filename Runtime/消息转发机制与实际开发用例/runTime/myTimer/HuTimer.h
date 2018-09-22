//
//  HuTimer.h
//  runTime
//
//  Created by ac hu on 2018/6/18.
//  Copyright © 2018年 ac hu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HuTimer : NSObject

@property(nonatomic,copy)NSDate *fireDate;
@property(nonatomic,readonly,assign) NSTimeInterval timeInterval;

- (instancetype)initWithFireDate:(NSDate *)date interval:(NSTimeInterval)ti target:(id)t selector:(SEL)s userInfo:(id)ui repeats:(BOOL)rep runloopMode:(NSRunLoopMode)mode;

+ (instancetype)timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo runloopMode:(NSRunLoopMode)mode;
+ (instancetype)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo runloopMode:(NSRunLoopMode)mode;

- (void)fire;
- (void)invalidate;

@end
