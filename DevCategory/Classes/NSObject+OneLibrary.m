//
//  NSObject+OneLibrary.m
//  RWKit
//
//  Created by Ranger on 16/5/6.
//  Copyright © 2016年 Centaline. All rights reserved.
//

#import "NSObject+OneLibrary.h"
@import ObjectiveC.runtime;
@import ObjectiveC.message;

@implementation NSObject (OneLibrary)

void zy_swizzleClassDealloc(Class class, void (^code)(__unsafe_unretained id object)) {
    
    SEL deallocSEL = sel_registerName("dealloc");
    
    __block void (*originalDealloc)(__unsafe_unretained id, SEL) = NULL;
    
    id swizzleDealloc = ^(__unsafe_unretained id object) {
        !code ?: code(object);
        
        if (originalDealloc == NULL) {
            struct objc_super superclazz = {
                .receiver = object,
                .super_class = class_getSuperclass(class)
            };
            
            void (*objc_msgSendSuperCasted)(void *, SEL) = (void *)objc_msgSendSuper;
            objc_msgSendSuperCasted(&superclazz, deallocSEL);
        } else {
            originalDealloc(object, deallocSEL);
        }
    };
    
    IMP swizzleDeallocIMP = imp_implementationWithBlock(swizzleDealloc);
    
    if (!class_addMethod(class, deallocSEL, swizzleDeallocIMP, "v@:")) {
        Method deallocMethod = class_getInstanceMethod(class, deallocSEL);
        originalDealloc = (void(*)(__unsafe_unretained id, SEL))method_getImplementation(deallocMethod);
        originalDealloc = (void(*)(__unsafe_unretained id, SEL))method_setImplementation(deallocMethod, swizzleDeallocIMP);
    }
}

@end


#pragma mark -  Associated Weak support

@interface __OLWeakAssociatedHelper : NSObject

@property (nonatomic, weak) id value;

@end

@implementation __OLWeakAssociatedHelper

@end

#pragma mark-  AssociatedObject

@implementation NSObject (AssociatedObject)

#pragma mark-  关联nonatomically, strong/retain对象

- (void)zy_associateValue:(id)value key:(const void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)zy_associateValue:(id)value key:(const void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark-  关联atomically, strong/retain对象

- (void)zy_atomicallyAssociateValue:(id)value key:(const void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN);
}

+ (void)zy_atomicallyAssociateValue:(id)value key:(const void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN);
}

#pragma mark-  关联nonatomically, copy对象

- (void)zy_associateCopyOfValue:(id)value key:(const void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

+ (void)zy_associateCopyOfValue:(id)value key:(const void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark-  关联atomically, copy对象

- (void)zy_atomicallyAssociateCopyOfValue:(id)value key:(const void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY);
}

+ (void)zy_atomicallyAssociateCopyOfValue:(id)value key:(const void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY);
}

#pragma mark-  关联weak对象

- (void)zy_weaklyAssociateValue:(__autoreleasing id)value key:(const void *)key {
    __OLWeakAssociatedHelper *assoc = objc_getAssociatedObject(self, key);
    if (!assoc) {
        assoc = [__OLWeakAssociatedHelper new];
        [self zy_associateValue:assoc key:key];
    }
    assoc.value = value;
}

+ (void)zy_weaklyAssociateValue:(__autoreleasing id)value key:(const void *)key{
    __OLWeakAssociatedHelper *assoc = objc_getAssociatedObject(self, key);
    if (!assoc) {
        assoc = [__OLWeakAssociatedHelper new];
        [self zy_associateValue:assoc key:key];
    }
    assoc.value = value;
}

#pragma mark-  获取关联对象

- (id)zy_associatedValueForKey:(const void *)key {
    id value = objc_getAssociatedObject(self, key);
    if (value && [value isKindOfClass:[__OLWeakAssociatedHelper class]]) {
        return [(__OLWeakAssociatedHelper *)value value];
    }
    return value;
}

+ (id)zy_associatedValueForKey:(const void *)key {
    id value = objc_getAssociatedObject(self, key);
    if (value && [value isKindOfClass:[__OLWeakAssociatedHelper class]]) {
        return [(__OLWeakAssociatedHelper *)value value];
    }
    return value;
}

#pragma mark-  remove 关联

- (void)zy_removeAllAssociatedObjects {
    objc_removeAssociatedObjects(self);
}

+ (void)zy_removeAllAssociatedObjects {
    objc_removeAssociatedObjects(self);
}

@end


#pragma mark-  KVO helper

