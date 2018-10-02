//
//  ViewController.m
//  引用计数-进阶
//
//  Created by ac-hu on 2018/10/2.
//  Copyright © 2018年 sk-hu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    Tagged Point（标签价data）
//    1.专门用来存储小的对象，例如NSNumber和NSDate；
//    2.Tagged Point指针的值不再是地址，而是真正的值。所以，实际上他不再是一个对象了，它只是一个披着对象皮的普通变量而已！因此，它的内存并不存储在堆中，也不需要malloc和free；
//    3.内存读取很快；
    
//    NSNumber小对象 是Tagged Point类型
    for (int i = 0 ; i < 5; i ++) {
        NSNumber *num = @(i);
        NSLog(@"小对象：%p",num);
    }
    
//    大对象 地址会变
    for (int i = 0 ; i < 5; i ++) {
        NSNumber *num = @(i*0xFFFFFFFFFFFFFFF);
        NSLog(@"大对象%p",num);
    }
//    对象的存取：底层会先判断是否为小对象Tagged Point。位操作判断
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
