//
//  UICollectionView+OneLibrary.m
//  AgencyLib
//
//  Created by RangerChiong on 2017/5/3.
//  Copyright © 2017年 Ranger. All rights reserved.
//

#import "UICollectionView+OneLibrary.h"
@import ObjectiveC.runtime;

@interface __OLCollectionViewHelper : NSObject<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, copy) NSInteger(^numberOfSections)(UICollectionView *collectionView);
@property (nonatomic, copy) NSInteger(^numberOfRows)(UICollectionView *collectionView, NSInteger section);
@property (nonatomic, copy) UICollectionViewCell *(^cellForRow)(UICollectionView *collectionView, NSIndexPath *indexPath);
@property (nonatomic, copy) UICollectionReusableView *(^viewForHeader)(UICollectionView *collectionView, NSIndexPath *indexPath);
@property (nonatomic, copy) UICollectionReusableView *(^viewForFooter)(UICollectionView *collectionView, NSIndexPath *indexPath);
@property (nonatomic, copy) void (^didSelectRow)(UICollectionView *collectionView, NSIndexPath *indexPath);

@end

@implementation __OLCollectionViewHelper

- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.numberOfSections ? self.numberOfSections(collectionView) : 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.numberOfRows ? self.numberOfRows(collectionView, section) : 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.cellForRow ? self.cellForRow(collectionView, indexPath) : nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        return self.viewForHeader ? self.viewForHeader(collectionView, indexPath) : nil;
    }
    return self.viewForFooter ? self.viewForFooter(collectionView, indexPath) : nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    !self.didSelectRow ?: self.didSelectRow(collectionView, indexPath);
}

@end


@interface UICollectionView (__OneLibraryPrivate)

@property (nonatomic, weak) __OLCollectionViewHelper *collectionViewHelper;

@end

_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wobjc-property-implementation\"")

@implementation UICollectionView (OneLibrary)

- (__OLCollectionViewHelper *)collectionViewHelper {
    return objc_getAssociatedObject(self, _cmd) ?: ({
        __OLCollectionViewHelper *helper = [__OLCollectionViewHelper new];
        self.delegate = helper;
        self.dataSource = helper;
        objc_setAssociatedObject(self, _cmd, helper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        helper;
    });
}

#pragma mark-  delegate

- (UICollectionView *(^)(NSInteger (^)(UICollectionView *)))zy_numberOfSections {
    return ^UICollectionView *(NSInteger (^block)(UICollectionView *)) {
        self.collectionViewHelper.numberOfSections = block;
        return self;
    };
}

- (UICollectionView *(^)(NSInteger (^)(UICollectionView *, NSInteger)))zy_numberOfRows {
    return ^UICollectionView *(NSInteger (^block)(UICollectionView *, NSInteger)) {
        self.collectionViewHelper.numberOfRows = block;
        return self;
    };
}

- (UICollectionView *(^)(UICollectionViewCell *(^)(UICollectionView *, NSIndexPath *)))zy_cellForRow {
    return ^UICollectionView *(UICollectionViewCell *(^block)(UICollectionView *, NSIndexPath *)) {
        self.collectionViewHelper.cellForRow = block;
        return self;
    };
}

- (UICollectionView *(^)(UICollectionReusableView *(^)(UICollectionView *, NSIndexPath *)))zy_viewForHeader {
    return ^UICollectionView *(UICollectionReusableView *(^block)(UICollectionView *, NSIndexPath *)) {
        self.collectionViewHelper.viewForHeader = block;
        return self;
    };
}

- (UICollectionView *(^)(UICollectionReusableView *(^)(UICollectionView *, NSIndexPath *)))zy_viewForFooter {
    return ^UICollectionView *(UICollectionReusableView *(^block)(UICollectionView *, NSIndexPath *)) {
        self.collectionViewHelper.viewForFooter = block;
        return self;
    };
}

- (UICollectionView *(^)(void (^)(UICollectionView *, NSIndexPath *)))zy_didSelectRow {
    return ^UICollectionView *(void (^block)(UICollectionView *, NSIndexPath *)) {
        self.collectionViewHelper.didSelectRow = block;
        return self;
    };
}

#pragma mark-  public methods

- (UICollectionView *(^)(id<UICollectionViewDelegate>))zy_delegate {
    return ^UICollectionView *(id<UICollectionViewDelegate> delegate) {
        self.delegate = delegate;
        return self;
    };
}

- (UICollectionView *(^)(id<UICollectionViewDataSource>))zy_datasource {
    return ^UICollectionView *(id<UICollectionViewDataSource> datasource) {
        self.dataSource = datasource;
        return self;
    };
}

- (UICollectionView *(^)(BOOL))zy_alwaysBounceHorizontal {
    return ^UICollectionView *(BOOL enabled) {
        self.alwaysBounceHorizontal = enabled;
        return self;
    };
}

- (UICollectionView *(^)(UICollectionViewLayout *))zy_collectionViewLayout {
    return ^UICollectionView *(UICollectionViewLayout *flow) {
        self.collectionViewLayout = flow;
        return self;
    };
}

- (UICollectionView *(^)(Class))zy_registerCellXib {
    return ^UICollectionView *(Class cls) {
        NSString *name = NSStringFromClass(cls);
        [self registerNib:[UINib nibWithNibName:name bundle:nil] forCellWithReuseIdentifier:name];
        return self;
    };
}

- (UICollectionView *(^)(Class))zy_registerCellClass {
    return ^UICollectionView *(Class cls) {
        [self registerClass:cls forCellWithReuseIdentifier:NSStringFromClass(cls)];
        return self;
    };
}


- (UICollectionView *(^)(Class))zy_registerHeaderXib {
    return ^UICollectionView *(Class cls) {
        NSString *name = NSStringFromClass(cls);
        [self registerNib:[UINib nibWithNibName:name bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:name];
        return self;
    };
}

- (UICollectionView *(^)(Class))zy_registerHeaderClass {
    return ^UICollectionView *(Class cls) {
        [self registerClass:cls forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(cls)];
        return self;
    };
}


- (UICollectionView *(^)(Class))zy_registerFooterXib {
    return ^UICollectionView *(Class cls) {
        NSString *name = NSStringFromClass(cls);
        [self registerNib:[UINib nibWithNibName:name bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:name];
        return self;
    };
}

- (UICollectionView *(^)(Class))zy_registerFooterClass {
    return ^UICollectionView *(Class cls) {
        [self registerClass:cls forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass(cls)];
        return self;
    };
}

@end

_Pragma("clang diagnostic pop") \