@interface __OLKVOHelper : NSObject {
    @package
    __weak id       _target;        ///< 被观察的对象的值改变时后, target会调用响应方法
    __weak id       _sourceObject;  ///< 被观察的对象
    SEL             _selector;      ///< 被观察的对象的值改变时后的响应方法
    NSString        *_keyPath;      ///< 被观察的对象的keyPath

    void (^_block)(id newValue, id oldValue);        ///< 值改变时执行的block
}

@end

@implementation __OLKVOHelper

- (void)dealloc {
//    [_sourceObject removeObserver:self forKeyPath:_keyPath];
}

- (instancetype)initWithObject:(id)anObject keyPath:(NSString *)keyPath target:(id)target selector:(SEL)aSelector {
    if (self = [super init]) {
        _sourceObject = anObject;
        _keyPath      = keyPath;
        _target       = target;
        _selector     = aSelector;
        [_sourceObject addObserver:self
                        forKeyPath:keyPath
                           options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                           context:nil];
    }
    return self;
}

- (instancetype)initWithObject:(id)anObject keyPath:(NSString *)keyPath block:(void(^)(id newValue, id oldValue))block {
    if (self = [super init]) {
        _sourceObject = anObject;
        _keyPath      = keyPath;
        _block        = block;
        [_sourceObject addObserver:self
                        forKeyPath:keyPath
                           options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                           context:nil];
    }
    return self;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (_block)
        _block(change[NSKeyValueChangeNewKey], change[NSKeyValueChangeOldKey]);
        
    if ([_target respondsToSelector:_selector])
        [_target performSelector:_selector withObject:_sourceObject withObject:change];
}

#pragma clang diagnostic pop

@end


#pragma mark-  KVO

static const void *NSObject_Observers = &NSObject_Observers;

@interface NSObject (__KVOPrivate)

@property (nonatomic, strong) NSMutableDictionary<NSString *, __OLKVOHelper *> *kvoContainer;

@end

@implementation NSObject (KVO)

- (NSMutableDictionary *)kvoContainer {
    return objc_getAssociatedObject(self, NSObject_Observers) ?: ({
        NSMutableDictionary *dic = [NSMutableDictionary new];
        objc_setAssociatedObject(self, NSObject_Observers, dic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        dic;
    });
}

#pragma mark-  建立监听

- (void)zy_observeValueForKeyPath:(NSString *)keyPath target:(id)target selector:(SEL)aSelector {
    NSAssert([target respondsToSelector:aSelector], @"selector & target 必须存在");
    NSAssert(keyPath.length > 0, @"keyPath 不能为@\"\"");
    NSAssert(self, @"被观察的对象object不能为nil 必须存在");
    
    __OLKVOHelper *observer = [[__OLKVOHelper alloc] initWithObject:self
                                                            keyPath:keyPath
                                                             target:target
                                                           selector:aSelector];
    NSString *key = [NSString stringWithFormat:@"%p_%@", self, keyPath];
    self.kvoContainer[key] = observer;
    
    zy_swizzleClassDealloc(self.class, ^(__unsafe_unretained id object) {
        [object zy_removeAllObserver];
    });
}

- (void)zy_observeValueForKeyPath:(NSString *)keyPath block:(void(^)(id newValue, id oldValue))block {
    NSAssert(block, @"block 不能为nil");
    NSAssert(keyPath.length > 0, @"keyPath 不能为@\"\"");
    NSAssert(self, @"被观察的对象object 不能为nil 必须存在");

    __OLKVOHelper *observer = [[__OLKVOHelper alloc] initWithObject:self
                                                            keyPath:keyPath
                                                              block:block];
    NSString *key = [NSString stringWithFormat:@"%p_%@", self, keyPath];
    self.kvoContainer[key] = observer;
    
    zy_swizzleClassDealloc(self.class, ^(__unsafe_unretained id object) {
        [object zy_removeAllObserver];
    });
}

#pragma mark-  移除监听

- (void)zy_removeObserverForKeyPath:(NSString *)keyPath {
    NSAssert(self, @"被观察的对象object 不能为nil 必须存在");
    NSAssert(keyPath.length > 0, @"keyPath 不能为@\"\"");
    
    NSString *key = [NSString stringWithFormat:@"%p_%@", self, keyPath];
    [self removeObserver:self.kvoContainer[key] forKeyPath:keyPath];
    [self.kvoContainer removeObjectForKey:key];
}

- (void)zy_removeAllObserver {
    NSAssert(self, @"被观察的对象object 不能为nil 必须存在");
    NSString *prefix = [NSString stringWithFormat:@"%p", self];
    [self.kvoContainer enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, __OLKVOHelper * _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key hasPrefix:prefix]) {
            [self removeObserver:obj forKeyPath:[key componentsSeparatedByString:@"_"].lastObject];
        }
    }];
    [self.kvoContainer removeAllObjects];
}

