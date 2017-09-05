//
//  NSTimer+OneLibrary.m
//  RWKit
//
//  Created by Ranger on 16/5/5.
//  Copyright © 2016年 Centaline. All rights reserved.
//

#import "NSTimer+OneLibrary.h"

@implementation NSTimer (OneLibrary)

+ (instancetype)ol_scheduleTimerWithTimeInterval:(NSTimeInterval)ti
                                         repeats:(BOOL)rep
                                      usingBlock:(void (^)(NSTimer *timer))block {
    return [self ol_scheduleTimerWithTimeInterval:ti repeats:rep mode:NSRunLoopCommonModes usingBlock:block];
}

+ (instancetype)ol_scheduleTimerWithTimeInterval:(NSTimeInterval)ti
                                         repeats:(BOOL)rep
                                            mode:(NSRunLoopMode)mode
                                      usingBlock:(void (^)(NSTimer *timer))block {
    NSTimer *timer = [self ol_timerWithTimeInterval:ti repeats:rep usingBlock:block];
    [NSRunLoop.currentRunLoop addTimer:timer forMode:mode];
    return timer;
}

+ (instancetype)ol_timerWithTimeInterval:(NSTimeInterval)ti
                                 repeats:(BOOL)rep
                              usingBlock:(void (^)(NSTimer *t))block {
    
    NSParameterAssert(block != nil);
    CFAbsoluteTime seconds = fmax(ti, 0.0001);
    CFAbsoluteTime interval = rep ? seconds : 0;
    CFAbsoluteTime fireDate = CFAbsoluteTimeGetCurrent() + seconds;
    return (__bridge_transfer NSTimer *)CFRunLoopTimerCreateWithHandler(NULL, fireDate, interval, 0, 0, (void(^)(CFRunLoopTimerRef))block);
    
}

@end
