//
//  NSFileManager+OneLibrary.h
//  AgencyLib
//
//  Created by RangerChiong on 2017/9/4.
//  Copyright © 2017年 Ranger. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (OneLibrary)

/** 在dirPath下如果没有文件夹则创建 */
- (void)ol_createDirectory:(NSString *)dirPath;

@end
