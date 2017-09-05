//
//  UIView+OneLibrary.m
//  OneLibrary
//
//  Created by RangerChiong on 2017/6/5.
//  Copyright © 2017年 Ranger. All rights reserved.
//

#import "UIView+OneLibrary.h"
@import ObjectiveC.runtime;

@implementation UIView (OneLibrary)

+ (instancetype)ol_viewFromXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

- (UIViewController *)ol_viewController {
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (UIImage *)ol_snapshot {
    UIGraphicsBeginImageContextWithOptions(self.frame.size, YES, [[UIScreen mainScreen] scale]);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshot;
}

- (UIImage *)ol_contentImage {
    return [UIImage imageWithCGImage:(__bridge CGImageRef)self.layer.contents];
}

- (void)setOl_contentImage:(UIImage *)contentImage {
    self.layer.contents = (__bridge id)contentImage.CGImage;;
}

- (void)ol_removeAllSubviews {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)ol_eachSubview:(void (^)(UIView *subview))block {
    NSParameterAssert(block != nil);
    
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
        block(subview);
    }];
}

- (void)ol_limitUserInteractionEnabled {
    [self ol_limitUserInteractionEnabledWithTimeInterval:0.5];
}

- (void)ol_limitUserInteractionEnabledWithTimeInterval:(NSTimeInterval)ti {
    self.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(ti * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.userInteractionEnabled = YES;
    });
}

@end


@implementation UIView (EasyShow)

- (void)setOl_x:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)ol_x {
    return self.frame.origin.x;
}

- (void)setOl_left:(CGFloat)x {
    [self setOl_x:x];
}

- (CGFloat)ol_left {
    return self.frame.origin.x;
}

- (void)setOl_maxX:(CGFloat)maxX {
    self.ol_x = maxX - self.ol_width;
}

- (CGFloat)ol_maxX {
    return CGRectGetMaxX(self.frame);
}

- (void)setOl_right:(CGFloat)maxX {
    [self setOl_maxX:maxX];
}

- (CGFloat)ol_right {
    return CGRectGetMaxX(self.frame);
}

- (void)setOl_maxY:(CGFloat)maxY {
    self.ol_y = maxY - self.ol_height;
}

- (CGFloat)ol_maxY {
    return CGRectGetMaxY(self.frame);
}

- (void)setOl_bottom:(CGFloat)maxY {
    [self setOl_maxX:maxY];
}

- (CGFloat)ol_bottom {
    return CGRectGetMaxY(self.frame);
}

- (void)setOl_y:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)ol_y {
    return self.frame.origin.y;
}

- (void)setOl_top:(CGFloat)y {
    [self setOl_y:y];
}

- (CGFloat)ol_top {
    return self.frame.origin.y;
}

- (void)setOl_centerX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)ol_centerX {
    return self.center.x;
}

- (void)setOl_centerY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)ol_centerY {
    return self.center.y;
}

- (void)setOl_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)ol_width {
    return self.frame.size.width;
}

- (void)setOl_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)ol_height {
    return self.frame.size.height;
}

- (CGPoint)ol_origin {
    return self.frame.origin;
}

- (void)setOl_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (void)setOl_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)ol_size {
    return self.frame.size;
}

- (void)setOl_cornerRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = radius > 0;
}

- (CGFloat)ol_cornerRadius {
    return self.layer.cornerRadius;
}

- (void)ol_round {
    [self setOl_cornerRadius:self.frame.size.height/2];
}

- (void)ol_shadowColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opcity radius:(CGFloat)radius {
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opcity;
    self.layer.shadowRadius = radius;
}

- (void)ol_borderWidth:(CGFloat)width color:(UIColor *)color {
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}

- (void)ol_setAnchorPoint:(CGPoint)anchorPoint {
    CGPoint oldOrigin = self.frame.origin;
    self.layer.anchorPoint = anchorPoint;
    CGPoint newOrigin = self.frame.origin;
    
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = newOrigin.y - oldOrigin.y;
    
    self.center = CGPointMake (self.center.x - transition.x, self.center.y - transition.y);
}

