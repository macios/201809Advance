//
//  ViewController.m
//  Runtime原理
//
//  Created by ac-hu on 2018/9/22.
//  Copyright © 2018年 ac-hu. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Dog.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //正常写法
//    Person *p = [Person new];
//    [p walk];
    
    Person *p = [Person new];
    Method  m1 = class_getInstanceMethod([p class], @selector(walk));
    Method  m2 = class_getInstanceMethod([p class], @selector(run));
//    动态改变方法
    IMP imp = method_getImplementation(m2);
    method_setImplementation(m1, imp);
    [p walk];
//Method 实际是一个结构体
    
    Person *p1 = [Person new];
    Dog *d1 = [Dog new];
    //动态设置类，改变设置p1为Dog类
    object_setClass(p1, [d1 class]);
    [p1 walk];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
