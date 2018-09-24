//
//  ViewController.m
//  KVC集合代理对象
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
    Person *p = [Person new];
    //一对多的关系，设置一个key值，映射多个方法
    p.count = 5;
    NSArray *arr= [p valueForKey:@"books"];
    NSLog(@"Books = %@",arr);
    
    p.penArr = @[@"pen0",@"pen1"];
    NSSet *set = [p valueForKey:@"pens"];
    NSLog(@"Pens = %@",set);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
