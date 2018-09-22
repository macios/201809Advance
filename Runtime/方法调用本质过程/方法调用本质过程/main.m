//
//  main.m
//  方法调用本质过程
//
//  Created by ac-hu on 2018/9/22.
//  Copyright © 2018年 ac-hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Dog.h"
#import <objc/message.h>


//本质：消息接受者 消息名称 （或有参数）
int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        Person *p = [Person new];
//        [p walk];
        //借用clang编译器，用命令工具
//        1.cd 进入文件夹
//        2.ls
//        3.clang -rewrite-objc main.m
//        4.ls 查看 编译完成后会生成一个main.cpp 文件（c++）；
//        5.open main.cpp (main.cpp拷贝到了工程中)
//        6.会看到转换成下面两个方法了
//        Person *p = ((Person *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("Person"), sel_registerName("new"));
//        ((void (*)(id, SEL))(void *)objc_msgSend)((id)p, sel_registerName("walk"));
//        [p walk];
        
//        msg buildsetting 关掉严格审查
        Person *p = [Person new];
//        ((Person *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("Person"), sel_registerName("new"));
        objc_msgSend(p, sel_registerName("walk"));
//        @selector(walk) == sel_registerName("walk")
        
//        类方法也是这样调用
//      [Person run] ==  objc_msgSend(objc_getClass("Person"), @selector(run));
    }
    return 0;
}
