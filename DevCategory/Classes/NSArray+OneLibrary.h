//
//  NSArray+OneLibrary.h
//  RWKit
//
//  Created by Ranger on 16/5/5.
//  Copyright © 2016年 Centaline. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray<ObjectType> (OneLibrary)

@property (nonatomic, copy, readonly) BOOL (^zy_contain)(ObjectType obj);
@property (nonatomic, copy, readonly) NSMutableArray* (^zy_add)(ObjectType obj);
@property (nonatomic, copy, readonly) NSMutableArray* (^zy_insertAt)(ObjectType obj, NSUInteger index);
@property (nonatomic, copy, readonly) NSMutableArray* (^zy_remove)(ObjectType obj);
@property (nonatomic, copy, readonly) NSMutableArray* (^zy_removeAt)(NSUInteger index);
@property (nonatomic, copy, readonly) NSMutableArray* (^zy_replace)(ObjectType src, ObjectType dst);
@property (nonatomic, copy, readonly) NSMutableArray* (^zy_replaceAt)(NSUInteger src, ObjectType dst);

/*!
 *  对存放model的数组按照model的某个字段进行排序 返回排序好的字典和字段数组
 */
- (void)zy_sortoutByPropertyName:(NSString *)name completion:(void (^)(NSDictionary *retDict, NSArray *keyArr))completion;

/** 快速遍历 enumerateObjects */
- (void)zy_each:(BOOL (^)(ObjectType obj))block;

/** 并发处理任务 */
- (void)zy_apply:(BOOL (^)(ObjectType obj))block;

/** 匹配一个需要的对象，返回nil或者匹配到的对象  */
- (nullable id)zy_match:(BOOL (^)(ObjectType obj))block;

/** 匹配多个对象，将满足条件的对象返回成一个新的数组 */
- (NSArray *)zy_select:(BOOL (^)(ObjectType obj))block;

/** 将数组中的对象遍历出来，处理后返回成一个新的数组 */
- (NSArray *)zy_map:(id (^)(ObjectType obj))block;

@end

@interface NSMutableArray<ObjectType> (OneLibrary)

@property (nonatomic, copy, readonly) NSMutableArray* (^zy_add)(ObjectType obj);
@property (nonatomic, copy, readonly) NSMutableArray* (^zy_insertAt)(ObjectType obj, NSUInteger index);
@property (nonatomic, copy, readonly) NSMutableArray* (^zy_remove)(ObjectType obj);
@property (nonatomic, copy, readonly) NSMutableArray* (^zy_removeAt)(NSUInteger index);
@property (nonatomic, copy, readonly) NSMutableArray* (^zy_replace)(ObjectType src, ObjectType dst);
@property (nonatomic, copy, readonly) NSMutableArray* (^zy_replaceAt)(NSUInteger src, ObjectType dst);

@end

NS_ASSUME_NONNULL_END
