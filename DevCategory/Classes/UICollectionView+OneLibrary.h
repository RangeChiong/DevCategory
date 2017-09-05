//
//  UICollectionView+OneLibrary.h
//  AgencyLib
//
//  Created by RangerChiong on 2017/5/3.
//  Copyright © 2017年 Ranger. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (OneLibrary)

@property (nonatomic, copy, readonly) UICollectionView *(^zy_delegate)(id<UICollectionViewDelegate> delegate);
@property (nonatomic, copy, readonly) UICollectionView *(^zy_datasource)(id<UICollectionViewDataSource> datasource);

@property (nonatomic, copy, readonly) UICollectionView *(^zy_alwaysBounceHorizontal)(BOOL enabled);
@property (nonatomic, copy, readonly) UICollectionView *(^zy_collectionViewLayout)(UICollectionViewLayout *layout);

@property (nonatomic, copy, readonly) UICollectionView *(^zy_registerCellXib)(Class cls);
@property (nonatomic, copy, readonly) UICollectionView *(^zy_registerCellClass)(Class cls);

@property (nonatomic, copy, readonly) UICollectionView *(^zy_registerHeaderXib)(Class cls);
@property (nonatomic, copy, readonly) UICollectionView *(^zy_registerHeaderClass)(Class cls);

@property (nonatomic, copy, readonly) UICollectionView *(^zy_registerFooterXib)(Class cls);
@property (nonatomic, copy, readonly) UICollectionView *(^zy_registerFooterClass)(Class cls);

#pragma mark-  delegate

@property (nonatomic, copy, readonly) UICollectionView *(^zy_numberOfSections)(NSInteger(^block)(UICollectionView *collectionView));
@property (nonatomic, copy, readonly) UICollectionView *(^zy_numberOfRows)(NSInteger(^block)(UICollectionView *collectionView, NSInteger section));
@property (nonatomic, copy, readonly) UICollectionView *(^zy_cellForRow)(UICollectionViewCell *(^block)(UICollectionView *collectionView, NSIndexPath *indexPath));
@property (nonatomic, copy, readonly) UICollectionView *(^zy_viewForHeader)(UICollectionReusableView *(^block)(UICollectionView *collectionView, NSIndexPath *indexPath));
@property (nonatomic, copy, readonly) UICollectionView *(^zy_viewForFooter)(UICollectionReusableView *(^block)(UICollectionView *collectionView, NSIndexPath *indexPath));
@property (nonatomic, copy, readonly) UICollectionView *(^zy_didSelectRow)(void (^didSelectRow)(UICollectionView *collectionView, NSIndexPath *indexPath));

@end

NS_ASSUME_NONNULL_END