@end


#pragma mark-  NotificationHelper

@interface __OLNotificationHelper : NSObject {
    @package
    __weak id       _notiTarget;        //!< 处理通知那个类的实例 用来调用接受通知后的方法
    id              _postNotiObject;    //!< 通知的来源 即谁发的通知 为nil时接受所有的通知
    SEL             _notiSelector;      //!< 接受到通知后调用的方法
    NSString        *_notiName;         //!< 通知的名字
    NSDictionary    *_userInfo;         //!< 通知传递的参数NSNotification的属性 类型为字典
    
    void(^_block)(NSNotification *noti);  //!< 传递参数的回调
}

@end

@implementation __OLNotificationHelper

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithName:(NSString *)aName target:(id)target selector:(SEL)aSelector object:(id)anObject {
    if (self = [super init]) {
        _notiTarget = target;
        _notiSelector = aSelector;
        _notiName = aName;
        _postNotiObject = anObject;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleNotification:)
                                                     name:aName
                                                   object:anObject];
    }
    return self;
}

- (instancetype)initWithName:(NSString *)aName object:(id)anObject block:(void(^)(NSNotification *noti))block {
    if (self = [super init]) {
        _notiName = aName;
        _postNotiObject = anObject;
        _block  = block;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleNotification:)
                                                     name:aName
                                                   object:anObject];
    }
    return self;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

- (void)handleNotification:(NSNotification *)notification {
    if (_block)
        _block(notification);
    
    if ([_notiTarget respondsToSelector:_notiSelector])
        [_notiTarget performSelector:_notiSelector withObject:notification];
}

#pragma clang diagnostic pop

@end


#pragma mark-  Notification

static const void *Notification_Container = &Notification_Container;

@interface NSObject (__NotificationPrivate)

@property (nonatomic, strong) NSMutableDictionary<NSString *, __OLNotificationHelper *> *notiContainer;

@end

@implementation NSObject (Notification)

- (NSMutableDictionary *)notiContainer {
    return objc_getAssociatedObject(self, Notification_Container) ?: ({
        NSMutableDictionary *dict = [NSMutableDictionary new];
        objc_setAssociatedObject(self, Notification_Container, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        dict;
    });
}

#pragma mark-  add observer of a notification

- (void)zy_observeNotification:(NSString *)aName block:(void(^)(NSNotification *noti))block {
    [self zy_observeNotification:aName object:nil block:block];
}

- (void)zy_observeNotification:(NSString *)aName object:(id)anObject block:(void(^)(NSNotification *noti))block {
    NSAssert(block, @"block 不能为nil");
    NSAssert(aName.length > 0, @"NotificationName 不能为@\"\"");
    
    __OLNotificationHelper *notification = [[__OLNotificationHelper alloc] initWithName:aName
                                                                                 object:anObject
                                                                                  block:block];
    NSString *key = [NSString stringWithFormat:@"%@", aName];
    self.notiContainer[key] = notification;

}

- (void)zy_observeNotification:(NSString *)aName target:(id)target selector:(SEL)aSelector {
    
    [self zy_observeNotification:aName target:target selector:aSelector object:nil];
}

- (void)zy_observeNotification:(NSString *)aName target:(id)target selector:(SEL)aSelector object:(id)anObject {
    NSAssert([target respondsToSelector:aSelector], @"selector & target 必须存在");
    NSAssert(aName.length > 0, @"NotificationName 不能为@\"\"");
    
    __OLNotificationHelper *notification = [[__OLNotificationHelper alloc] initWithName:aName
                                                                                 target:target
                                                                               selector:aSelector
                                                                                 object:anObject];
    
    NSString *key = [NSString stringWithFormat:@"%@", aName];
    self.notiContainer[key] = notification;
}

#pragma mark-  post notification

- (void)zy_postNotification:(NSString *)aName {
    [self zy_postNotification:aName object:nil userInfo:nil];
}

- (void)zy_postNotification:(NSString *)aName object:(id)anObject {
    [self zy_postNotification:aName object:anObject userInfo:nil];
}

- (void)zy_postNotification:(NSString *)aName userInfo:(NSDictionary *)aUserInfo {
    [self zy_postNotification:aName object:nil userInfo:aUserInfo];
}

- (void)zy_postNotification:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:aName object:anObject userInfo:aUserInfo];
    });
}

#pragma mark- remove notification

- (void)zy_removeNotification:(NSString *)aName {
    NSAssert(aName.length > 0, @"NotificationName 不能为@\"\"");
    
    [self.notiContainer removeObjectForKey:aName];
}

- (void)zy_removeAllNotification {
    [self.notiContainer removeAllObjects];
}

@end
