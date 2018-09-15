//
//  BaseNav.m
//  自定义转场动画
//
//  Created by ac-hu on 2018/9/15.
//  Copyright © 2018年 ac-hu. All rights reserved.
//

#import "BaseNav.h"
#import "TransitionAnimation.h"

@interface BaseNav ()<UINavigationControllerDelegate>

@end

@implementation BaseNav

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.delegate
}

//告诉NAV需要自己实现这个转场动画
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0){
    TransitionAnimation<UIViewControllerAnimatedTransitioning> *trans = (id<UIViewControllerAnimatedTransitioning>)[TransitionAnimation new];
    if(operation == UINavigationControllerOperationPush){
        
        trans.isPush = YES;
        return trans;
    }else if(operation == UINavigationControllerOperationPop){
        trans.isPush = NO;
        return trans;
    }
    
    return nil;
    
}

////手势动画
//- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
//                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController NS_AVAILABLE_IOS(7_0){
//    return [super navigationController:navigationController interactionControllerForAnimationController:animationController];
//}

@end
