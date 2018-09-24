//
//  ViewController.m
//  KVC异常处理与正确性验证
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
//    1.赋值不存在；
//    2.key为空；
//    3.实际开发中为了捕获异常和让程序健壮，可以重写，重写是打印相关信息
    
    Person *p = [Person new];
//    重写setNilValueForKey:就不会崩了!!!!运行结果不走这个方法，苹果更新了这个问题？
    [p setValue:@"aaa" forKey:@"name"];
    NSLog(@"%@",p.name);

//    重写setValue: forUndefinedKey: 就不会崩了
    [p setValue:@"aa" forUndefinedKey:@"kkk"];
    
//    重写valueForUndefinedKey:就不会崩了
    [p valueForKey:@"hhhh"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
