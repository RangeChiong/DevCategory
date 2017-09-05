//
//  UIView+OneLibrary.m
//  OneLibrary
//
//  Created by RangerChiong on 2017/6/5.
//  Copyright © 2017年 Ranger. All rights reserved.
//

#import "UIView+OneLibrary.h"
@import ObjectiveC.runtime;

_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wobjc-property-implementation\"")

@implementation UIView (OneLibrary)

+ (instancetype)zy_viewFromXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

- (UIViewController *)zy_viewController {
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (UIImage *)zy_snapshot {
    UIGraphicsBeginImageContextWithOptions(self.frame.size, YES, [[UIScreen mainScreen] scale]);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshot;
}

- (UIImage *)zy_contentImage {
    return [UIImage imageWithCGImage:(__bridge CGImageRef)self.layer.contents];
}

- (void)setZy_contentImage:(UIImage *)contentImage {
    self.layer.contents = (__bridge id)contentImage.CGImage;;
}

- (void)zy_removeAllSubviews {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)zy_eachSubview:(void (^)(UIView *subview))block {
    NSParameterAssert(block != nil);
    
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
        block(subview);
    }];
}

- (void)zy_limitUserInteractionEnabled {
    [self zy_limitUserInteractionEnabledWithTimeInterval:0.5];
}

- (void)zy_limitUserInteractionEnabledWithTimeInterval:(NSTimeInterval)ti {
    self.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(ti * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.userInteractionEnabled = YES;
    });
}

@end


@implementation UIView (EasyShow)

- (void)setZy_x:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)zy_x {
    return self.frame.origin.x;
}

- (void)setZy_left:(CGFloat)x {
    [self setZy_x:x];
}

- (CGFloat)zy_left {
    return self.frame.origin.x;
}

- (void)setZy_maxX:(CGFloat)maxX {
    self.zy_x = maxX - self.zy_width;
}

- (CGFloat)zy_maxX {
    return CGRectGetMaxX(self.frame);
}

- (void)setZy_right:(CGFloat)maxX {
    [self setZy_maxX:maxX];
}

- (CGFloat)zy_right {
    return CGRectGetMaxX(self.frame);
}

- (void)setZy_maxY:(CGFloat)maxY {
    self.zy_y = maxY - self.zy_height;
}

- (CGFloat)zy_maxY {
    return CGRectGetMaxY(self.frame);
}

- (void)setZy_bottom:(CGFloat)maxY {
    [self setZy_maxX:maxY];
}

- (CGFloat)zy_bottom {
    return CGRectGetMaxY(self.frame);
}

- (void)setZy_y:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)zy_y {
    return self.frame.origin.y;
}

- (void)setZy_top:(CGFloat)y {
    [self setZy_y:y];
}

- (CGFloat)zy_top {
    return self.frame.origin.y;
}

- (void)setZy_centerX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)zy_centerX {
    return self.center.x;
}

- (void)setZy_centerY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)zy_centerY {
    return self.center.y;
}

- (void)setZy_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)zy_width {
    return self.frame.size.width;
}

- (void)setZy_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)zy_height {
    return self.frame.size.height;
}

- (CGPoint)zy_origin {
    return self.frame.origin;
}

- (void)setZy_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (void)setZy_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)zy_size {
    return self.frame.size;
}

- (void)setZy_cornerRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = radius > 0;
}

- (CGFloat)zy_cornerRadius {
    return self.layer.cornerRadius;
}

- (void)zy_round {
    [self setZy_cornerRadius:self.frame.size.height/2];
}

- (void)zy_shadowColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opcity radius:(CGFloat)radius {
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opcity;
    self.layer.shadowRadius = radius;
}

- (void)zy_borderWidth:(CGFloat)width color:(UIColor *)color {
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}

- (void)zy_setAnchorPoint:(CGPoint)anchorPoint {
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

- (UIView *(^)(CGFloat))zy_setX {
    return ^UIView *(CGFloat x) {
        self.zy_x = x;
        return self;
    };
}

- (UIView *(^)(CGFloat))zy_setY {
    return ^UIView *(CGFloat y) {
        self.zy_y = y;
        return self;
    };
}

- (UIView *(^)(CGFloat))zy_setWidth {
    return ^UIView *(CGFloat w) {
        self.zy_width = w;
        return self;
    };
}

- (UIView *(^)(CGFloat))zy_setHeight {
    return ^UIView *(CGFloat h) {
        self.zy_height = h;
        return self;
    };
}

- (UIView *(^)(UIView *))zy_add {
    return ^UIView *(UIView *childView) {
        [self addSubview:childView];
        return self;
    };
}

- (UIView *(^)(UIView *))zy_addTo {
    return ^UIView *(UIView *superView) {
        [superView addSubview:self];
        return self;
    };
}

- (UIView *(^)(BOOL))zy_setHidden {
    return ^UIView *(BOOL hidden) {
        self.hidden = hidden;
        return self;
    };
}

- (UIView * (^)())zy_setRound {
    return ^UIView * {
        [self zy_round];
        return self;
    };
}

- (UIView *(^)(CGFloat))zy_setBorderWidth {
    return ^UIView *(CGFloat width) {
        self.layer.borderWidth = width;
        return self;
    };
}

- (UIView *(^)(UIColor *))zy_setBorderColor {
    return ^UIView *(UIColor *color) {
        self.layer.borderColor = color.CGColor;
        return self;
    };
}

- (UIView *(^)(UIColor *))zy_setShadowColor {
    return ^UIView *(UIColor *color) {
        self.layer.shadowColor = color.CGColor;
        return self;
    };
}

- (UIView *(^)(CGSize))zy_setShadowOffset {
    return ^UIView *(CGSize offset) {
        self.layer.shadowOffset = offset;
        return self;
    };
}

- (UIView *(^)(CGFloat))zy_setShadowOpacity {
    return ^UIView *(CGFloat opacity) {
        self.layer.shadowOpacity = opacity;
        return self;
    };
}

- (UIView *(^)(CGFloat))zy_setShadowRadius {
    return ^UIView *(CGFloat radius) {
        self.layer.shadowRadius = radius;
        return self;
    };
}

@end

#pragma mark-  Gesture

@interface UIView (__OLGestureBlockPrivate)

@property (nonatomic, copy) void (^zy_handler)(UITapGestureRecognizer *tap);

@end

@implementation UIView (GestureBlock)

#pragma mark-  添加 tap 手势

- (UITapGestureRecognizer *)zy_tapWithTarget:(id)target action:(SEL)aSelector {
    NSAssert([target respondsToSelector:aSelector], @"selector & target 必须存在");
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:aSelector];
    [self addGestureRecognizer:tap];
    return tap;
}

- (void)zy_tapWithHandler:(void (^)(UITapGestureRecognizer *tap))handler {
    NSAssert(handler, @"handler 不能为nil");
    self.zy_handler = handler;
    
    [self zy_tapWithTarget:self action:@selector(__zy_handlerTapAction:)];
}

#pragma mark-  private methods

- (void)__zy_handlerTapAction:(UITapGestureRecognizer *)sender {
    self.zy_handler(sender);
}

#pragma mark-  setter && getter

- (void)setZy_handler:(void (^)(UITapGestureRecognizer *))zy_handler {
    objc_setAssociatedObject(self, @selector(zy_handler), zy_handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UITapGestureRecognizer *))zy_handler {
    return objc_getAssociatedObject(self, _cmd);
}

@end

_Pragma("clang diagnostic pop") \
