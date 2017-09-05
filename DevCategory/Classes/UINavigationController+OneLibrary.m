//
//  UINavigationController+OneLibrary.m
//  findproperty
//
//  Created by 常小哲 on 17/2/8.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "UINavigationController+OneLibrary.h"

@implementation UINavigationController (OneLibrary)

- (void)ol_disableEdgePanGestureRecoginzer:(BOOL)enable {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = enable;
    }
}

@end
