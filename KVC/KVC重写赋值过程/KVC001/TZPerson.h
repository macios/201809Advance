//
//  TZPerson.h
//  KVC001
//
//  Created by hzg on 2018/9/14.
//  Copyright © 2018年 tz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TZDog : NSObject

@property (nonatomic, strong) NSString* name;

@end

@interface TZPerson : NSObject {
    @public
  //  NSString* _name;
    NSString* _isName;
    NSString* name;
    NSString* isName;
}

@property (nonatomic, strong) TZDog* dog;

@end
