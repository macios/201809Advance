//
//  UIButton+State.h
//  duoduo
//
//  Created by ac hu on 2018/6/17.
//  Copyright © 2018年 ac hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton(State)
@property(nonatomic,strong)UIColor *highBackColor;
@property(nonatomic,strong)UIImage *highImage;
@property(nonatomic,strong)UIColor *textColor;
@property(nonatomic,strong)UIColor *textHighColor;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,assign)CGFloat font;
@end
