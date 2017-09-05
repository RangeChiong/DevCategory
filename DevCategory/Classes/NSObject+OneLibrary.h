//
//  NSObject+OneLibrary.h
//  RWKit
//
//  Created by Ranger on 16/5/6.
//  Copyright © 2016年 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN void ol_swizzleClassDealloc(Class cls, void (^code)(__unsafe_unretained id object));

@interface NSObject (OneLibrary)

@end

#pragma mark-  AssociatedObject

@interface NSObject (AssociatedObject)

/** 关联对象 nonatomically, strong/retain  */
- (void)ol_associateValue:(nullable id)value key:(const void *)key;
/** 关联对象 nonatomically, strong/retain  */
+ (void)ol_associateValue:(nullable id)value key:(const void *)key;

/** 关联对象 atomically, strong/retain  */
- (void)ol_atomicallyAssociateValue:(nullable id)value key:(const void *)key;
/** 关联对象 atomically, strong/retain  */
+ (void)ol_atomicallyAssociateValue:(nullable id)value key:(const void *)key;

/** 关联对象 nonatomically, copy  */
- (void)ol_associateCopyOfValue:(nullable id)value key:(const void *)key;
/** 关联对象 nonatomically, copy  */
+ (void)ol_associateCopyOfValue:(nullable id)value key:(const void *)key;

/** 关联对象 atomically, copy  */
- (void)ol_atomicallyAssociateCopyOfValue:(nullable id)value key:(const void *)key;
/** 关联对象 atomically, copy  */
+ (void)ol_atomicallyAssociateCopyOfValue:(nullable id)value key:(const void *)key;

/** 关联对象 nonatomically, weak  */
- (void)ol_weaklyAssociateValue:(nullable __autoreleasing id)value key:(const void *)key;
/** 关联对象 nonatomically, weak  */
+ (void)ol_weaklyAssociateValue:(nullable __autoreleasing id)value key:(const void *)key;

/** 根据key获取关联对象  */
- (nullable id)ol_associatedValueForKey:(const void *)key;
/** 根据key获取关联对象  */
+ (nullable id)ol_associatedValueForKey:(const void *)key;

/** 关联对象 nonatomically, strong/retain  */
- (void)ol_removeAllAssociatedObjects;
/** 关联对象 nonatomically, strong/retain  */
+ (void)ol_removeAllAssociatedObjects;

@end


#pragma mark-  KVO

@interface NSObject (KVO)

/* 
 selector 需要在target中手动实现 形式为 - (void)xxxMethod:(id)anObject change:(id)change
 anObject 为被观察的对象
 change是一个字典
 */
- (void)ol_observeValueForKeyPath:(NSString *)keyPath target:(id)target selector:(SEL)aSelector;

/** 监听某个属性 block形式 */
- (void)ol_observeValueForKeyPath:(NSString *)keyPath block:(void(^)(id newValue, id oldValue))block;

/** 移除对某个的属性监听 */
- (void)ol_removeObserverForKeyPath:(NSString *)keyPath;

/** 移除所有的监听 */
- (void)ol_removeAllObserver;

@end


#pragma mark-  Notification

@interface NSObject (Notification)

/** 建立通知监听者 默认anObject为空 */
- (void)ol_observeNotification:(NSString *)aName block:(void(^)(NSNotification *noti))block;
/** 建立通知监听者 */
- (void)ol_observeNotification:(NSString *)aName object:(nullable id)anObject block:(void(^)(NSNotification *noti))block;

/** 建立通知监听者 默认anObject 为空 */
- (void)ol_observeNotification:(NSString *)aName target:(id)target selector:(SEL)aSelector;
/** 建立通知监听者 */
- (void)ol_observeNotification:(NSString *)aName target:(id)target selector:(SEL)aSelector object:(nullable id)anObject;

/** 发送通知 默认anObject, aUserInfo 为nil */
- (void)ol_postNotification:(NSString *)aName;
/** 发送通知 默认aUserInfo 为nil */
- (void)ol_postNotification:(NSString *)aName object:(nullable id)anObject;
/** 发送通知 默认anObject为nil*/
- (void)ol_postNotification:(NSString *)aName userInfo:(nullable NSDictionary *)aUserInfo;
/** 发送通知 */
- (void)ol_postNotification:(NSString *)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo;

/** 移除不要监听的通知 */
- (void)ol_removeNotification:(nullable NSString *)aName;
/** 移除全部通知 */
- (void)ol_removeAllNotification;

@end

NS_ASSUME_NONNULL_END
