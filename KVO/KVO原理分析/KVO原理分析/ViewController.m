//
//  ViewController.m
//  KVO基本使用
//
//  Created by ac-hu on 2018/10/1.
//  Copyright © 2018年 sk-hu. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>

@interface ViewController ()
@property(nonatomic,strong)Person *p;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    总结
//    1.注册子类并为其添加成员变量与方法；
//    2.查看观察堆栈信息执行过程；
//    3.执行移除，从栈里移除；
    _p = [Person new];
    Class class = NSClassFromString(@"NSKVONotifying_Person");
    if (class) {
        NSLog(@"添加观察者之前存在类");
    }else{
        NSLog(@"添加观察者之前不存在类");
    }
    
    [_p addObserver:self forKeyPath:@"fullName" options:NSKeyValueObservingOptionNew context:nil];
    
    //    断点打印会动态生成一个子类,动态生成方法，成员变量
    //    p _p->isa
    //    (Class) $0 = NSKVONotifying_Person
    class = NSClassFromString(@"NSKVONotifying_Person");
    if (class) {
        NSLog(@"添加观察者之后存在类");
    }else{
        NSLog(@"添加观察者之后不存在类");
    }
    NSLog(@"%@",[self printMethods:class]);
    NSLog(@"%@",[self printClasses:[Person class]]);
    

}

//遍历一个类的所有方法名
-(NSArray *)printMethods:(Class)class{
    unsigned int count = 0;
    Method *methods = class_copyMethodList(class, &count);
    NSMutableArray *methodArr = @[].mutableCopy;
    for (int i = 0; i < count; i ++) {
        Method method = methods[i];
        SEL sel = method_getName(method);
        NSString *methodName = NSStringFromSelector(sel);
        [methodArr addObject:methodName];
//        IMP imp = method_getImplementation(method);
    }
    free(methods);
    return methodArr.copy;
}

//遍历一个类及其子类
-(NSArray *)printClasses:(Class)class{
    unsigned int count = objc_getClassList(NULL, 0);
    NSMutableArray *classArr = @[class].mutableCopy;
    Class *classes = (Class *)malloc(sizeof(class)*count);
    objc_getClassList(classes, count);
    for (int i = 0; i < count; i ++) {
        if (class == class_getSuperclass(classes[i])) {
            [classArr addObject:classes[i]];
        }
    }
    free(classes);
    return classArr.copy;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"%@",[change objectForKey:NSKeyValueChangeNewKey]);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    static int index = 0;
    static int lastIndex = 0;
    //   断点打印 watchpoint set variable self->_p->_fristName会自动断点到值变化的地方,可以看堆栈信息执行过程
    _p.fristName = [NSString stringWithFormat:@"%d",lastIndex--];
    _p.lastName = [NSString stringWithFormat:@"%d",index ++];
    
}

-(void)dealloc{
    [_p removeObserver:self forKeyPath:@"fullName"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
