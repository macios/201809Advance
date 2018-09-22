//
//  HuWeekProxy.m
//  runTime
//
//  Created by ac hu on 2018/6/18.
//  Copyright © 2018年 ac hu. All rights reserved.
//

#import "HuWeekProxy.h"

@interface HuWeekProxy()

@end

@implementation HuWeekProxy

+(instancetype)weakWithTarget:(id)target{
    HuWeekProxy *pro = [[self alloc]initWeakTarget:target];
    return pro;
}

-(instancetype)initWeakTarget:(id)target{
    self = [HuWeekProxy alloc];
    self.target = target;
    return self;
}

-(id)forwardingTargetForSelector:(SEL)aSelector{
    return self.target;
}

-(NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}

-(void)forwardInvocation:(NSInvocation *)invocation{
    void *nullValue = NULL;
    [invocation setReturnValue:&nullValue];
}

@end
