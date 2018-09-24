//
//  TZPerson.m
//  KVC001
//
//  Created by hzg on 2018/9/14.
//  Copyright © 2018年 tz. All rights reserved.
//

#import "TZPerson.h"


@implementation TZDog
@end


@implementation TZPerson

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dog = [TZDog new];
    }
    return self;
}

//- (void) setName:(NSString*) name {
//    NSLog(@"%s", __func__);
//}

//- (void) _setName:(NSString*) name {
//    NSLog(@"%s", __func__);
//}
//
//- (void) setIsName:(NSString*) name {
//    NSLog(@"%s", __func__);
//}


//- (NSString*) getName {
//    NSLog(@"%s", __func__);
//    return @"getName";
//}

//- (NSString*) name {
//    return @"name";
//}

//+ (BOOL)accessInstanceVariablesDirectly {
//    return NO;
//}

@end
