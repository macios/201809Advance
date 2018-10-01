//
//  Person.m
//  KVO基本使用
//
//  Created by ac-hu on 2018/10/1.
//  Copyright © 2018年 sk-hu. All rights reserved.
//

#import "Person.h"

@implementation Person
-(NSString *)fullName{
    return [NSString stringWithFormat:@"%@%@",_fristName ? _fristName : @"",_lastName ? _lastName : @""];
}

//设置关联属性
+(NSSet<NSString *> *)keyPathsForValuesAffectingFullName{
    return [NSSet setWithObjects:@"fristName",@"lastName", nil];
}

//全局的依赖，需要判断key
//+(NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key{}

//管理key是否能被通知，默认yes
+(BOOL)automaticallyNotifiesObserversOfFullName{
    return YES;
}
@end
