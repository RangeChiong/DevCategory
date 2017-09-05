//
//  NSDictionary+OneLibrary.h
//  RWKit
//
//  Created by Ranger on 16/5/5.
//  Copyright © 2016年 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary<ObjectType, KeyType> (OneLibrary)

/** 快速遍历 */
- (void)ol_each:(BOOL (^)(KeyType<NSCopying> key, ObjectType obj))block;

/** 无序遍历 速度up */
- (void)ol_apply:(BOOL (^)(KeyType<NSCopying> key, ObjectType obj))block;

/** 匹配一个需要的对象，返回nil或者匹配到的对象 */
- (nullable id)ol_match:(BOOL (^)(KeyType<NSCopying> key, ObjectType obj))block;

/** 匹配多个对象，将满足条件的对象返回成一个新的字典 */
- (NSDictionary *)ol_select:(BOOL (^)(KeyType<NSCopying> key, ObjectType obj))block;

/** 遍历字典，将每个对象处理后返回成一个新的字典 */
- (NSDictionary *)ol_map:(id (^)(KeyType<NSCopying> key, ObjectType obj))block;

@end

NS_ASSUME_NONNULL_END
