//
//  main.m
//  Runtime原理
//
//  Created by ac-hu on 2018/9/22.
//  Copyright © 2018年 ac-hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

//c语言如果不实现只声明，会编译不通过。oc则不会，不一定会执行声明的函数
void run();

int main(int argc, char * argv[]) {
    @autoreleasepool {
        run;
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
