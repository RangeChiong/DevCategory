//
//  UIButton+OneLibrary.m
//  Zeughaus
//
//  Created by 常小哲 on 16/4/23.
//  Copyright © 2016年 常小哲. All rights reserved.
//

#import "UIButton+OneLibrary.h"
//@import ObjectiveC;

//static const void *OLButtonActionBlock = &OLButtonActionBlock;

//@interface UIButton (__OLButtonOneLibraryPrivate)
//
//@property (nonatomic, copy) void (^actionBlock)(UIButton *sender);
//
//@end

@implementation UIButton (OneLibrary)

- (void)ol_setNormalTitle:(NSString *)title {
    [self ol_setNormalTitle:title titleColor:nil];
}

- (void)ol_setNormalTitleColor:(UIColor *)titleColor {
    [self ol_setNormalTitle:@"" titleColor:titleColor];
}

- (void)ol_setNormalTitle:(NSString *)title titleColor:(UIColor *)titleColor {
    if (titleColor) {
        [self setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (title.length) {
        [self setTitle:title forState:UIControlStateNormal];
    }
}

- (void)ol_setSelectedTitle:(NSString *)title {
    [self ol_setSelectedTitle:title titleColor:nil];
}

- (void)ol_setSelectedTitleColor:(UIColor *)titleColor {
    [self ol_setSelectedTitle:@"" titleColor:titleColor];
}

- (void)ol_setSelectedTitle:(NSString *)title titleColor:(UIColor *)titleColor {
    if (titleColor) {
        [self setTitleColor:titleColor forState:UIControlStateSelected];
    }
    if (title.length) {
        [self setTitle:title forState:UIControlStateSelected];
    }
}

//- (void)ol_addTarget:(id)target action:(SEL)action {
//    NSAssert([target respondsToSelector:action], @"selector & action 必须存在");
//
//    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//}
//
//- (void)ol_actionForTouchUpInsideUsingBlock:(void (^)(UIButton *sender))block {
//    [self ol_actionForControlEvents:UIControlEventTouchUpInside usingBlock:block];
//}
//
//- (void)ol_actionForControlEvents:(UIControlEvents)controlEvents usingBlock:(void (^)(UIButton *sender))block {
//    NSAssert(block, @"block 不能为nil");
//
//    self.actionBlock = block;
//    [self addTarget:self action:@selector(pressButtonAction:) forControlEvents:controlEvents];
//}
//
//- (void)pressButtonAction:(UIButton *)sender {
//    self.actionBlock(sender);
//}

//- (void)setActionBlock:(void (^)(UIButton *sender))handler {
//    objc_setAssociatedObject(self, OLButtonActionBlock, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
//}
//
//- (void (^)(UIButton *sender))actionBlock {
//    return objc_getAssociatedObject(self, OLButtonActionBlock);
//}

- (void)ol_startCountdown:(NSInteger)time timing:(void (^)(NSString *strTime))timing timeout:(dispatch_block_t)tiOut {
    NSParameterAssert(timing);
    NSParameterAssert(tiOut);

    self.enabled = NO;
    
    __block NSInteger timeout = time; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(timer, ^{
        if (timeout <= 0) { //倒计时结束，关闭
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.enabled = YES;
                !tiOut ?: tiOut();
            });
        } else {
            NSInteger seconds = timeout / 1;
            NSString *strTime = [NSString stringWithFormat:@"%ld", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                timing(strTime);
            });
            
            timeout--;
        }
    });
    dispatch_resume(timer);
}

@end
