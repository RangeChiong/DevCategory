//
//  UIAlertView+CallBack.h
//  MyAlertView
//
//  Created by RPIOS on 15/7/28.
//  Copyright (c) 2015年 Ranger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (CallBack)

@property(nonatomic, copy) void (^ol_clickButtonIndexBlock)(NSUInteger index);

@end
