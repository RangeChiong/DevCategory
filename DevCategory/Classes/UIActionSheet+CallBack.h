//
//  UIActionSheet+CallBack.h
//  Agency
//
//  Created by RangerChiong on 2017/6/8.
//  Copyright © 2017年 centanet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIActionSheet (CallBack)

@property(nonatomic, copy) void (^ol_clickButtonIndexBlock)(NSUInteger index);

@end
