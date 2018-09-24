//
//  CorrectObj.m
//  KVC异常处理与正确性验证
//
//  Created by ac-hu on 2018/9/24.
//  Copyright © 2018年 ac-hu. All rights reserved.
//

#import "CorrectObj.h"

@implementation CorrectObj



-(BOOL)validateNum:(inout id  _Nullable __autoreleasing *)ioValue error:(out NSError * _Nullable __autoreleasing *)outError{
    NSNumber *value = (NSNumber *)*ioValue;
    NSLog(@"%d",[value intValue]);
    if ([value intValue] < 0) {
         NSLog(@"不符合赋值要求");
        return NO;
    }
    NSLog(@"赋值要求");
    return YES;
}
//-(BOOL)validateValue:(inout id  _Nullable __autoreleasing *)ioValue forKeyPath:(NSString *)inKeyPath error:(out NSError * _Nullable __autoreleasing *)outError{
//
//}

@end
