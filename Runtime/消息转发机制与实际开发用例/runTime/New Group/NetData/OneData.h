//
//  OneData.h
//  runTime
//
//  Created by ac hu on 2018/6/24.
//  Copyright © 2018年 ac hu. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "BaseModel.h"

typedef void(^successBlock)(id data);
typedef void(^failBlock)(NSString *errorStr,NSInteger code);

@interface OneData : NSObject

//如果只是传基础参数的时候就调用这个方法
+(void)getDataSuccess:(successBlock)success fail:(failBlock)fail;

//如果需要传基础参数的时候就调用这个方法
+(void)getDataIdID:(id)data Success:(successBlock)success fail:(failBlock)fail;


+(NSDictionary *)modelToDic:(id)data;
@end
