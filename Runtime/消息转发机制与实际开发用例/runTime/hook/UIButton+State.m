//
//  UIButton+State.m
//  duoduo
//
//  Created by ac hu on 2018/6/17.
//  Copyright © 2018年 ac hu. All rights reserved.
//

#import "UIButton+State.h"
#import <objc/objc.h>
#import <objc/runtime.h>

static const char *associatedHighBackColorKey = "highBackColor";
static const char *associatedHighImageColorKey = "highImage";
static const char *associatedTextColorColorKey = "textColor";
static const char *associatedTextHighColorColorKey = "textHighColor";
static const char *associatedTitleKey = "title";
static const char *associatedFontColorKey = "font";

@implementation UIButton(State)

-(void)setHighBackColor:(UIColor *)highBackColor{
    //设置关联对象 因为在分类中 @property 并不会自动生成实例变量以及存取方法，所以一般使用关联对象为已经存在的类添加『属性』。
    //第一个参数：给那个对象关联
    //第二个参数：关联的key，通过这个key获取
    //第三个参数：关联的值
    //第四个参数：关联策略
    objc_setAssociatedObject(self, associatedHighBackColorKey, highBackColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self setImage:[self creatImageFromColor:highBackColor size:CGSizeMake(self.frame.size.width, self.frame.size.height)] forState:UIControlStateHighlighted];
}

-(UIColor *)highBackColor{
    //根据关联的key，获取关联值
    return objc_getAssociatedObject(self, associatedHighBackColorKey);
}


-(void)setHighImage:(UIImage *)highImage{
    objc_setAssociatedObject(self, associatedHighImageColorKey, highImage, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self setImage:highImage forState:UIControlStateHighlighted];
}

-(UIImage *)highImage{
    return objc_getAssociatedObject(self, associatedHighImageColorKey);
}

-(void)setTextColor:(UIColor *)textColor{
    objc_setAssociatedObject(self, associatedTextColorColorKey, textColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self setTitleColor:textColor forState:UIControlStateNormal];
}

-(UIColor *)textColor{
    return objc_getAssociatedObject(self, associatedTextColorColorKey);
}

-(void)setTextHighColor:(UIColor *)textHighColor{
    objc_setAssociatedObject(self, associatedTextHighColorColorKey, textHighColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self setTitleColor:textHighColor forState:UIControlStateHighlighted];
}

-(UIColor *)textHighColor{
    return objc_getAssociatedObject(self, associatedTextHighColorColorKey);
}

-(void)setTitle:(NSString *)title{
    objc_setAssociatedObject(self, associatedTitleKey, title, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self setTitle:title forState:UIControlStateNormal];
}

-(NSString *)title{
    return objc_getAssociatedObject(self, associatedTitleKey);
}

-(void)setFont:(CGFloat)font{
    objc_setAssociatedObject(self, associatedFontColorKey, [NSString stringWithFormat:@"%f",font], OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.titleLabel.font = [UIFont systemFontOfSize:font];
}

-(CGFloat)font{
    return [objc_getAssociatedObject(self, associatedFontColorKey) integerValue];
}

//通过颜色来生成一个纯色图片 这里应该属于uiimage的拓展，但是这里封装保持原有性，不依赖其他
-(UIImage *)creatImageFromColor:(UIColor *)color size:(CGSize)size{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
