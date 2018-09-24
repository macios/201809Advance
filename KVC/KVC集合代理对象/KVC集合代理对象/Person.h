//
//  Person.h
//  KVC集合代理对象
//
//  Created by ac-hu on 2018/9/24.
//  Copyright © 2018年 ac-hu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property(nonatomic,assign)int age;
@property(nonatomic,assign)NSInteger count;

@property(nonatomic,strong)NSArray *penArr;
@end
