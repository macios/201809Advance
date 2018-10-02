//
//  Person.h
//  引用计数-进阶
//
//  Created by ac-hu on 2018/10/2.
//  Copyright © 2018年 sk-hu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
-(void)setFront:(BOOL)front;
-(BOOL)front;
-(void)setBack:(BOOL)back;
-(BOOL)back;
@end
