//
//  UIViewController+Hook.m
//  动态交换拦截
//
//  Created by ac-hu on 2018/9/22.
//  Copyright © 2018年 ac-hu. All rights reserved.
//

#import "UIViewController+Hook.h"
#import <objc/runtime.h>

@implementation UIViewController (Hook)
+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method m1 = class_getInstanceMethod(self, @selector(viewWillAppear:));
        Method m2 = class_getInstanceMethod(self, @selector(hu_viewWillAppear:));
        method_exchangeImplementations(m1, m2);
    });
}

-(void)hu_viewWillAppear:(BOOL)animated{
    NSLog(@"%s",__func__);
    [self hu_viewWillAppear:animated];
}
@end
