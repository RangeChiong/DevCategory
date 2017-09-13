//
//  NSString+OneLibrary.m
//  OneLibrary
//
//  Created by RangerChiong on 2017/6/5.
//  Copyright © 2017年 Ranger. All rights reserved.
//

#import "NSString+OneLibrary.h"
#import <CommonCrypto/CommonDigest.h>
#import <sys/mount.h>
#import <sys/sysctl.h>
#import <net/if.h>
#import <net/if_dl.h>

_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wobjc-property-implementation\"")

@implementation NSString (OneLibrary)

- (NSAttributedString *)zy_attributedStringOfColor:(UIColor *)color range:(NSRange)range {
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self];
    [attrStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    return attrStr;
}

@end

@implementation NSString (FolderPath)

+ (NSString *)zy_documentsPath {
    return [self zy_searchPathFrom:NSDocumentDirectory];
}

+ (NSString *)zy_cachesPath {
    return [self zy_searchPathFrom:NSCachesDirectory];
}

+ (NSString *)zy_documentsContentDirectory:(NSString *)name {
    return [NSString stringWithFormat:@"%@/%@", [self zy_documentsPath], name];
}

+ (NSString *)zy_cachesContentDirectory:(NSString *)name {
    return [NSString stringWithFormat:@"%@/%@", [self zy_cachesPath], name];
}

#pragma mark-  private methods

+ (NSString *)zy_searchPathFrom:(NSSearchPathDirectory)directory {
    return NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES)[0];
}

@end

#pragma mark-  Reg

@implementation NSString (Reg)

#pragma mark-  获取字符数量
- (int)zy_wordsCount {
    NSInteger n = self.length;
    int i;
    int l = 0, a = 0, b = 0;
    unichar c;
    for (i = 0; i < n; i++) {
        c = [self characterAtIndex:i];
        if (isblank(c)) {
            b++;
        } else if (isascii(c)) {
            a++;
        } else {
            l++;
        }
    }
    if (a == 0 && l == 0) {
        return 0;
    }
    return l + (int)ceilf((float)(a + b) / 2.0);
}

#pragma mark-   是否包含中文
- (BOOL)zy_isContainChinese {
    NSUInteger length = [self length];
    for (NSUInteger i = 0; i < length; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [self substringWithRange:range];
        const char *cString = [subString UTF8String];
        if (strlen(cString) == 3) {
            return YES;
        }
    }
    return NO;
}

#pragma mark-   是否包含空格
- (BOOL)zy_isContainBlank {
    NSRange range = [self rangeOfString:@" "];
    if (range.location != NSNotFound) {
        return YES;
    }
    return NO;
}

#pragma mark-  判断纯数字字符串
- (BOOL)zy_isPureInt {
    NSScanner *scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

#pragma 正则匹配11位手机号
- (BOOL)zy_isPhoneNumber {
    
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    BOOL res1 = [regextestmobile evaluateWithObject:self];
    BOOL res2 = [regextestcm evaluateWithObject:self];
    BOOL res3 = [regextestcu evaluateWithObject:self];
    BOOL res4 = [regextestct evaluateWithObject:self];
    
    if (res1 || res2 || res3 || res4 ) {
        return YES;
    } else {
        return NO;
    }
}

- (NSString *)zy_deleteStrings:(NSArray *)strs {
    NSString *resultStr = self.copy;
    for (NSString *tmpStr in strs) {
        resultStr = [resultStr stringByReplacingOccurrencesOfString:tmpStr withString:@""];
    }
    return resultStr;
}

- (BOOL)zy_validateIdentityCard {
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}

- (NSString *)zy_trimAllWhiteSpace {
    return [self stringByReplacingOccurrencesOfString:@"\\s" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, self.length)];
}

- (NSString *)zy_trimLineBreakCharacter {
    return [self stringByReplacingOccurrencesOfString:@"[\r\n]" withString:@" " options:NSRegularExpressionSearch range:NSMakeRange(0, self.length)];
}

@end

#pragma mark-  Project

@implementation NSString (Project)

