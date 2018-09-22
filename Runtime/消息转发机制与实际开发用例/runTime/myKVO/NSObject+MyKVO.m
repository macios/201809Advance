//
//  NSObject+MyKVO.m
//  runTime
//
//  Created by ac hu on 2018/6/17.
//  Copyright © 2018年 ac hu. All rights reserved.
//

#import "NSObject+MyKVO.h"
#import <objc/message.h>

@implementation NSObject (MyKVO)
- (void)my_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context{
    //第一步：模仿系统动态注册一个新类，这个类继承原对象的类
    NSString *oldClassName = NSStringFromClass([self class]);
    NSString *newClassName = [NSString stringWithFormat:@"myKVO_%@",oldClassName];
    Class newClass= objc_allocateClassPair([self class], newClassName.UTF8String, 0);//创建
    objc_registerClassPair(newClass);//注册
    
    //第二部：修改self属性
    object_setClass(self, newClass);
    
    //第三部：重写子类的set方法
    NSString *methodName = [NSString stringWithFormat:@"set%@:",keyPath.capitalizedString];
    SEL sel = NSSelectorFromString(methodName);
    class_addMethod(newClass, sel, (IMP)setName, "v@:@");//@:二三位不动
    
    //通知观察者
    //设置关联对象
    objc_setAssociatedObject(self, (__bridge const void*)@"objc", observer, OBJC_ASSOCIATION_ASSIGN);//OBJC_ASSOCIATION_ASSIGN弱引用
}
//SEL _cmd方法编号
void setName(id self,SEL _cmd,NSString *name){
    NSLog(@"myKVO:%@",name);
    //改变父对象的属性
    struct objc_super superClass = {self,class_getSuperclass([self class])};
    objc_msgSendSuper(&superClass,_cmd,name);
    
    //获取关联对象
    id observer = objc_getAssociatedObject(self, (__bridge const void*)@"objc");
    NSString *key = @"name";
    objc_msgSend(observer, @selector(observeValueForKeyPath:ofObject:change:context:),key,self,@{key:name},nil);
}
@end
