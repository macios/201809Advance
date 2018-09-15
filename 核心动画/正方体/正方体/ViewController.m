//
//  ViewController.m
//  正方体
//
//  Created by ac-hu on 2018/9/15.
//  Copyright © 2018年 ac-hu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong)CATransformLayer *cubeLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    正方体每个面都是一个layer。绘制六个面再组装起来
    //特殊的layer
    CATransformLayer *cubeLayer = [CATransformLayer layer];
    
    //1.CATransform3DMakeTranslation x.y.z——面的平移值z垂直与屏幕
    CATransform3D ct = CATransform3DMakeTranslation(0, 0, 50);
    [cubeLayer addSublayer:[self ctreatTransform:ct]];
    
    //2
    ct = CATransform3DMakeTranslation(0, 0, -50);
//    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cubeLayer addSublayer:[self ctreatTransform:ct]];
    
    //3
    ct = CATransform3DMakeTranslation(50, 0, 0);
    //CATransform3DRotate沿着那个轴旋转
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cubeLayer addSublayer:[self ctreatTransform:ct]];
    
    //4
    ct = CATransform3DMakeTranslation(-50, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cubeLayer addSublayer:[self ctreatTransform:ct]];
    
    //5
    ct = CATransform3DMakeTranslation(0, 50, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [cubeLayer addSublayer:[self ctreatTransform:ct]];
    
    //6
    ct = CATransform3DMakeTranslation(0, -50, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [cubeLayer addSublayer:[self ctreatTransform:ct]];
    
    //将正个正方体旋转，不然就只能看到一个面
    cubeLayer.transform = CATransform3DMakeRotation(M_PI_4, 1, 1, 2);
    
    cubeLayer.position = self.view.center;
    [self.view.layer addSublayer:cubeLayer];
    _cubeLayer = cubeLayer;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
}

-(void)pan:(UIPanGestureRecognizer *)pan{
    CGPoint point = [pan translationInView:self.view];
    NSLog(@"%f %f",point.x,point.y);
    _cubeLayer.transform = CATransform3DMakeRotation(M_PI_4, point.x, point.y, 0);
}

-(CALayer *)ctreatTransform:(CATransform3D)trans{
    CALayer *layer = [CALayer layer];
    //确定面的大小
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.backgroundColor = [UIColor colorWithRed:arc4random()/(CGFloat)INT_MAX green:arc4random()/(CGFloat)INT_MAX blue:arc4random()/(CGFloat)INT_MAX alpha:1].CGColor;
    layer.transform = trans;
    return layer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
