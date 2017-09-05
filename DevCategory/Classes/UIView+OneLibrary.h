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

@property (nonatomic, strong, readonly, class) __kindof UIView * ol_viewFromXib;
@property (nonatomic, strong, readonly) __kindof UIViewController *ol_viewController;
@property (nonatomic, strong, readonly) UIImage *ol_snapshot;

@property (nonatomic, strong) UIImage *ol_contentImage;

- (void)ol_removeAllSubviews;

/** 遍历子视图 */
- (void)ol_eachSubview:(void (^)(UIView *subview))block;

/** 限制view的连续点击 默认为0.5秒间隔 */
- (void)ol_limitUserInteractionEnabled;

/** 限制view的连续点击 自定义时间间隔 */
- (void)ol_limitUserInteractionEnabledWithTimeInterval:(NSTimeInterval)ti;

@end


@interface UIView (EasyShow)

@property (nonatomic, assign, getter = ol_left,   setter = setOl_left:)  CGFloat ol_x;
@property (nonatomic, assign, getter = ol_top,    setter = setOl_top:)   CGFloat ol_y;
@property (nonatomic, assign, getter = ol_right,  setter = setOl_right:) CGFloat ol_maxX;
@property (nonatomic, assign, getter = ol_bottom, setter = setOl_bottom:)CGFloat ol_maxY;
@property (nonatomic, assign) CGFloat ol_centerX;
@property (nonatomic, assign) CGFloat ol_centerY;
@property (nonatomic, assign) CGFloat ol_width;
@property (nonatomic, assign) CGFloat ol_height;
@property (nonatomic, assign) CGSize  ol_size;
@property (nonatomic, assign) CGPoint ol_origin;
@property (nonatomic, assign) CGFloat ol_cornerRadius;     //!< 圆角半径

- (void)ol_round;  //!< 圆形view
- (void)ol_shadowColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opcity radius:(CGFloat)radius;
- (void)ol_borderWidth:(CGFloat)width color:(UIColor *)color;

// 改变layer的锚点 保持位置不变 PS:切记在动画处理结束后 将锚点复原至CGPointMake(0.5f, 0.5f);
- (void)ol_setAnchorPoint:(CGPoint)anchorPoint;

@end

@interface UIView (Chain)

@property (nonatomic, copy, readonly) UIView *(^ol_setX)(CGFloat x);
@property (nonatomic, copy, readonly) UIView *(^ol_setY)(CGFloat y);
@property (nonatomic, copy, readonly) UIView *(^ol_setWidth)(CGFloat w);
@property (nonatomic, copy, readonly) UIView *(^ol_setHeight)(CGFloat h);

@property (nonatomic, copy, readonly) UIView *(^ol_add)(UIView *childView);
@property (nonatomic, copy, readonly) UIView *(^ol_addTo)(UIView *superView);
@property (nonatomic, copy, readonly) UIView *(^ol_setHidden)(BOOL hidden);

@property (nonatomic, copy, readonly) UIView *(^ol_setRound)();
@property (nonatomic, copy, readonly) UIView *(^ol_setBorderWidth)(CGFloat w);
@property (nonatomic, copy, readonly) UIView *(^ol_setBorderColor)(UIColor *color);
@property (nonatomic, copy, readonly) UIView *(^ol_setShadowColor)(UIColor *color);
@property (nonatomic, copy, readonly) UIView *(^ol_setShadowOffset)(CGSize offset);
@property (nonatomic, copy, readonly) UIView *(^ol_setShadowOpacity)(CGFloat opacity);
@property (nonatomic, copy, readonly) UIView *(^ol_setShadowRadius)(CGFloat radius);

@end

#pragma mark-  Gesture

@interface UIView (GestureBlock)

/** 添加tap手势，手势触发后方法 */
- (UITapGestureRecognizer *)ol_tapWithTarget:(id)target action:(SEL)aSelector;

/** 添加tap手势， 触发后在block中执行处理 */
- (void)ol_tapWithHandler:(void (^)(UITapGestureRecognizer *tap))handler;

@end

NS_ASSUME_NONNULL_END
