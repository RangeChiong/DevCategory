//
//  UIControl+OneLibrary.h
//  Test0707
//
//  Created by RangerChiong on 2017/7/7.
//  Copyright © 2017年 Ranger. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (OneLibrary)

- (void)zy_actionForControlEvents:(UIControlEvents)controlEvents usingBlock:(void (^)(id sender))block;

@end

NS_ASSUME_NONNULL_END
