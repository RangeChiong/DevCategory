//
//  NSFileManager+OneLibrary.m
//  AgencyLib
//
//  Created by RangerChiong on 2017/9/4.
//  Copyright © 2017年 Ranger. All rights reserved.
//

#import "NSFileManager+OneLibrary.h"

@implementation NSFileManager (OneLibrary)

- (void)zy_createDirectory:(NSString *)dirPath {
    
    BOOL isDirector = NO;
    BOOL isExiting = [self fileExistsAtPath:dirPath isDirectory:&isDirector];
    if (!(isExiting && isDirector)) {
        BOOL createDirection = [self createDirectoryAtPath:dirPath
                               withIntermediateDirectories:YES
                                                attributes:nil
                                                     error:nil];
        if (!createDirection)
            NSLog(@"创建文件夹失败：%@", dirPath);
    }
}

@end
