//
//  HuWeekProxy.h
//  runTime
//
//  Created by ac hu on 2018/6/18.
//  Copyright © 2018年 ac hu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HuWeekProxy : NSProxy

@property(nonatomic,weak)id target;

+(instancetype)weakWithTarget:(id)target;
-(instancetype)initWeakTarget:(id)target;

@end