+ (NSString *)zy_bundleShortVersion {
    return [self zy_objectFromMainBundleForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)zy_bundleVersion {
    return [self zy_objectFromMainBundleForKey:@"CFBundleVersion"];
}

+ (NSString *)zy_bundleIdentifier {
    return [self zy_objectFromMainBundleForKey:@"CFBundleIdentifier"];
}

+ (NSString *)zy_objectFromMainBundleForKey:(NSString *)key {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return  [infoDictionary objectForKey:key];
}

@end

#pragma mark-  string calculation

@implementation NSString (Calculation)

#pragma mark-  handler
// 计算单位
- (NSString *)zy_calculateUnit {
    NSInteger nRet = 0;
    NSInteger value = self.integerValue;
    NSString *resultStr = @"";
    if (value > 1e8l) { //100000000
        nRet = value/1e8l;
        resultStr = [NSString stringWithFormat:@"%zd亿",nRet];
    }
    else if (value > 1e4l) {
        nRet = value/1e4l; //10000
        resultStr = [NSString stringWithFormat:@"%zd万",nRet];
    }
    return resultStr;
}

// 添加逗号分割 20000 = 20,000
- (NSString *)zy_addSeparator {
    NSMutableString *mStr = self.mutableCopy;
    NSRange range = [mStr rangeOfString:@"."];  // 防止有小数点
    NSInteger index = (range.location != NSNotFound) ? range.location : self.length;
    while ((index - 3) > 0) {
        index -= 3;
        [mStr insertString:@"," atIndex:index];
    }
    return mStr.copy;
}

#pragma mark-  string length

- (CGSize)zy_stringSize:(UIFont *)font boundingSize:(CGSize)boundingSize {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    NSDictionary *attrSyleDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  font, NSFontAttributeName,
                                  nil];
    
    [attributedString addAttributes:attrSyleDict
                              range:NSMakeRange(0, self.length)];
    CGRect stringRect = [attributedString boundingRectWithSize:boundingSize
                                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                       context:nil];
    return stringRect.size;
}

@end

#pragma mark-  encrypt

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@implementation NSString (Encrypt)

- (NSString *)zy_base64Encode {
    if ([self length] == 0)
        return @"";
    
    const char *source = [self UTF8String];
    int strlength  = (int)strlen(source);
    
    char *characters = malloc(((strlength + 2) / 3) * 4);
    if (characters == NULL) return nil;
    
    NSUInteger length = 0;
    NSUInteger i = 0;
    
    while (i < strlength) {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < strlength)
            buffer[bufferLength++] = source[i++];
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters
                                          length:length
                                        encoding:NSASCIIStringEncoding
                                    freeWhenDone:YES];
}

- (NSString *)zy_MD5 {
    unsigned int outputLength = CC_MD5_DIGEST_LENGTH;
    unsigned char output[outputLength];
    
    CC_MD5(self.UTF8String, [self __UTF8Length], output);
    return [self __toHexString:output length:outputLength];
}

- (NSString *)zy_SHA1 {
    unsigned int outputLength = CC_SHA1_DIGEST_LENGTH;
    unsigned char output[outputLength];
    
    CC_SHA1(self.UTF8String, [self __UTF8Length], output);
    return [self __toHexString:output length:outputLength];
}

- (NSString *)zy_SHA256 {
    unsigned int outputLength = CC_SHA256_DIGEST_LENGTH;
    unsigned char output[outputLength];
    
    CC_SHA256(self.UTF8String, [self __UTF8Length], output);
    return [self __toHexString:output length:outputLength];
}

#pragma mark-  encrypt private methods

- (unsigned int)__UTF8Length {
    return (unsigned int) [self lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)__toHexString:(unsigned char*) data length: (unsigned int) length {
    NSMutableString *hash = [NSMutableString stringWithCapacity:length * 2];
    for (unsigned int i = 0; i < length; i++) {
        [hash appendFormat:@"%02x", data[i]];
        data[i] = 0;
    }
    return hash;
}

@end


@implementation NSString (Chain)

+ (NSString *(^)(NSString *, ...))zy_format {
    return ^NSString* (NSString *str, ...) {
        va_list args;
        va_start(args, str);
        NSString *result = [[NSString alloc] initWithFormat:str arguments:args];
        va_end(args);
        return result;
    };
}

- (BOOL (^)(NSString *))zy_equal {
    return ^BOOL (NSString *str) {
        return [self isEqualToString:str];
    };
}

- (NSString *(^)(NSString *))zy_append {
    return ^NSString *(NSString *str){
        return [self stringByAppendingString:str];
    };
}

- (NSString *(^)(NSString *, ...))zy_appendFormat {
    return ^NSString* (NSString *str, ...) {
        va_list args;
        va_start(args, str);
        NSString *result = [[NSString alloc] initWithFormat:str arguments:args];
        va_end(args);
        return [self stringByAppendingString:result];
    };
}

- (NSString *(^)(NSString *, NSString *))zy_replace {
    return ^NSString* (NSString *src, NSString *dst) {
        return [self stringByReplacingOccurrencesOfString:src withString:dst];
    };
}

@end


@implementation NSString (Device)

/**
 *  获取手机设备
 */
+ (NSString *)zy_deviceModel {
    //获得设备型号
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    //iPhone
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s (A1633/A1688/A1691/A1700)";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus (A1634/A1687/A1690/A1699)";
    
    // 模拟器
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}

@end

_Pragma("clang diagnostic pop") \
