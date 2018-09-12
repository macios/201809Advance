//
//  ViewController.m
//  SceneKitTest
//
//  Created by ac-hu on 2018/9/11.
//  Copyright © 2018年 ac-hu. All rights reserved.
//

#import "ViewController.h"
#import "HSF3DModelView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HSF3DModelView *view = [[HSF3DModelView alloc]initWithFrame:self.view.frame];
    [view hsf_create3DFromBundle:@"1.mtl"];
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
