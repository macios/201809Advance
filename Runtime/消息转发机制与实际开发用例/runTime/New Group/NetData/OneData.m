//
//  OneData.m
//  runTime
//
//  Created by ac hu on 2018/6/24.
//  Copyright © 2018年 ac hu. All rights reserved.
//

#import "OneData.h"
#import <objc/runtime.h>

@implementation OneData
+(void)getDataSuccess:(successBlock)success fail:(failBlock)fail{
    
}

+(void)getDataIdID:(id)data Success:(successBlock)success fail:(failBlock)fail{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([data isKindOfClass:[NSDictionary class]]) {
        [dic setValuesForKeysWithDictionary:dic];
    }else{
        unsigned count = 0;//需要传个指针过去
        Ivar *ivarList = class_copyIvarList([self class], &count);//runtime获取所有实例变量
        for (int i = 0; i < count; i ++) {//遍历
            Ivar ivar = ivarList[i];
            const char *name = ivar_getName(ivar);
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [data valueForKey:key];//kvc
            if (value) {
                [dic setObject:value forKey:key];
            }
        }
        free(ivarList);
    }
    NSLog(@"传入的参数为：%@",dic);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(1);
        NSArray *arr = @[@{@"name":@"小明"},@{@"name":@"小红"}];
        for (int i = 0; i < arr.count; i ++) {
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    });
    
    
}

+(NSDictionary *)modelToDic:(id)data{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned count = 0;//需要传个指针过去
    Ivar *ivarList = class_copyIvarList([data class], &count);//runtime获取所有实例变量
    for (int i = 0; i < count; i ++) {//遍历
        Ivar ivar = ivarList[i];
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [data valueForKey:key];//kvc
        if (value) {
            [dic setObject:value forKey:[key componentsSeparatedByString:@"_"].lastObject];
        }
    }
    free(ivarList);
    return [dic copy];
}


@end
