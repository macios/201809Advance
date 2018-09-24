//
//  NSObject+KVC.h
//  KVC001
//
//  Created by hzg on 2018/9/14.
//  Copyright © 2018年 tz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KVC)

- (void)tz_setValue:(nullable id)value forKey:(NSString *)key;

@end
