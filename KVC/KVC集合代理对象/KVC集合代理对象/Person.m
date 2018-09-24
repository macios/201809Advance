//
//  Person.m
//  KVC集合代理对象
//
//  Created by ac-hu on 2018/9/24.
//  Copyright © 2018年 ac-hu. All rights reserved.
//

#import "Person.h"

@implementation Person

//测试一对多1 - array对应两个方法
//Age对应的key值
//返回的个数
-(NSUInteger)countOfBooks{
    NSLog(@"Books方法1");
    return self.count;
}

-(id)objectInBooksAtIndex:(NSUInteger)index{
    NSLog(@"Books方法2");
    return [NSString stringWithFormat:@"Books=%lu",index];
}

//测试一对多2 - set对应3个方法
//返回的个数
-(NSUInteger)countOfPens{
    NSLog(@"Pens方法1");
    return self.penArr.count;
}

//是否包含这个成员
-(id)memberOfPens:(id)object{
    NSLog(@"Pens方法2");
    return [self.penArr containsObject:object] ? object : nil;
}

//迭代器-reverseObjectEnumerator倒序
-(NSEnumerator *)enumeratorOfPens{
    return [self.penArr reverseObjectEnumerator];
}
@end
