//
//  SlideBar.m
//  侧滑动画SlideBar
//
//  Created by ac-hu on 2018/9/10.
//  Copyright © 2018年 ac-hu. All rights reserved.
//

#import "SlideBar.h"

#define SlideBarmenuBlankWidth 50
#define SlideBarmenuBtnHeight 40
#define SlideBarbuttonSpace 30
#define WEAKSELFSlideBar typeof(self) __weak weakSelf = self;
#define SlideBtnTag 2000

@interface SlideBar()
@property(nonatomic,strong)UIVisualEffectView *blurView;//毛玻璃背景视图
@property(nonatomic,strong)UIView *helperSideView;//辅助块视图（算回弹动画差值）
@property(nonatomic,strong)UIView *helperCenterView;//辅助块视图（算回弹动画差值）
@property(nonatomic,strong)UIWindow *keyWindow;//辅助
@property(nonatomic,assign)BOOL isShow;//是否显示
@property(nonatomic,assign)CGFloat diff;//回弹动画差值
@property(nonatomic,strong)UIColor *menuColor;//主题颜色
@property(nonatomic,strong)CADisplayLink *displayLink;//timer
@property(nonatomic,strong)NSArray *titles;

@end

@implementation SlideBar

- (instancetype)initWithBtnTitle:(NSArray *)btnTitles{
    if (self = [super init]) {
        _titles = btnTitles;
        [self creatView];
    }
    return self;
}

-(void)setBgAlpha:(CGFloat)bgAlpha{
    _bgAlpha = bgAlpha;
    _blurView.alpha = bgAlpha;
}

-(void)setWidth:(CGFloat)width{
    _width = width;
    if (_direction == SlideBarDirectionLeft) {
        self.frame = CGRectMake(-(width + SlideBarmenuBlankWidth), CGRectGetMinY(self.frame), width + SlideBarmenuBlankWidth, CGRectGetHeight(self.frame));
    }else if (_direction == SlideBarDirectionRight){
        self.frame = CGRectMake(CGRectGetWidth(_keyWindow.frame), CGRectGetMinY(self.frame), width + SlideBarmenuBlankWidth, CGRectGetHeight(self.frame));
    }
    
    for (int i = 0; i < _titles.count; i++) {
        UIView *view = [self viewWithTag:SlideBtnTag + i];
        [view removeFromSuperview];
    }
    [self addBtnView];
}



-(void)setDirection:(SlideBarDirection)direction{
    _direction = direction;
    self.width = _width;
}

-(void)creatView{
    _direction = SlideBarDirectionLeft;
    
    _menuColor = [UIColor colorWithRed:0 green:0.722 blue:1 alpha:1];
    
    _keyWindow = [UIApplication sharedApplication].keyWindow;
    _blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    _blurView.frame = _keyWindow.frame;
    _blurView.alpha = 0.5;
    
    self.frame = CGRectMake(-(CGRectGetWidth(_keyWindow.frame)/2 + SlideBarmenuBlankWidth), 0, CGRectGetWidth(_keyWindow.frame)/2 + SlideBarmenuBlankWidth, CGRectGetHeight(_keyWindow.frame));
    self.backgroundColor = [UIColor clearColor];
    _width = CGRectGetWidth(_keyWindow.frame)/2.;
    
    _helperSideView = [[UIView alloc] initWithFrame:CGRectMake(-40, 0, 40, 40)];;
    
    _helperCenterView = [[UIView alloc] initWithFrame:CGRectMake(-40, CGRectGetHeight(_keyWindow.bounds)/2-20, 40, 40)];
    
    [_keyWindow addSubview:_helperSideView];
    [_keyWindow addSubview:_helperCenterView];
    [_keyWindow insertSubview:self belowSubview:_helperSideView];
    
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView)];
    [_blurView addGestureRecognizer:tap];
    
    //添加按钮
    [self addBtnView];
}

-(void)addBtnView{
    CGFloat space = (CGRectGetHeight(_keyWindow.bounds) - _titles.count * SlideBarmenuBtnHeight - (_titles.count-1) * SlideBarbuttonSpace)/2.;
    for (int i = 0; i < _titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (_direction == SlideBarDirectionLeft) {
            btn.center = CGPointMake(_width / 2., space + SlideBarmenuBtnHeight * i + SlideBarbuttonSpace * i);
        }else if (_direction == SlideBarDirectionRight){
            btn.center = CGPointMake((self.frame.size.width - _width) + _width / 2., space + SlideBarmenuBtnHeight * i + SlideBarbuttonSpace * i);
        }
        
        btn.bounds = CGRectMake(0, 0, _width - 20 * 2, SlideBarmenuBtnHeight);
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = SlideBtnTag + i;
        btn.layer.cornerRadius = CGRectGetHeight(btn.frame) / 2.;
        btn.layer.borderWidth = .5;
        btn.layer.borderColor = [UIColor whiteColor].CGColor;
        btn.clipsToBounds = YES;
        [self addSubview:btn];
    }
}

-(void)btnClick:(UIButton *)btn{
    if (self.menuClick) {
        self.menuClick(btn.tag - SlideBtnTag);
    }
}

- (void)switchClick{
    if (!_isShow) {
        [self showView];
    }else{
        [self dismissView];
    }
}

