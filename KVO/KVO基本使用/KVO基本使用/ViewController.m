//
//  ViewController.m
//  KVO基本使用
//
//  Created by ac-hu on 2018/10/1.
//  Copyright © 2018年 sk-hu. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()
@property(nonatomic,strong)Person *p;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    三步
//    1.添加观察者；
//    2.监听观察值；
//    3.移除观察者；
    _p = [Person new];
    [_p addObserver:self forKeyPath:@"fullName" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"%@",[change objectForKey:NSKeyValueChangeNewKey]);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    static int index = 0;
    static int lastIndex = 0;
    _p.fristName = [NSString stringWithFormat:@"%d",lastIndex--];
    _p.lastName = [NSString stringWithFormat:@"%d",index ++];
}

-(void)dealloc{
    [_p removeObserver:self forKeyPath:@"fullName"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
