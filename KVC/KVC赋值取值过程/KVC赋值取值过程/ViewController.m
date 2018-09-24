//
//  ViewController.m
//  KVC赋值取值过程
//
//  Created by ac-hu on 2018/9/24.
//  Copyright © 2018年 ac-hu. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    赋值过程:
//    1.现在相关方法set<name>、_set<_name>、_setIs<_isName>、setIs<isName>顺序执行;
//    2.若没有相关方法则判断[Person accessInstanceVariablesDirectly]是否可以直接访问成员变量;
//    3.如果为NO，直接执行KVC的setValue: forUndefinedKey:
//    4.如果为YES，继续寻找相关变量<key>,_<key>,_<isKey>,<isKey>
//    5.方法或成员都不在，setValue: forUndefinedKey:默认抛异常；
    Person *p = [Person new];
    [p setValue:@"小明" forKey:@"name"];
    
    NSLog(@"name = %@",p->name);
    NSLog(@"_name = %@",p->_name);
    NSLog(@"_isName = %@",p->_isName);
    NSLog(@"isName = %@",p->isName);
    
    
//    取值过程：
//    1.先找相关方法get<key>,<key>;
//    2.若没有相关方法则判断[Person accessInstanceVariablesDirectly]是否可以直接访问成员变量;
//    3.如果为NO，直接执行KVC的valueForUndefinedKey:;
//    4.如果为YES，继续寻找相关变量<key>,_<key>,_<isKey>,<isKey>；
//    5.如果方法或成员都不存在valueForUndefinedKey:默认抛异常
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
