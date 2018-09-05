//
//  HuAnimationHeader.h
//  CoreAnmotion基础动画
//
//  Created by ac-hu on 2018/9/5.
//  Copyright © 2018年 ac-hu. All rights reserved.
//

#ifndef HuAnimationHeader_h
#define HuAnimationHeader_h

NSString * const kCATransitionTypeCube = @"cube";//立体翻转
NSString * const kCATransitionTypeOglFlip = @"oglFlip";//平面翻转
NSString * const kCATransitionTypeSuckEffect = @"suckEffect";//右上角扯桌布效果
NSString * const kCATransitionTypeRippleEffect = @"rippleEffect";//很快-视觉上没啥效果
NSString * const kCATransitionTypePageCurl = @"pageCurl";//翻书页效果
NSString * const kCATransitionTypePageUnCurl = @"pageUnCurl";//合单个书页效果
NSString * const kCATransitionTypeCameraIrisHollowOpen = @"cameraIrisHollowOpen";//圆形从里到外
NSString * const kCATransitionTypeCameraIrisHollowClose = @"cameraIrisHollowClose";//圆形从外到里
NSString * const kCATransitionTypeFade = @"fade";//颜色渐变效果
NSString * const kCATransitionTypePush = @"push";//另生成一个渐拉
NSString * const kCATransitionTypeMoveIn = @"moveIn";//另生成一个叠加
NSString * const kCATransitionTypeReveal = @"reveal";//另生成一个发射

#endif /* HuAnmotionHeader_h */
