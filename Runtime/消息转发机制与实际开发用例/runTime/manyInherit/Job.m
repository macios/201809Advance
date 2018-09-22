//
//  Job.m
//  runTime
//
//  Created by ac hu on 2018/6/17.
//  Copyright © 2018年 ac hu. All rights reserved.
//

#import "Job.h"
#import <objc/runtime.h>

@interface Job()
{
    NSMutableDictionary *_muDic;
}

@end

@implementation Job

-(instancetype)init{
    if (self = [super init]) {
        _muDic = [NSMutableDictionary dictionary];
        [self registerMethodWithClass:[JobOne new]];
        [self registerMethodWithClass:[JobTwo new]];
        
    }
    return self;
}

-(void)registerMethodWithClass:(id)cla{
    unsigned count = 0;
    Method *methodList = class_copyMethodList([cla class], &count);
    for (int i = 0; i < count; i++) {
        Method method = methodList[i];
        SEL methodName = method_getName(method);
        [_muDic setObject:cla forKey:NSStringFromSelector(methodName)];
    }
    free(methodList);
}

-(NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    NSString *methodName = NSStringFromSelector(sel);
    id class = [_muDic valueForKey:methodName];
    if (class && [class respondsToSelector:sel]) {
        return [class methodSignatureForSelector:sel];
    }
    return [super methodSignatureForSelector:sel];
}

-(void)forwardInvocation:(NSInvocation *)anInvocation{
    SEL sel = [anInvocation selector];
    NSString *methodName = NSStringFromSelector(sel);
    id class = [_muDic valueForKey:methodName];
    if (class) {
        [anInvocation invokeWithTarget:class];
    }else{
        [super forwardInvocation:anInvocation];
    }
}

@end
