//
//  ViewController.m
//  侧滑动画SlideBar
//
//  Created by ac-hu on 2018/9/10.
//  Copyright © 2018年 ac-hu. All rights reserved.
//

#import "ViewController.h"
#import "SlideBar.h"

@interface ViewController ()
@property(nonatomic,strong)SlideBar *bar;
@property(nonatomic,strong)SlideBar *rbar;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _bar= [[SlideBar alloc]initWithBtnTitle:@[@"1",@"2",@"3"]];
    _bar.width = 200;
    _bar.menuClick = ^(NSInteger index) {
        NSLog(@"%d",(int)index);
    };
    
    _rbar= [[SlideBar alloc]initWithBtnTitle:@[@"1",@"2",@"3"]];
    _rbar.width = 100;
    _rbar.direction = SlideBarDirectionRight;
    _rbar.menuClick = ^(NSInteger index) {
        NSLog(@"%d",(int)index);
    };
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)leftItemClick:(UIBarButtonItem *)sender {
    [_bar switchClick];
}

- (IBAction)rightItemClick:(UIBarButtonItem *)sender {
    [_rbar switchClick];
}

@end
