//
//  UITextView+OneLibrary.h
//  OneLibrary
//
//  Created by RangerChiong on 2017/7/12.
//  Copyright © 2017年 Ranger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (OneLibrary)

@property (nonatomic, strong) NSString *ol_placeholder;
@property (nonatomic, assign) NSUInteger ol_limitLength;

@end
