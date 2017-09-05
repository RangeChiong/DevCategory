//
//  UIButton+OneLibrary.h
//  Zeughaus
//
//  Created by 常小哲 on 16/4/23.
//  Copyright © 2016年 常小哲. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (OneLibrary)

- (void)ol_setNormalTitle:(NSString *)title;
- (void)ol_setNormalTitleColor:(UIColor *)titleColor;
- (void)ol_setNormalTitle:(NSString *)title titleColor:(nullable UIColor *)titleColor;

- (void)ol_setSelectedTitle:(NSString *)title;
- (void)ol_setSelectedTitleColor:(UIColor *)titleColor;
- (void)ol_setSelectedTitle:(NSString *)title titleColor:(nullable UIColor *)titleColor;
//
//- (void)ol_addTarget:(id)target action:(SEL)action;
//- (void)ol_actionForTouchUpInsideUsingBlock:(void (^)(UIButton *sender))block;
//- (void)ol_actionForControlEvents:(UIControlEvents)controlEvents usingBlock:(void (^)(UIButton *sender))block;

- (void)ol_startCountdown:(NSInteger)time timing:(void (^)(NSString *strTime))timing timeout:(dispatch_block_t)tiOut;

@end

NS_ASSUME_NONNULL_END
