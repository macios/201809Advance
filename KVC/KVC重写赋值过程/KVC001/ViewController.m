//
//  ViewController.m
//  KVC001
//
//  Created by hzg on 2018/9/14.
//  Copyright © 2018年 tz. All rights reserved.
//

#import "ViewController.h"
#import "TZPerson.h"
#import "NSObject+KVC.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    TZPerson* p = [TZPerson new];
//    [p setValue:@"Tom" forKey:@"name"];
//    NSLog(@"%@", [p valueForKey:@"name"]);
//
//    [self.textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    
    TZPerson* p = [TZPerson new];
    
    //[p setValue:@"Tom" forKey:@"name"];
  //  NSLog(@"name = %@", [p valueForKey:@"name"]);
    
    [p tz_setValue:@"Tom" forKey:@"name"];

    NSLog(@"name = %@", [p valueForKeyPath:@"dog.name"]);
    NSLog(@"name = %@", p->name);
    //NSLog(@"_name = %@", p->_name);
    NSLog(@"isName = %@", p->isName);
    NSLog(@"_isName = %@", p->_isName);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
