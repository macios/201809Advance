//
//  ViewController.m
//  runTime
//
//  Created by ac hu on 2018/6/17.
//  Copyright © 2018年 ac hu. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Job.h"
#import "AutoCode.h"
#import "UIButton+State.h"

#import "NSObject+MyKVO.h"
#import "HuTimer.h"

#import <objc/runtime.h>

@interface ViewController ()
@property(nonatomic,strong)Person *person;
@property(nonatomic,strong)HuTimer *weekTimer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Person *per = [Person new];
    //模拟消息转发机制
    //1.动态方法解析
    //2.找备用接收者
    //3.1方法签名 3.2消息转发
    //4消息最终没有处理
    [per sendMessage:@"dd"];
    
    //自定义解决timer解决循环引用 self>timer>self
    _weekTimer = [HuTimer timerWithTimeInterval:1 target:self selector:@selector(timerMethod) userInfo:nil repeats:YES runloopMode:NSDefaultRunLoopMode];
//    [_weekTimer fire];
    
    //利用消息转发模拟多继承
    Job *job = [Job new];
    [job buyApple];
    [job buyWater];
    
    //消息拦截/交换
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    //拓展已有类的属性<这里做了个伪属性>
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 60, 100, 30);
    btn.title = @"小明";
    btn.highBackColor = [UIColor redColor];
    btn.textColor = [UIColor whiteColor];
    btn.font = 16.f;
    [self.view addSubview:btn];
    NSLog(@"%f",btn.font);
    
    //自动化归解档
    AutoCode *code = [AutoCode new];
    code.name = @"xiaoHong";
    NSString *path = [NSString stringWithFormat:@"%@/auto.plist",NSHomeDirectory()];
    [NSKeyedArchiver archiveRootObject:code toFile:path];
    
    //模拟kvo
    self.person = [Person new];
//    [_person addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];//会新注册NSKVONotifying_Person会变成Person的子类
    [_person my_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    _person.name = @"小米";
    NSLog(@"已注册的类有%@",[ViewController findSubClass:[_person class]]);
    perSonType one = 1;
}

+(NSArray *)findSubClass:(Class)defClass{
    //注册类的总数
    int count = objc_getClassList(NULL, 0);
    //获取所有已注册类
    Class *classList = (Class *)malloc(sizeof(Class)*count);
    objc_getClassList(classList, count);
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    
    for (int i = 0; i < count; i ++) {
        if (defClass == class_getSuperclass(classList[i])) {
            [array addObject:classList[i]];
        }
    }
    free(classList);
    return [array copy];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"值发生了变化%@",change);
}

-(void)timerMethod{
    NSLog(@"timer在运行");
}

-(void)dealloc{
    [_person removeObserver:self forKeyPath:@"name"];
    [self.weekTimer invalidate];
    self.weekTimer = nil;
}
@end
