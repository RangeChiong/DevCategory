//
//  UIView+OneLibrary.h
//  OneLibrary
//
//  Created by RangerChiong on 2017/6/5.
//  Copyright © 2017年 Ranger. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (OneLibrary)

@property (nonatomic, strong, readonly, class) __kindof UIView * zy_viewFromXib;
@property (nonatomic, strong, readonly) __kindof UIViewController *zy_viewController;
@property (nonatomic, strong, readonly) UIImage *zy_snapshot;

@property (nonatomic, strong) UIImage *zy_contentImage;

- (void)zy_removeAllSubviews;

/** 遍历子视图 */
- (void)zy_eachSubview:(void (^)(UIView *subview))block;

/** 限制view的连续点击 默认为0.5秒间隔 */
- (void)zy_limitUserInteractionEnabled;

/** 限制view的连续点击 自定义时间间隔 */
- (void)zy_limitUserInteractionEnabledWithTimeInterval:(NSTimeInterval)ti;

@end


@interface UIView (EasyShow)

@property (nonatomic, assign, getter = zy_left,   setter = setZy_left:)  CGFloat zy_x;
@property (nonatomic, assign, getter = zy_top,    setter = setZy_top:)   CGFloat zy_y;
@property (nonatomic, assign, getter = zy_right,  setter = setZy_right:) CGFloat zy_maxX;
@property (nonatomic, assign, getter = zy_bottom, setter = setZy_bottom:)CGFloat zy_maxY;
@property (nonatomic, assign) CGFloat zy_centerX;
@property (nonatomic, assign) CGFloat zy_centerY;
@property (nonatomic, assign) CGFloat zy_width;
@property (nonatomic, assign) CGFloat zy_height;
@property (nonatomic, assign) CGSize  zy_size;
@property (nonatomic, assign) CGPoint zy_origin;
@property (nonatomic, assign) CGFloat zy_cornerRadius;     //!< 圆角半径

- (void)zy_round;  //!< 圆形view
- (void)zy_shadowColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opcity radius:(CGFloat)radius;
- (void)zy_borderWidth:(CGFloat)width color:(UIColor *)color;

// 改变layer的锚点 保持位置不变 PS:切记在动画处理结束后 将锚点复原至CGPointMake(0.5f, 0.5f);
- (void)zy_setAnchorPoint:(CGPoint)anchorPoint;

@end

@interface UIView (Chain)

@property (nonatomic, copy, readonly) UIView *(^zy_setX)(CGFloat x);
@property (nonatomic, copy, readonly) UIView *(^zy_setY)(CGFloat y);
@property (nonatomic, copy, readonly) UIView *(^zy_setWidth)(CGFloat w);
@property (nonatomic, copy, readonly) UIView *(^zy_setHeight)(CGFloat h);

@property (nonatomic, copy, readonly) UIView *(^zy_add)(UIView *childView);
@property (nonatomic, copy, readonly) UIView *(^zy_addTo)(UIView *superView);
@property (nonatomic, copy, readonly) UIView *(^zy_setHidden)(BOOL hidden);

@property (nonatomic, copy, readonly) UIView *(^zy_setRound)();
@property (nonatomic, copy, readonly) UIView *(^zy_setBorderWidth)(CGFloat w);
@property (nonatomic, copy, readonly) UIView *(^zy_setBorderColor)(UIColor *color);
@property (nonatomic, copy, readonly) UIView *(^zy_setShadowColor)(UIColor *color);
@property (nonatomic, copy, readonly) UIView *(^zy_setShadowOffset)(CGSize offset);
@property (nonatomic, copy, readonly) UIView *(^zy_setShadowOpacity)(CGFloat opacity);
@property (nonatomic, copy, readonly) UIView *(^zy_setShadowRadius)(CGFloat radius);

@end

#pragma mark-  Gesture

@interface UIView (GestureBlock)

/** 添加tap手势，手势触发后方法 */
- (UITapGestureRecognizer *)zy_tapWithTarget:(id)target action:(SEL)aSelector;

/** 添加tap手势， 触发后在block中执行处理 */
- (void)zy_tapWithHandler:(void (^)(UITapGestureRecognizer *tap))handler;

@end

NS_ASSUME_NONNULL_END