#pragma mark - 动画开始
-(void)showView{
    WEAKSELFSlideBar
    _isShow = YES;
    //1.添加模糊背景
    [_keyWindow insertSubview:_blurView belowSubview:self];
    //2.划入菜单栏.3
    if (_direction == SlideBarDirectionLeft) {
        [UIView animateWithDuration:.3 animations:^{
            weakSelf.frame = weakSelf.bounds;
            weakSelf.blurView.alpha = 1;
        }];
    }else if (_direction == SlideBarDirectionRight){
        [UIView animateWithDuration:.3 animations:^{
            weakSelf.frame = CGRectMake(CGRectGetWidth(weakSelf.keyWindow.frame) - weakSelf.frame.size.width, 0, weakSelf.frame.size.width, weakSelf.frame.size.height);
            weakSelf.blurView.alpha = 1;
        }];
    }
    
    //3.添加弹簧动画：延时-阻尼-速度
    [UIView animateWithDuration:.8 delay:0 usingSpringWithDamping:.6 initialSpringVelocity:.9 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        weakSelf.helperSideView.center = CGPointMake(weakSelf.width, CGRectGetHeight(weakSelf.helperSideView.bounds)/2);
    } completion:nil];
    [UIView animateWithDuration:.8 delay:0 usingSpringWithDamping:.9 initialSpringVelocity:2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        weakSelf.helperCenterView.center = CGPointMake(weakSelf.width, weakSelf.keyWindow.center.y);
    } completion:^(BOOL finished) {
        [weakSelf removeDisplayLink];
    }];
    //获取差值
    [self getDiff];
    //添加按钮的动画
    [self addBtnAnim];
    
}

- (void)drawRect:(CGRect)rect{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    if (_direction == SlideBarDirectionLeft) {
        [path moveToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake(_width, 0)];
        [path addQuadCurveToPoint:CGPointMake(_width, CGRectGetHeight(_keyWindow.frame)) controlPoint:CGPointMake(_width + _diff, CGRectGetHeight(_keyWindow.frame)/2)];
        [path addLineToPoint:CGPointMake(0, CGRectGetHeight(_keyWindow.frame))];
        [path closePath];
    }else if (_direction == SlideBarDirectionRight){
        [path moveToPoint:CGPointMake(rect.size.width, 0)];
        [path addLineToPoint:CGPointMake(rect.size.width - _width, 0)];
        [path addQuadCurveToPoint:CGPointMake(rect.size.width - _width, CGRectGetHeight(_keyWindow.frame)) controlPoint:CGPointMake(rect.size.width - _width -  _diff, CGRectGetHeight(_keyWindow.frame)/2)];
        [path addLineToPoint:CGPointMake(rect.size.width, CGRectGetHeight(_keyWindow.frame))];
        [path closePath];
    }
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, path.CGPath);
    [_menuColor set];
    CGContextFillPath(context);
}

//添加定时器
- (void)getDiff{
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction)];
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
}

- (void)displayLinkAction{
    //    NSLog(@"%@",NSStringFromCGRect(helperSideView.frame));
    CALayer *layer1 = _helperSideView.layer.presentationLayer;
    CALayer *layer2 = _helperCenterView.layer.presentationLayer;
    
    CGRect r1 = [[layer1 valueForKeyPath:@"frame"] CGRectValue];
    CGRect r2 = [[layer2 valueForKeyPath:@"frame"] CGRectValue];
    
    _diff = r1.origin.x - r2.origin.x;
    NSLog(@"%f",_diff);
    
    
    [self setNeedsDisplay];
}

- (void)addBtnAnim{
    for (int i = 0; i < self.subviews.count; i++) {
        UIView *btn = [self viewWithTag:SlideBtnTag + i];
        if (_direction == SlideBarDirectionLeft) {
            btn.transform = CGAffineTransformMakeTranslation(-CGRectGetWidth(btn.frame), 0);
        }else if(_direction == SlideBarDirectionRight){
            btn.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(btn.frame), 0);
        }
        
        [UIView animateWithDuration:.7 delay:i*(0.3/self.subviews.count) usingSpringWithDamping:.6 initialSpringVelocity:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            btn.transform = CGAffineTransformIdentity;
        } completion:nil];
    }
}

#pragma mark - 动画消失

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGRect rect;
    if (_direction == SlideBarDirectionLeft) {
        rect = CGRectMake(_width, 0, SlideBarmenuBlankWidth, self.frame.size.height);
    }else{
        rect = CGRectMake(0, 0, SlideBarmenuBlankWidth, self.frame.size.height);
    }
    if (CGRectContainsPoint(rect, point)) {
        [self dismissView];
    }
}

//消失
- (void)dismissView{
    WEAKSELFSlideBar
    _isShow = NO;
    if (_direction == SlideBarDirectionLeft) {
        [UIView animateWithDuration:.3 animations:^{
            weakSelf.frame =CGRectMake(-(weakSelf.width + SlideBarmenuBlankWidth), 0, weakSelf.width + SlideBarmenuBlankWidth, CGRectGetHeight(weakSelf.keyWindow.frame));
            weakSelf.blurView.alpha = 0;
            weakSelf.helperSideView.center = CGPointMake(-20, 20);
            weakSelf.helperCenterView.center = CGPointMake(-20, CGRectGetHeight(weakSelf.keyWindow.bounds)/2);
        }];
    }else if (_direction == SlideBarDirectionRight){
        [UIView animateWithDuration:.3 animations:^{
            weakSelf.frame =CGRectMake(CGRectGetWidth(weakSelf.keyWindow.frame) + (weakSelf.width + SlideBarmenuBlankWidth), 0, weakSelf.width + SlideBarmenuBlankWidth, CGRectGetHeight(weakSelf.keyWindow.frame));
            weakSelf.blurView.alpha = 0;
            weakSelf.helperSideView.center = CGPointMake(-20, 20);
            weakSelf.helperCenterView.center = CGPointMake(-20, CGRectGetHeight(weakSelf.keyWindow.bounds)/2);
        }];
    }
    
}

-(void)removeDisplayLink{
    [self.displayLink invalidate];
    self.displayLink = nil;
}
@end

