//
//  NSDictionary+OneLibrary.m
//  RWKit
//
//  Created by Ranger on 16/5/5.
//  Copyright © 2016年 Centaline. All rights reserved.
//

#import "NSDictionary+OneLibrary.h"

@implementation NSDictionary (OneLibrary)

- (void)zy_each:(BOOL (^)(id<NSCopying> key, id obj))block {
    NSParameterAssert(block != nil);
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        *stop = block(key, obj);
    }];
}

- (void)zy_apply:(BOOL (^)(id<NSCopying> key, id obj))block {
    NSParameterAssert(block != nil);
    
    [self enumerateKeysAndObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id key, id obj, BOOL *stop) {
        *stop = block(key, obj);
    }];
}

- (id)zy_match:(BOOL (^)(id<NSCopying> key, id obj))block {
    NSParameterAssert(block != nil);
    
    return self[[[self keysOfEntriesPassingTest:^(id key, id obj, BOOL *stop) {
        if (block(key, obj)) {
            *stop = YES;
            return YES;
        }
        
        return NO;
    }] anyObject]];
}

- (NSDictionary *)zy_select:(BOOL (^)(id<NSCopying> key, id obj))block {
    NSParameterAssert(block != nil);
    
    NSArray *keys = [[self keysOfEntriesPassingTest:^(id key, id obj, BOOL *stop) {
        return block(key, obj);
    }] allObjects];
    
    NSArray *objects = [self objectsForKeys:keys notFoundMarker:[NSNull null]];
    return [NSDictionary dictionaryWithObjects:objects forKeys:keys];
}

- (NSDictionary *)zy_map:(id (^)(id<NSCopying> key, id obj))block {
    NSParameterAssert(block != nil);
    
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithCapacity:self.count];
    
    [self zy_each:^BOOL(id key, id obj) {
        id value = block(key, obj) ?: [NSNull null];
        result[key] = value;
        return NO;
    }];
    
    return result;
}

@end

