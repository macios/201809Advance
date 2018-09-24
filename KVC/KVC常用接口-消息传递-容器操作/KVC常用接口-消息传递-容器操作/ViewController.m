//
//  ViewController.m
//  KVC常用接口-消息传递-容器操作
//
//  Created by ac-hu on 2018/9/24.
//  Copyright © 2018年 ac-hu. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //字典接口：批量赋值取值
    [self kvcDic];
    
    //消息传递-数组的操作
    [self kvcArr];
    
    //kvc容器操作
    [self kvcContainer];
}

//字典接口：批量赋值取值
-(void)kvcDic{
//    两个
//    取值- (NSDictionary<NSString *, id> *)dictionaryWithValuesForKeys:(NSArray<NSString *> *)keys;
//    设值- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *, id> *)keyedValues;
    Person *p = [Person new];
    NSDictionary *dic = @{@"name":@"小明",
                          @"age":@(10)
                          };
    [p setValuesForKeysWithDictionary:dic];
    NSLog(@"name = %@   age = %d",p.name,p.age);
    
    NSArray *keys = @[@"name",@"age"];
    dic = [p dictionaryWithValuesForKeys:keys];
    NSLog(@"dic = %@",dic);
}

//消息传递-数组的操作
- (void)kvcArr {
    NSArray *arr = @[@"1",@"22"];
    //所有成员的属性
    NSArray *lengthArr = [arr valueForKey:@"length"];
    NSLog(@"数组成员长度为：%@",lengthArr);
    
    Person *p = [Person new];
    p.name = @"小明";
    Person *p1 = [Person new];
    p1.name = @"小红";
    arr = @[p,p1];
    NSArray *nameArr = [arr valueForKey:@"name"];
    NSLog(@"数组成员名字为：%@",nameArr);
}

//kvc容器操作
-(void)kvcContainer{
//    1.聚合操作符；@avg、@count、@max、@min、@sum
    NSMutableArray *muArr = @[].mutableCopy;
    for (int i = 1; i <= 10; i ++) {
        Person *p = [Person new];
        p.age = i;
        [muArr addObject:p];
    }
    NSLog(@"集合的平均值为%f",[[muArr valueForKeyPath:@"@avg.age"] floatValue]);
    
//    2.数组操作符；
    //数组去重，无序
    NSArray *arr = [muArr valueForKeyPath:@"@distinctUnionOfObjects.age"];
    NSLog(@"数组去重：%@",arr);
    //数组不去重，无序
    arr = [muArr valueForKeyPath:@"@unionOfObjects.age"];
    NSLog(@"数组不去重：%@",arr);
    
//    3.嵌套集合（array&set）@distinctUnionOfArrays(去重)、@unionOfArrays（不去重）、@distinctUnionOfSets
    
    NSMutableArray *mu1Arr = @[].mutableCopy;
    for (int i = 1; i <= 10; i ++) {
        Person *p = [Person new];
        p.age = i;
        [mu1Arr addObject:p];
    }
    NSArray *testArr = @[muArr,mu1Arr];
    arr = [testArr valueForKeyPath:@"@distinctUnionOfArrays.age"];
    NSLog(@"嵌套数组测试：%@",arr);
    
    //会自动去重
    NSMutableSet *muSet = [NSMutableSet set];
    for (int i = 1; i <= 10; i ++) {
        Person *p = [Person new];
        p.age = i;
        [muSet addObject:p];
    }
    NSMutableSet *mu1Set = [NSMutableSet set];
    for (int i = 1; i <= 10; i ++) {
        Person *p = [Person new];
        p.age = i;
        [mu1Set addObject:p];
    }
    
    NSLog(@"set平局值：%f",[[muSet valueForKeyPath:@"@avg.age"] floatValue]);
    
    NSSet *testSet = [NSSet setWithObjects:muSet,mu1Set, nil];
    arr = [testSet valueForKeyPath:@"@distinctUnionOfSets.age"];
    NSLog(@"嵌套set测试：%@",arr);
}
@end
