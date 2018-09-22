//
//  Person.h
//  runTime
//
//  Created by ac hu on 2018/6/17.
//  Copyright © 2018年 ac hu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    perSonTypeOne = 0,
    perSonTypeTwo
}perSonType;

@interface Person : NSObject

@property(nonatomic,copy)NSString *name;


/**
 aa

 @param message aa
 */
-(void)sendMessage:(NSString *)message;
@end
