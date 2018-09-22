//
//  ViewController.m
//  动态创建类
//
//  Created by ac-hu on 2018/9/22.
//  Copyright © 2018年 ac-hu. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test];
}

void hunt(id self,SEL _cmd){
    NSLog(@"%s",__func__);
}

- (void)test {
//    类队
    Class Person = objc_allocateClassPair([NSObject class], "Person", 0);
//    添加实例变量
    NSString *name = @"name";
    class_addIvar(Person, name.UTF8String, sizeof(id), log2(sizeof(id)), @encode(id));
//    添加方法
    class_addMethod(Person, @selector(hunt), (IMP)hunt, "v@:");
    //注册类：需要先添加变量后再注册(不然会崩)，因为注册后类就变成只读了class_ro_t(readOnly)，不能被修改了
    objc_registerClassPair(Person);
    
    id p = [Person new];
    //设置
    [p setValue:@"小明" forKey:@"name"];
    NSLog(@"%@",[p valueForKey:@"name"]);

//    方法调用
    [p performSelector:@selector(hunt)];
}


@end
