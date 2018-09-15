//
//  ViewController.m
//  QQ未读红点拖动效果
//
//  Created by ac-hu on 2018/9/15.
//  Copyright © 2018年 ac-hu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *smallView;

@property (weak, nonatomic) IBOutlet UIView *bigView;
@property(nonatomic,strong)CAShapeLayer *shaLayer;

@property(nonatomic,assign)CGRect smallFram;
@property(nonatomic,assign)CGRect bigFram;

@property(nonatomic,strong)UIPanGestureRecognizer *pan;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _smallFram = _smallView.frame;
    _bigFram = _bigView.frame;
    
    _pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [_bigView addGestureRecognizer:_pan];
    
    _shaLayer = [CAShapeLayer layer];
    _shaLayer.fillColor = [UIColor redColor].CGColor;
    [self.view.layer insertSublayer:_shaLayer above:_smallView.layer];
}


- (void)pan:(UIPanGestureRecognizer *)pan{
    CGPoint point = [pan locationInView:self.view];
    _bigView.center = point;
    
    //求关键点 6 个
    [self calculatePoint];
}

-(void)calculatePoint{
//    1.小圆中心点
    CGPoint pointSmall = _smallView.center;
    CGPoint pointBig = _bigView.center;
    
//    2.两个中心点距离
    CGFloat distance = sqrt(powf(pointSmall.x - pointBig.x, 2) + powf(pointSmall.y - pointBig.y, 2));
//    3.计算正余弦
    CGFloat sin = fabs(pointBig.x - pointSmall.x) / distance;
    CGFloat cos = fabs(pointBig.y - pointSmall.y) / distance;
    
//    4.两个圆的半径
    CGFloat smallRadius = CGRectGetWidth(_smallFram)/2.f - distance/20.;
    CGFloat bigRadius = CGRectGetWidth(_bigView.frame)/2.f;
    if (smallRadius < 5) {
        [_shaLayer removeFromSuperlayer];
        _pan.enabled = NO;
        
        
        //这里是重复测试
        _smallView.frame = _smallFram;
        _smallView.layer.cornerRadius = _smallFram.size.width/2.f;
        _bigView.frame = _bigFram;
        _shaLayer = [CAShapeLayer layer];
        _shaLayer.fillColor = [UIColor redColor].CGColor;
        [self.view.layer insertSublayer:_shaLayer above:_smallView.layer];
        _pan.enabled = YES;
        
        //真实开发这里的代码不需要注释:还需要加上溶解动画
        _smallView.hidden = YES;
        _bigView.hidden = YES;
        return;
    }
//    5.找点
//    点1.计算小圆焦点1
    CGPoint pointSmallA = CGPointMake(pointSmall.x - cos * smallRadius, pointSmall.y - sin * smallRadius);
//    点2.计算小圆焦点2
    CGPoint pointSmallB = CGPointMake(pointSmall.x + cos * smallRadius, pointSmall.y + sin * smallRadius);
//    点3.计算大圆焦点1
    CGPoint pointBigA = CGPointMake(pointBig.x - cos * bigRadius, pointBig.y - sin * bigRadius);
//    点4.计算大圆焦点2
    CGPoint pointBigB = CGPointMake(pointBig.x + cos * bigRadius, pointBig.y + sin * bigRadius);
//    点5.曲线控制点1
    CGPoint pointControlA = CGPointMake(pointSmallA.x + distance/2 * sin,pointSmallB.y - distance/2 * cos);
//    点6.曲线控制点2
    CGPoint pointControlB = CGPointMake(pointSmallB.x + distance/2 * sin, pointSmallA.y - distance/2 *cos);
    
//    5.画线
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:pointSmallA];
    [path addQuadCurveToPoint:pointBigA controlPoint:pointControlB];
    [path addLineToPoint:pointBigB];
    [path addQuadCurveToPoint:pointSmallB controlPoint:pointControlA];
    [path closePath];
    
    _shaLayer.path = path.CGPath;
    _smallView.bounds = CGRectMake(0, 0, smallRadius * 2, smallRadius * 2);
    _smallView.layer.cornerRadius = smallRadius;
}


@end
