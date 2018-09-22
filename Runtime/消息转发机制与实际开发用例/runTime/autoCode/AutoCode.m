//
//  AutoCode.m
//  runTime
//
//  Created by ac hu on 2018/6/17.
//  Copyright © 2018年 ac hu. All rights reserved.
//

#import "AutoCode.h"
#import <objc/runtime.h>

@interface AutoCode()

@end
@implementation AutoCode

//归档时
-(void)encodeWithCoder:(NSCoder *)aCoder{
    //runtime获取所有实例变量
    //遍历
    //kvc
    //编码
    
    unsigned count = 0;//需要传个指针过去
    Ivar *ivarList = class_copyIvarList([self class], &count);//runtime获取所有实例变量
    for (int i = 0; i < count; i ++) {//遍历
        Ivar ivar = ivarList[i];
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];//kvc
        [aCoder encodeObject:value forKey:key];//编码
    }
    free(ivarList);
}

//解档
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    //runtime获取所有实例变量
    //遍历
    //解码
    //kvc
    unsigned count = 0;//需要传个指针过去
    Ivar *ivarList = class_copyIvarList([self class], &count);//runtime获取所有实例变量
    
    for (int i = 0; i < count; i ++) {//遍历
        Ivar ivar = ivarList[i];
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        NSString *str = [aDecoder decodeObjectForKey:key];//解码
        [self setName:str];//kvc
    }
    free(ivarList);
    return self;
}

@end
