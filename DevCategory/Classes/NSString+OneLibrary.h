//
//  NSString+OneLibrary.h
//  OneLibrary
//
//  Created by RangerChiong on 2017/6/5.
//  Copyright © 2017年 Ranger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (OneLibrary)

/** 设置指定位置文字的颜色 */
- (NSAttributedString *)zy_attributedStringOfColor:(UIColor *)color range:(NSRange)range;

@end


@interface NSString (FolderPath)

/*!
 *  获取沙盒下documens文件夹路径
 */
+ (NSString *)zy_documentsPath;

/*!
 *  获取沙盒下caches文件夹路径
 */
+ (NSString *)zy_cachesPath;

/*!
 *  获取沙盒下documens文件夹中 文件或者文件夹的完整路径
 */
+ (NSString *)zy_documentsContentDirectory:(NSString *)name;

/*!
 *  获取沙盒下caches文件夹中 文件或者文件夹的完整路径
 */
+ (NSString *)zy_cachesContentDirectory:(NSString *)name;

@end

#pragma mark-  Reg

@interface NSString (Reg)

/** 获取字符数量 */
- (int)zy_wordsCount;

/** 判断是否包含中文 */
- (BOOL)zy_isContainChinese;

/** 判断是否包含空格 */
- (BOOL)zy_isContainBlank;

/** 正则匹配11位手机号码 */
- (BOOL)zy_isPhoneNumber;

/** 判断纯数字字符串 */
- (BOOL)zy_isPureInt;

/** 删除指定的一些字符 */
- (NSString *)zy_deleteStrings:(NSArray *)strs;

/** 身份证号码验证 */
- (BOOL)zy_validateIdentityCard;

/// 去掉整段文字内的所有空白字符（包括换行符）
- (NSString *)zy_trimAllWhiteSpace;

/// 将文字中的换行符替换为空格
- (NSString *)zy_trimLineBreakCharacter;

@end

#pragma mark-  Project

@interface NSString (Project)

/** 获取当前工程的发布版本 */
+ (NSString *)zy_bundleShortVersion;

/** 获取当前工程的内部版本 */
+ (NSString *)zy_bundleVersion;

/** 获取当前工程的唯一标识 */
+ (NSString *)zy_bundleIdentifier;

/** 从mainBundle中根据key获取信息 */
+ (NSString *)zy_objectFromMainBundleForKey:(NSString *)key;

@end

#pragma mark-  calcalation

@interface NSString (Calculation)

/** 计算单位 ：xxx万 xxx亿 */
- (NSString *)zy_calculateUnit;

/** 添加千分符号 1,000,000 */
- (NSString *)zy_addSeparator;

/** 计算文字宽高 */
- (CGSize)zy_stringSize:(UIFont *)font boundingSize:(CGSize)boundingSize;

@end

#pragma mark-  encrypt

@interface NSString (Encrypt)

- (NSString *)zy_base64Encode;
- (NSString *)zy_MD5;
- (NSString *)zy_SHA1;
- (NSString *)zy_SHA256;

@end

#pragma mark-  chain

@interface NSString (Chain)

@property (nonatomic, readonly, class) NSString *(^zy_format)(NSString *str, ...);
@property (nonatomic, copy, readonly) BOOL (^zy_equal)(NSString *str);
@property (nonatomic, copy, readonly) NSString *(^zy_append)(NSString *str);
@property (nonatomic, copy, readonly) NSString *(^zy_appendFormat)(NSString *str, ...);
@property (nonatomic, copy, readonly) NSString *(^zy_replace)(NSString *src, NSString *dst);

@end

#pragma mark-  Device

@interface NSString (Device)

/** 获取手机设备 */
+ (NSString *)zy_deviceModel;

@end

NS_ASSUME_NONNULL_END
