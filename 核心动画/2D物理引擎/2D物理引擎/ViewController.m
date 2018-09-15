//
//  ViewController.m
//  2D物理引擎
//
//  Created by ac-hu on 2018/9/15.
//  Copyright © 2018年 ac-hu. All rights reserved.
//

#import "ViewController.h"

/*关键类：物理引擎库Dynamics自动绑定到了UIKit里面（逼真的交互设计，自由落体，碰撞，吸附）
  1.UIDynamicAnimator 物理引擎容器
*/
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *redView;
@property(nonatomic,strong)UIDynamicAnimator *animator;//物理引擎容器
@property(nonatomic,strong)UIAttachmentBehavior *attach;//吸附行为
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    1.添加到视图上，相当于父视图
    _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
//    2.行为：这里为自由落体
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc]initWithItems:@[_redView]];
//    3.容器添加行为
    [_animator addBehavior:gravity];
    
    //碰撞行为
    UICollisionBehavior *collision = [[UICollisionBehavior alloc]initWithItems:@[_redView]];
    //是佛碰到边界反弹
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [_animator addBehavior:collision];
    
    //物理属性
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc]initWithItems:@[_redView]];
    //有弹力、密度、阻力等属性：看其属性
    itemBehavior.elasticity = 0.5;
    [_animator addBehavior:itemBehavior];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [_redView addGestureRecognizer:pan];
    
    //吸附行为
//    _attach = [[UIAttachmentBehavior alloc]initWithItem:_redView attachedToAnchor:CGPointMake(0, 0)];
//    [_animator addBehavior:_attach];
    
}

-(void)pan:(UIPanGestureRecognizer *)pan{
    CGPoint point = [pan translationInView:self.view];
    if (pan.state == UIGestureRecognizerStateBegan) {
       _attach = [[UIAttachmentBehavior alloc]initWithItem:_redView offsetFromCenter:UIOffsetMake(-30, -30) attachedToAnchor:point];
        [_animator addBehavior:_attach];
    }else if (pan.state == UIGestureRecognizerStateChanged){
        _attach.anchorPoint = point;
    }else if (pan.state == UIGestureRecognizerStateEnded){
        [_animator removeBehavior:_attach];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
