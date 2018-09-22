//
//  Person.m
//  Runtime原理
//
//  Created by ac-hu on 2018/9/22.
//  Copyright © 2018年 ac-hu. All rights reserved.
//

#import "Person.h"

@implementation Person
-(void)walk{
    NSLog(@"%s",__func__);
}
+(void)run{
    NSLog(@"%s",__func__);
}
@end
