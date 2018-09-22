//
//  Job.h
//  runTime
//
//  Created by ac hu on 2018/6/17.
//  Copyright © 2018年 ac hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JobTwo.h"
#import "JobOne.h"

//NSProxy 抽象类虚类 不代构造方法更轻量级
@interface Job : NSObject <JobOneProtocol,JobTwoProtocol>
-(instancetype)init;
@end
