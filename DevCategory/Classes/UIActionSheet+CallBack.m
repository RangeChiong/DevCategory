//
//  UIActionSheet+CallBack.m
//  Agency
//
//  Created by RangerChiong on 2017/6/8.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import "UIActionSheet+CallBack.h"
#import <objc/runtime.h>

@interface UIActionSheet ()<UIActionSheetDelegate>
@end

@implementation UIActionSheet (CallBack)

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
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
