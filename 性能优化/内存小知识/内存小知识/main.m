//
//  main.m
//  内存小知识
//
//  Created by ac-hu on 2018/10/2.
//  Copyright © 2018年 sk-hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

//3.BSS段
int g1;
static int s1;

//4.数据段
int g2 = 0;
static int s2;

int main(int argc, char * argv[]) {
    @autoreleasepool {
//        栈区、堆区、BSS段、数据段、代码段。地址从高到低
//        1.栈区和堆区是运行时分配的内存，其他区是编译时分配的；
//        2.栈区地址是连续的，并且由高到低；
//        3.堆区地址不是连续的，访问速度没有栈区快；
        
        
//        1.栈区dizhi
        int i = 10;
        int j = 10;
        NSObject *obj = [NSObject new];
//        栈区地址连续的从高到低，int类型 4个字节
        NSLog(@"%p",&i);
        NSLog(@"%p",&j);
//        指针类型占8个字节
        NSLog(@"%p",&obj);
        
//        2.堆区地址
        NSObject *obj1 = [NSObject new];
        NSObject *obj2 = [NSObject new];
        NSObject *obj3 = [NSObject new];
//        栈区地址比栈区小，不是连续的，手动分配，访问速度没有栈区快（会先去栈找堆的地址）
        NSLog(@"%p",obj1);
        NSLog(@"%p",obj2);
        NSLog(@"%p",obj3);
        
//        BSS段、数据段地址更低
//        3.BSS段
        NSLog(@"%p",&g1);
        NSLog(@"%p",&s1);
        
//        4.数据段
        NSLog(@"%p",&g2);
        NSLog(@"%p",&s2);
        
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
