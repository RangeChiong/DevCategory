//
//  UIAlertView+CallBack.m
//  MyAlertView
//
//  Created by RPIOS on 15/7/28.
//  Copyright (c) 2015年 Ranger. All rights reserved.
//

#import "UIAlertView+CallBack.h"
#import <objc/runtime.h>

@interface UIAlertView ()<UIAlertViewDelegate>
@end

@implementation UIAlertView (CallBack)

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    !self.zy_clickButtonIndexBlock ?: self.zy_clickButtonIndexBlock(buttonIndex);
}

- (void (^)(NSUInteger))zy_clickButtonIndexBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setZy_clickButtonIndexBlock:(void (^)(NSUInteger))clickButtonIndexBlock {
    self.delegate = self;
    objc_setAssociatedObject(self, @selector(zy_clickButtonIndexBlock), clickButtonIndexBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
