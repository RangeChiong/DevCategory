//
//  UITextView+OneLibrary.m
//  OneLibrary
//
//  Created by RangerChiong on 2017/7/12.
//  Copyright © 2017年 Ranger. All rights reserved.
//

#import "UITextView+OneLibrary.h"
#import <objc/runtime.h>

@interface UITextView ()

@property (nonatomic,strong) UILabel *placeholderLabel;
@property (nonatomic,strong) UILabel *wordCountLabel;

@end

@implementation UITextView (OneLibrary)

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidChangeNotification
                                                  object:self];
}

#pragma mark-  notification

- (void)textContentChanged:(NSNotification *)noti {
    if (self.zy_placeholder) {
        self.placeholderLabel.hidden = (self.text.length > 0);
    }
    
    if (self.zy_limitLength) {
        if (self.text.length > self.zy_limitLength) {
            self.text = [self.text substringToIndex:self.zy_limitLength];
        }
        self.wordCountLabel.text = [NSString stringWithFormat:@"%lu/%lu", self.text.length, self.zy_limitLength];
    }
}

#pragma mark-   Setter & Getter

-(void)setPlaceholderLabel:(UILabel *)placeholderLabel {
    objc_setAssociatedObject(self, @selector(placeholderLabel), placeholderLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)placeholderLabel {
    UILabel *label = objc_getAssociatedObject(self, _cmd);
    if (!label) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textContentChanged:) name:UITextViewTextDidChangeNotification object:self];
        CGPoint origin = [self caretRectForPosition:self.selectedTextRange.start].origin;
        label = [[UILabel alloc] initWithFrame:(CGRect){origin, CGSizeZero}];
        label.font = self.font;
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.textColor = [UIColor lightGrayColor];
        [self addSubview:label];
        [self setPlaceholderLabel:label];
    }
    return label;
}


- (void)setWordCountLabel:(UILabel *)wordCountLabel {
    objc_setAssociatedObject(self, @selector(wordCountLabel), wordCountLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)wordCountLabel {
    UILabel *label = objc_getAssociatedObject(self, _cmd);
    if (!label) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 65, CGRectGetHeight(self.frame) - 20, 60, 20)];
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = [UIColor lightGrayColor];
        label.font = self.font;
        [self addSubview:label];
        
        [self setWordCountLabel:label];
    }
    return label;
}

- (void)setZy_placeholder:(NSString *)zy_placeholder {
    objc_setAssociatedObject(self, @selector(zy_placeholder), zy_placeholder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.placeholderLabel.text = zy_placeholder;
    
    CGRect rect = self.placeholderLabel.frame;
    rect.size = [self.placeholderLabel sizeThatFits:self.frame.size];
    self.placeholderLabel.frame = rect;
}

- (NSString *)zy_placeholder {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setZy_limitLength:(NSUInteger)zy_limitLength {
    objc_setAssociatedObject(self, @selector(zy_limitLength), @(zy_limitLength), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.wordCountLabel.text = [self limitTextContent:zy_limitLength];
}

- (NSUInteger)zy_limitLength {
    return [objc_getAssociatedObject(self, _cmd) unsignedIntegerValue];
}

#pragma mark-  utils

- (NSString *)limitTextContent:(NSUInteger)length {
    if (self.text.length > length) {
        self.text = [self.text substringToIndex:length];
    }
    return [NSString stringWithFormat:@"%lu/%lu", self.text.length, length];
}

@end
