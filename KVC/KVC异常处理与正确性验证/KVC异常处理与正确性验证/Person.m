//
//  Person.m
//  KVC异常处理与正确性验证
//
//  Created by ac-hu on 2018/9/24.
//  Copyright © 2018年 ac-hu. All rights reserved.
//

#import "Person.h"

@implementation Person
-(void)setNilValueForKey:(NSString *)key{
    NSLog(@"%@不能为空",key);
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"赋值：%@不存在",key);
}

-(id)valueForUndefinedKey:(NSString *)key{
    NSLog(@"取值：%@不存在",key);
    return nil;
}
@end
