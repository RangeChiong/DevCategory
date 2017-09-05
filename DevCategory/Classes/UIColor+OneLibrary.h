//
//  UIColor+OneLibrary.h
//  Zeughaus
//
//  Created by Ranger on 16/4/27.
//  Copyright © 2016年 常小哲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (OneLibrary)

@property (nonatomic, readonly, class) UIColor *ol_randomColor;

+ (UIColor *)ol_colorWithHex:(NSString *)hex;
+ (UIColor *)ol_colorWithHex: (NSString *)hex alpha:(CGFloat)alpha;

- (BOOL)ol_isEqualToColor:(UIColor *)otherColor;

@end
