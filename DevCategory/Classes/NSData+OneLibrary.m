//
//  NSData+OneLibrary.m
//  findproperty
//
//  Created by RangerChiong on 17/2/9.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "NSData+OneLibrary.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSData (OneLibrary)

- (NSData *)zy_MD5Digest {
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(self.bytes, (CC_LONG)self.length, result);
    return [[NSData alloc] initWithBytes:result length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)zy_MD5HexDigest {
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(self.bytes, (CC_LONG)self.length, result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

@end
