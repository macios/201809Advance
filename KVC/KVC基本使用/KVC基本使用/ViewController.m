//
//  ViewController.m
//  KVC基本使用
//
//  Created by ac-hu on 2018/9/24.
//  Copyright © 2018年 ac-hu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    KVC  NSKeyValueCoding 键值编码
    // set get方法，可以访问私有成员forKeyPath可以设置属性的属性，其底层最终还是以forKey实现的
//    [self setValue:<#(nullable id)#> forKey:<#(nonnull NSString *)#>]
//    [self setValue:textFiled forKeyPath:@"_placeholderLabel.textColor"]
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
