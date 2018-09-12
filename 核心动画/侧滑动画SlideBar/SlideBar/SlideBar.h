//
//  SlideBar.h
//  侧滑动画SlideBar
//
//  Created by ac-hu on 2018/9/10.
//  Copyright © 2018年 ac-hu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SlideBarDirectionLeft,
    SlideBarDirectionRight
} SlideBarDirection;

@interface SlideBar : UIView

@property(nonatomic,assign)CGFloat bgAlpha;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,copy)void (^menuClick)(NSInteger index);
@property(nonatomic,assign)SlideBarDirection direction;

- (instancetype)initWithBtnTitle:(NSArray *)btnTitles;
- (void)switchClick;
@end
