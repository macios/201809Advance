//
//  ViewController.m
//  CoreAnmotion基础动画
//
//  Created by ac-hu on 2018/9/5.
//  Copyright © 2018年 ac-hu. All rights reserved.
//

//CABasicAnimation和CAKeyframeAnimation都是继承自CAPropertyAnimation
//CAKeyframeAnimation也是根据属性展示动画的，他与CABasicAnimation的不同点在于他可以指定多个状态，不局限于始末状态，这样你的动画将更加灵活。

#import "ViewController.h"
#import "HuAnimationHeader.h"

@interface ViewController ()<CAAnimationDelegate>
@property (weak, nonatomic) IBOutlet UIView *rootView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _rootView.frame = CGRectMake(100, 60, 100, 100);
//    _rootView.clipsToBounds = YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self test4];
}

#pragma mark - 转场动画-CATransition
-(void)test4{
    CGFloat r = arc4random()%100 / 100.f;
    CGFloat g = arc4random()%100 / 100.f;
    CGFloat b = arc4random()%100 / 100.f;
    UIColor *color = [UIColor colorWithRed:r green:g blue:b alpha:1];
    _rootView.backgroundColor = color;
    
    //只能固定方向
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionTypeReveal;//动画类型
    transition.subtype = kCATransitionFromTop;//动画方向
    transition.duration = 1.f;
    [_rootView.layer addAnimation:transition forKey:nil];
}

#pragma mark - 动画组-CAAnimationGroup
-(void)test3{
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    UIBezierPath *path = [UIBezierPath new];
    //第一点终点，后两点为控制点
    [path moveToPoint:CGPointMake(150, 110)];
    [path addCurveToPoint:CGPointMake(300, 500) controlPoint1:CGPointMake(50, 250) controlPoint2:CGPointMake(400, 300)];
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.lineWidth = 1;
    lineLayer.strokeColor = [UIColor greenColor].CGColor;
    lineLayer.path = path.CGPath;
    lineLayer.fillColor = nil; // 默认为blackColor
    [self.view.layer addSublayer:lineLayer];
    
    animation.path = path.CGPath;//指定路径
    CABasicAnimation * animaiton1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animaiton1.toValue = @2.;
    
    CAAnimationGroup *animaGroup = [CAAnimationGroup new];
    animaGroup.animations = @[animation,animaiton1];
    animaGroup.removedOnCompletion = NO;
    animaGroup.fillMode = kCAFillModeForwards;
    animaGroup.repeatCount = MAXFLOAT;//重复次数
    animaGroup.autoreverses = YES;
    animaGroup.duration = 2;
    animaGroup.delegate = self;
    
    [_rootView.layer addAnimation:animaGroup forKey:nil];
}

#pragma mark - 多值动画-CAKeyframeAnimation
-(void)test2{
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    animation.values = @[[NSValue valueWithCGPoint:CGPointMake(0, 0)],[NSValue valueWithCGPoint:CGPointMake(100, 100)],[NSValue valueWithCGPoint:CGPointMake(0, 200)]];//指定值
    
    UIBezierPath *path = [UIBezierPath new];
    //第一点终点，后两点为控制点
    [path moveToPoint:CGPointMake(150, 110)];
    [path addCurveToPoint:CGPointMake(300, 500) controlPoint1:CGPointMake(50, 250) controlPoint2:CGPointMake(400, 300)];
    //未能找到设置多点形成圆滑曲线的方法，需要用记性封装的一个代码
//    [path addQuadCurveToPoint:CGPointMake(50, 250) controlPoint:CGPointMake(20, 200)];
//    [path addQuadCurveToPoint:CGPointMake(100, 300) controlPoint:CGPointMake(200, 250)];
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.lineWidth = 1;
    lineLayer.strokeColor = [UIColor greenColor].CGColor;
    lineLayer.path = path.CGPath;
    lineLayer.fillColor = nil; // 默认为blackColor
    [self.view.layer addSublayer:lineLayer];
    
    animation.path = path.CGPath;//指定路径
    animation.duration = 2;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = YES;
    animation.autoreverses = NO;
    [_rootView.layer addAnimation:animation forKey:@"keyframe"];
}

#pragma mark - 简单动画-CABasicAnimation
-(void)test1{
    
    CABasicAnimation * animaiton = [CABasicAnimation animationWithKeyPath:@"position.y"];
    //    position center
    animaiton.removedOnCompletion = NO;
    
    //    kCAFillModeForwards//保持结束时状态
    //    kCAFillModeBackwards//保持开始时状态
    //    kCAFillModeBoth//保持两者，我没懂两者是什么概念，实际使用中与kCAFillModeBackwards相同
    //    kCAFillModeRemoved//移除
    animaiton.fillMode = kCAFillModeForwards;
    
    animaiton.repeatCount = MAXFLOAT;//重复次数
    animaiton.autoreverses = YES;//是否执行反向动画
    animaiton.duration = 2;
    animaiton.toValue = @400.;
    animaiton.delegate = self;
    [_rootView.layer addAnimation:animaiton forKey:nil];//所有设置需要在这之前，后面再添加不会被copy到动画里了
}

-(void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"%@",NSStringFromCGRect(_rootView.frame));
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
//    _rootView.frame = CGRectMake(100, 350, 100, 100);
    NSLog(@"%@",NSStringFromCGRect(_rootView.frame));
}

@end
