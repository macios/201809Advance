//
//  ViewController.m
//  引用计数-进阶
//
//  Created by ac-hu on 2018/10/2.
//  Copyright © 2018年 sk-hu. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self TaggedPoint];
    [self isa];

}


- (void)TaggedPoint {
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

-(void)isa{
//    isa 早起版本是指针
//    现在为64位结构体，每一个位段存储着不同的值,每一位存值节省内存
//    会用最后19位存引用技术
//    struct{
//        
//    };
    
//    用Person类模拟指针结构体操作
    Person *p = [Person new];
    NSLog(@"%d %d",p.front,p.back);
    
    [p setFront:YES];
    [p setBack:NO];
    NSLog(@"%d %d",p.front,p.back);
    
//   retain+1 release-1 过程： 散列表地址作为key，对象值指针作为value，hash算法或者更好算法，字典实现原理和引用计数存储一个方式，相当于key、value的形式。还有位运算等，然后对其++或--
    
//    weak实现原理概括：
//    1.弱引用对象，底层也是使用了哈希存储，或者叫散列存储。对象的地址作为key，指向该对象的所有弱引用指针作为值；
//    2.释放时，就是以对象的内存地址作为key，去存储弱引用对象的哈希表里，找到所有的弱引用对象，然后设置为nil，最后移除这个弱引用的散列表；
}

@end
