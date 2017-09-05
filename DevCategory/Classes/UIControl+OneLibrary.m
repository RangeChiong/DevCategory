//
//  UIControl+OneLibrary.m
//  Test0707
//
//  Created by RangerChiong on 2017/7/7.
//  Copyright © 2017年 Ranger. All rights reserved.
//

#import "UIControl+OneLibrary.h"
@import ObjectiveC;

@interface UIControl (__OLControlOneLibraryPrivate)

@property (nonatomic, copy) void (^actionBlock)(id sender);

@end

@implementation UIControl (OneLibrary)

- (void)ol_actionForControlEvents:(UIControlEvents)controlEvents usingBlock:(void (^)(id sender))block {    
    self.actionBlock = block;
    [self addTarget:self action:@selector(__controlAction:) forControlEvents:controlEvents];

}

- (void)__controlAction:(UIButton *)sender {
    self.actionBlock(sender);
}

#pragma mark-   Setter & Getter

- (void)setActionBlock:(void (^)(UIButton *sender))handler {
    objc_setAssociatedObject(self, @selector(actionBlock), handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UIButton *sender))actionBlock {
    return objc_getAssociatedObject(self, _cmd);
}

@end
