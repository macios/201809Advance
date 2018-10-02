//
//  Person.m
//  引用计数-进阶
//
//  Created by ac-hu on 2018/10/2.
//  Copyright © 2018年 sk-hu. All rights reserved.
//

#import "Person.h"

//系统为了节约内存，会做以下宏优化
#define PersonDirectionFrontMask (1 << 0)//== 0b00000001 左移0位：iOS是从右往左
#define PersonDirectionBackMask (1 << 1)//== 0b00000010 左移1位
#define PersonDirectionLeftMask 0b00000100
#define PersonDirectionRightMask 0b00001000

@interface Person(){
    //联合体
    union{
        char bits;//举的是八位例子
//        //        0b 0000 1111: 0000 right-left-back-front
        //结构体：打开后注释就可以直接赋值取值了
        struct{
            char front : 1;//(1 << 0)右0位
            char back : 1;//(1 << 1)右1位
            char left : 1;//(1 << 2)右2位
            char right : 1;//(1 << 3)右3位
        };
    } _direction;
}
@end

@implementation Person

-(instancetype)init{
    if (self = [super init]) {
        _direction.bits = 0b00000000;
    }
    return self;
}

-(void)setFront:(BOOL)front{
//    if (front) {
//        _direction.bits |= 0b00000001;
//    }else{
//        _direction.bits |= ~0b00000001;//取反
//    }
//    结构体打开后就可以直接赋值取值了
    _direction.front = front;
}

-(BOOL)front{
//    return _direction.bits & 0b00000001;
    return _direction.front;
}

//以下对back进行宏优化，front为未优化的，作对比
-(void)setBack:(BOOL)back{
    if (back) {
        _direction.bits |= PersonDirectionBackMask;
    }else{
        _direction.bits |= ~PersonDirectionBackMask;//取反
    }
}

-(BOOL)back{
    return _direction.bits & PersonDirectionBackMask;
    
}
@end




