//
//  Person.m
//  runTime
//
//  Created by ac hu on 2018/6/17.
//  Copyright © 2018年 ac hu. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
#import "Standby.h"

@implementation Person

//1.动态方法解析
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    //若不实现sendMessage以下方法，即注释以下代码，则走第2部找备用
    
//    NSString *methodName = NSStringFromSelector(sel);
//    if ([methodName isEqualToString:@"sendMessage:"]) {
//        //看文档可知 依次是参数类 方法名 函数指针
//       //"v@:@" v返回类型 @id类型 @参数
//        return class_addMethod([self class], sel, (IMP)sendMessage, "v@:@");
//    }
    return NO;
}
//IMP  _Nonnull imp 只是两个参数
void sendMessage(id self,SEL _cmd,NSString *message){
    NSLog(@"%@",message);
}

//2.找备用接收者
-(id)forwardingTargetForSelector:(SEL)aSelector{
    //若无备用方法，即注释以下代码，则走第3部消息转发
//    NSString *methodName = NSStringFromSelector(aSelector);
//    if ([methodName isEqualToString:@"sendMessage:"]) {
//        return [Standby new];
//    }
    // 如果没有则继续找
    return [super forwardingTargetForSelector:aSelector];
}

//3.1方法签名
-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSString *methodName = NSStringFromSelector(aSelector);
    if ([methodName isEqualToString:@"sendMessage:"]) {
        return [NSMethodSignature signatureWithObjCTypes:("v@:@")];
    }
    // 如果没有则继续找
    return [super methodSignatureForSelector:aSelector];
}

//3.2消息转发
//anInvocation方法签名的信息在这里面
-(void)forwardInvocation:(NSInvocation *)anInvocation{
    //若转发不成功，即注释以下代码，则走第4部，消息无法处理
//    SEL sel = [anInvocation selector];
//    Standby *sta = [Standby new];
//    //如果sta 实现了这个方法就转发给他
//    if (sel && [sta respondsToSelector:sel]) {
//        [anInvocation invokeWithTarget:sta];
//    }else{
//        // 如果没有则继续找
//        [super forwardInvocation:anInvocation];
//    }
    [super forwardInvocation:anInvocation];
}

//4消息最终没有处理
-(void)doesNotRecognizeSelector:(SEL)aSelector{
    NSLog(@"消息无法处理，这里可以抛异常");
}
@end
