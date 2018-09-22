//
//  UIView+HookViewSwizzing.m
//  runTime
//
//  Created by ac hu on 2018/6/17.
//  Copyright © 2018年 ac hu. All rights reserved.
//

#import "UIView+HookViewSwizzing.h"
#import <objc/runtime.h>

@implementation UIView (HookViewSwizzing)

//+(void)load{
//    static dispatch_once_t oneceToken;
//    dispatch_once(&oneceToken,^{
//        Method methodSys = class_getInstanceMethod([self class], @selector(setBackgroundColor:));
//        Method methodMy = class_getInstanceMethod([self class], @selector(hu_setBackgroundColor:));
//        method_exchangeImplementations(methodSys, methodMy);
//    });
//}
//
//-(void)hu_setBackgroundColor:(UIColor *)color{
//    if (color == [UIColor blackColor]) {
////        [self hu_setBackgroundColor:[UIColor redColor]];
//        NSLog(@"方法被交换");
//    }
//}
@end
