//
//  ViewController.m
//  自定义转场动画
//
//  Created by ac-hu on 2018/9/15.
//  Copyright © 2018年 ac-hu. All rights reserved.
//

#import "ViewController.h"
#import "TwoVC.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (IBAction)nextVCClick:(id)sender {
    [self.navigationController pushViewController:[TwoVC new] animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
