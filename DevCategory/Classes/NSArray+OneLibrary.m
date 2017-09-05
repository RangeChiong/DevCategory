//
//  NSArray+OneLibrary.m
//  RWKit
//
//  Created by Ranger on 16/5/5.
//  Copyright © 2016年 Centaline. All rights reserved.
//

#import "NSArray+OneLibrary.h"

_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wobjc-property-implementation\"")

@implementation NSArray (OneLibrary)

#pragma mark-  chain

- (BOOL (^)(id))zy_contain {
    return ^BOOL (id obj){
        return [self containsObject:obj];
    };
}

- (NSMutableArray *(^)(id))zy_add {
    return ^NSMutableArray *(id obj) {
        NSMutableArray *tmp = [self mutableCopy];
        [tmp addObject:obj];
        return tmp;
    };
}

- (NSMutableArray *(^)(id, NSUInteger))zy_insertAt {
    return ^NSMutableArray *(id obj, NSUInteger index) {
        NSMutableArray *tmp = [self mutableCopy];
        [tmp insertObject:obj atIndex:index];
        return tmp;
    };
}

- (NSMutableArray *(^)(id))zy_remove {
    return ^NSMutableArray *(id obj) {
        NSMutableArray *tmp = [self mutableCopy];
        [tmp removeObject:obj];
        return tmp;
    };
}

- (NSMutableArray *(^)(NSUInteger))zy_removeAt {
    return ^NSMutableArray *(NSUInteger index) {
        NSMutableArray *tmp = [self mutableCopy];
        [tmp removeObjectAtIndex:index];
        return tmp;
    };
}

- (NSMutableArray * (^)(id, id))zy_replace {
    return ^NSMutableArray *(id src, id dst) {
        NSMutableArray *tmp = [self mutableCopy];
        [tmp replaceObjectAtIndex:[self indexOfObject:src] withObject:dst];
        return tmp;
    };
}

- (NSMutableArray * (^)(NSUInteger, id))zy_replaceAt {
    return ^NSMutableArray *(NSUInteger index, id dst) {
        NSMutableArray *tmp = [self mutableCopy];
        [tmp replaceObjectAtIndex:index withObject:dst];
        return tmp;
    };
}

#pragma mark-  methods

- (void)zy_sortoutByPropertyName:(NSString *)name completion:(void (^)(NSDictionary *retDict, NSArray *keyArr))completion {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableArray *keyArr = [NSMutableArray array];
    for (id obj in self) {
        NSString *key = [obj valueForKey:name];
        NSMutableArray *tmpArr = dict[key];
        if (tmpArr.count) {
            [tmpArr addObject:obj];
        }
        else {
            tmpArr = [NSMutableArray array];
            [tmpArr addObject:obj];
            dict[key] = tmpArr;
            [keyArr addObject:key];
        }
    }
    
    !completion ?: completion(dict, keyArr);
}

- (void)zy_each:(BOOL (^)(id obj))block {
    NSParameterAssert(block != nil);
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        *stop = block(obj);
    }];
}

- (void)zy_apply:(BOOL (^)(id obj))block {
    NSParameterAssert(block != nil);

    [self enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        *stop = block(obj);
    }];
}

- (id)zy_match:(BOOL (^)(id obj))block {
    NSParameterAssert(block != nil);
    
    NSUInteger index = [self indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        return block(obj);
    }];
    
    if (index == NSNotFound)
        return nil;
    
    return self[index];
}

- (NSArray *)zy_select:(BOOL (^)(id obj))block {
    NSParameterAssert(block != nil);
    return [self objectsAtIndexes:[self indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        return block(obj);
    }]];
}
- (NSArray *)zy_map:(id (^)(id obj))block {
    NSParameterAssert(block != nil);
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.count];
    
    [self zy_each:^BOOL(id  _Nonnull obj) {
        id value = block(obj) ?: [NSNull null];
        [result addObject:value];
        return NO;
    }];
    return result;
}

@end


@implementation NSMutableArray (OneLibrary)

- (NSMutableArray *(^)(id))zy_add {
    return ^NSMutableArray *(id obj) {
        [self addObject:obj];
        return self;
    };
}

- (NSMutableArray *(^)(id, NSUInteger))zy_insertAt {
    return ^NSMutableArray *(id obj, NSUInteger index) {
        [self insertObject:obj atIndex:index];
        return self;
    };
}

- (NSMutableArray *(^)(id))zy_remove {
    return ^NSMutableArray *(id obj) {
        [self removeObject:obj];
        return self;
    };
}

- (NSMutableArray *(^)(NSUInteger))zy_removeAt {
    return ^NSMutableArray *(NSUInteger index) {
        [self removeObjectAtIndex:index];
        return self;
    };
}

- (NSMutableArray * (^)(id, id))zy_replace {
    return ^NSMutableArray *(id src, id dst) {
        [self replaceObjectAtIndex:[self indexOfObject:src] withObject:dst];
        return self;
    };
}

- (NSMutableArray * (^)(NSUInteger, id))zy_replaceAt {
    return ^NSMutableArray *(NSUInteger index, id dst) {
        [self replaceObjectAtIndex:index withObject:dst];
        return self;
    };
}

@end

_Pragma("clang diagnostic pop") \
