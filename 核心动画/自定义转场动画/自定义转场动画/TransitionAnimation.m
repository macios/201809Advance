//
//  TransitionAnimation.m
//  自定义转场动画
//
//  Created by ac-hu on 2018/9/15.
//  Copyright © 2018年 ac-hu. All rights reserved.
//

#import "TransitionAnimation.h"
#import <UIKit/UIKit.h>

@interface TransitionAnimation()<UIViewControllerAnimatedTransitioning,CAAnimationDelegate>
@property(nonatomic,copy)id<UIViewControllerContextTransitioning> context;
@end

@implementation TransitionAnimation

//时间
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return .8;
}

//实现动画
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    //1.上下文
    _context = transitionContext;
    
    //2.获得容器
    UIView *containerView = [_context containerView];
    UIViewController *fromVC = [_context viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [_context viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //3.添加下一个界面的view到容器里面
    if (_isPush) {
        [containerView addSubview:fromVC.view];
        [containerView addSubview:toVC.view];
    }else{
        [containerView addSubview:toVC.view];
        [containerView addSubview:fromVC.view];
    }
    //4.画动画形状路径
    UIBezierPath *startPath;
    UIBezierPath *endPath;
    if (_isPush) {
       startPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(toVC.view.frame.size.width, toVC.view.frame.size.height, 0, 0)];
      endPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(toVC.view.frame.size.width, toVC.view.frame.size.height) radius:sqrt(powf(toVC.view.frame.size.width, 2) + powf(toVC.view.frame.size.height, 2)) startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    }else{
        startPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(toVC.view.frame.size.width, toVC.view.frame.size.height) radius:sqrt(powf(toVC.view.frame.size.width, 2) + powf(toVC.view.frame.size.height, 2)) startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        endPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(toVC.view.frame.size.width, toVC.view.frame.size.height, 0, 0)];
    }
    
//    //4.添加动画
    //4.1.蒙版-结束时的路径
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    if (_isPush) {
        shapeLayer.path = endPath.CGPath;
        toVC.view.layer.mask = shapeLayer;
    }else{
        shapeLayer.path = endPath.CGPath;
        fromVC.view.layer.mask = shapeLayer;
    }
    
    CABasicAnimation *animation = [[CABasicAnimation alloc]init];
    animation.keyPath = @"path";
    animation.fromValue = (id)startPath.CGPath;
    animation.toValue = (id)endPath.CGPath;
    animation.delegate = self;
    [shapeLayer addAnimation:animation forKey:nil];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [_context completeTransition:YES];
    if (_isPush) {
        UIViewController *toVC = [_context viewControllerForKey:UITransitionContextToViewControllerKey];
        toVC.view.layer.mask = nil;
    }else{
        UIViewController *fromVC = [_context viewControllerForKey:UITransitionContextFromViewControllerKey];
        fromVC.view.layer.mask = nil;
    }
    
}
@end
