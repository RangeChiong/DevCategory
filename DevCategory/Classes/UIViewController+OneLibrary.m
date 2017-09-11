//
//  UIViewController+OneLibrary.m
//  OneLibrary
//
//  Created by 常小哲 on 17/7/4.
//  Copyright © 2017年 Ranger. All rights reserved.
//

#import "UIViewController+OneLibrary.h"

@implementation UIViewController (OneLibrary)

- (UIViewController *)zy_fromController {
    UIViewController *presentingController = self.presentingViewController;
    UINavigationController *navController = self.navigationController;
    if (navController) {
        NSArray *vcs = navController.viewControllers;
        NSUInteger index = [vcs indexOfObject:self];
        if (index == 0 || vcs.count < 2) {
            if (presentingController) return presentingController;
            return self;
        }
        return vcs[[vcs indexOfObject:self] - 1];
    }
    
    if (presentingController) return presentingController;
    NSLog(@"WARNING:如果是模态弹出至当前控制器，在iOS8之后，建议在viewWillAppear中执行");
    return self;
}

@end
