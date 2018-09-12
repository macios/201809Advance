//
//  ViewController.m
//  点赞动画
//
//  Created by ac-hu on 2018/9/10.
//  Copyright © 2018年 ac-hu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *likeBgView;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (nonatomic, strong) CAEmitterLayer *emitterLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_likeBtn setImage:[UIImage imageNamed:@"default"] forState:UIControlStateNormal];
    [_likeBtn setImage:[UIImage imageNamed:@"select"] forState:UIControlStateSelected];
    [self explosion];
}

- (void)explosion{
    _emitterLayer = [CAEmitterLayer layer];
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.name = @"explosionCell";
    cell.lifetime = .7;
    cell.birthRate = 4000;
    cell.velocity = 50;
    cell.velocityRange = 15;
    cell.scale = .03;
    cell.scaleRange = .02;
    cell.contents = (id)[UIImage imageNamed:@"sparkle"].CGImage;
    
    _emitterLayer.name = @"explosionLayer";
    _emitterLayer.emitterShape = kCAEmitterLayerCircle;
    _emitterLayer.emitterMode = kCAEmitterLayerVolume;
    _emitterLayer.emitterSize = CGSizeMake(25, 0);
    _emitterLayer.emitterCells = @[cell];
    _emitterLayer.renderMode = kCAEmitterLayerAdditive;
    _emitterLayer.masksToBounds = NO;
    _emitterLayer.birthRate = 0;
    _emitterLayer.zPosition = 0;
    _emitterLayer.position = CGPointMake(CGRectGetWidth(_likeBtn.bounds)/2, CGRectGetHeight(_likeBtn.bounds)/2);
    
    [_likeBgView.layer addSublayer:_emitterLayer];
    
}
- (IBAction)likeBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    //关键帧动画
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    if (sender.selected) {
        anim.values = @[@1.5, @0.8, @1.4, @0.9, @1.3,@1.2];
        anim.duration = .6;
        [self addExplosionAnim];
    }else{
        anim.values = @[@1.0];
        anim.duration = .4;
    }
    [_likeBtn.layer addAnimation:anim forKey:nil];
}

- (void)addExplosionAnim{
    _emitterLayer.emitterMode = kCAEmitterLayerOutline;
    _emitterLayer.beginTime = CACurrentMediaTime();
    _emitterLayer.birthRate = 1;
    __weak typeof(self) weakSelf = self;
//    typeof(__weak) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakSelf.emitterLayer.birthRate = 0;
    });
    
}

@end
