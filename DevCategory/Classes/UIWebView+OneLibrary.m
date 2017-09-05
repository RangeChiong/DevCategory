//
//  UIWebView+OneLibrary.m
//  AgencyLib
//
//  Created by RangerChiong on 2017/8/15.
//  Copyright © 2017年 Ranger. All rights reserved.
//

#import "UIWebView+OneLibrary.h"

@implementation UIWebView (OneLibrary)

- (NSString *)ol_webTitle {
    return [self stringByEvaluatingJavaScriptFromString:@"document.title"];
}

@end
