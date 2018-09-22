//
//  NSObject+MyKVO.h
//  runTime
//
//  Created by ac hu on 2018/6/17.
//  Copyright © 2018年 ac hu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MyKVO)
- (void)my_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;
@end
