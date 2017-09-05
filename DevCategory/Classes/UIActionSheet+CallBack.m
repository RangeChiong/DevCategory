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
    !self.ol_clickButtonIndexBlock ?: self.ol_clickButtonIndexBlock(buttonIndex);
}

- (void (^)(NSUInteger))ol_clickButtonIndexBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setOl_clickButtonIndexBlock:(void (^)(NSUInteger))clickButtonIndexBlock {
    self.delegate = self;
    objc_setAssociatedObject(self, @selector(ol_clickButtonIndexBlock), clickButtonIndexBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