@end


#pragma mark-  Chain

@implementation UIView (Chain)

- (UIView *(^)(CGFloat))ol_setX {
    return ^UIView *(CGFloat x) {
        self.ol_x = x;
        return self;
    };
}

- (UIView *(^)(CGFloat))ol_setY {
    return ^UIView *(CGFloat y) {
        self.ol_y = y;
        return self;
    };
}

- (UIView *(^)(CGFloat))ol_setWidth {
    return ^UIView *(CGFloat w) {
        self.ol_width = w;
        return self;
    };
}

- (UIView *(^)(CGFloat))ol_setHeight {
    return ^UIView *(CGFloat h) {
        self.ol_height = h;
        return self;
    };
}

- (UIView *(^)(UIView *))ol_add {
    return ^UIView *(UIView *childView) {
        [self addSubview:childView];
        return self;
    };
}

- (UIView *(^)(UIView *))ol_addTo {
    return ^UIView *(UIView *superView) {
        [superView addSubview:self];
        return self;
    };
}

- (UIView *(^)(BOOL))ol_setHidden {
    return ^UIView *(BOOL hidden) {
        self.hidden = hidden;
        return self;
    };
}

- (UIView * (^)())ol_setRound {
    return ^UIView * {
        [self ol_round];
        return self;
    };
}

- (UIView *(^)(CGFloat))ol_setBorderWidth {
    return ^UIView *(CGFloat width) {
        self.layer.borderWidth = width;
        return self;
    };
}

- (UIView *(^)(UIColor *))ol_setBorderColor {
    return ^UIView *(UIColor *color) {
        self.layer.borderColor = color.CGColor;
        return self;
    };
}

- (UIView *(^)(UIColor *))ol_setShadowColor {
    return ^UIView *(UIColor *color) {
        self.layer.shadowColor = color.CGColor;
        return self;
    };
}

- (UIView *(^)(CGSize))ol_setShadowOffset {
    return ^UIView *(CGSize offset) {
        self.layer.shadowOffset = offset;
        return self;
    };
}

- (UIView *(^)(CGFloat))ol_setShadowOpacity {
    return ^UIView *(CGFloat opacity) {
        self.layer.shadowOpacity = opacity;
        return self;
    };
}

- (UIView *(^)(CGFloat))ol_setShadowRadius {
    return ^UIView *(CGFloat radius) {
        self.layer.shadowRadius = radius;
        return self;
    };
}

@end

#pragma mark-  Gesture

@interface UIView (__OLGestureBlockPrivate)

@property (nonatomic, copy) void (^ol_handler)(UITapGestureRecognizer *tap);

@end

@implementation UIView (GestureBlock)

#pragma mark-  添加 tap 手势

- (UITapGestureRecognizer *)ol_tapWithTarget:(id)target action:(SEL)aSelector {
    NSAssert([target respondsToSelector:aSelector], @"selector & target 必须存在");
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:aSelector];
    [self addGestureRecognizer:tap];
    return tap;
}

- (void)ol_tapWithHandler:(void (^)(UITapGestureRecognizer *tap))handler {
    NSAssert(handler, @"handler 不能为nil");
    self.ol_handler = handler;
    
    [self ol_tapWithTarget:self action:@selector(__ol_handlerTapAction:)];
}

#pragma mark-  private methods

- (void)__ol_handlerTapAction:(UITapGestureRecognizer *)sender {
    self.ol_handler(sender);
}

#pragma mark-  setter && getter

- (void)setOl_handler:(void (^)(UITapGestureRecognizer *))ol_handler {
    objc_setAssociatedObject(self, @selector(ol_handler), ol_handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UITapGestureRecognizer *))ol_handler {
    return objc_getAssociatedObject(self, _cmd);
}

@end

