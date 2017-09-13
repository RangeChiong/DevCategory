//
//  UIColor+OneLibrary.h
//  Zeughaus
//
//  Created by Ranger on 16/4/27.
//  Copyright © 2016年 常小哲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (OneLibrary)

@property (nonatomic, readonly, class) UIColor *zy_randomColor;

+ (UIColor *)zy_colorWithHex:(NSString *)hex;
+ (UIColor *)zy_colorWithHex: (NSString *)hex alpha:(CGFloat)alpha;

- (BOOL)zy_isEqualToColor:(UIColor *)otherColor;

@end
