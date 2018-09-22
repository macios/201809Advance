//
//  ViewController.m
//  Runtime属性API使用-自动归解档
//
//  Created by ac-hu on 2018/9/22.
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
    p.name = @"aaa";
    p.age = 10;

//    归档
    NSString *path = [NSString stringWithFormat:@"%@/archiver.plist",NSHomeDirectory()];
    [NSKeyedArchiver archiveRootObject:p toFile:path];
    
//    接档
    Person *p1 = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"name = %@   age = %d",p1.name,p1.age);
}


@end
