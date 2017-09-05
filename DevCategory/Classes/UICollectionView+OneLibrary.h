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

@property (nonatomic, copy, readonly) UICollectionView *(^ol_delegate)(id<UICollectionViewDelegate> delegate);
@property (nonatomic, copy, readonly) UICollectionView *(^ol_datasource)(id<UICollectionViewDataSource> datasource);

@property (nonatomic, copy, readonly) UICollectionView *(^ol_alwaysBounceHorizontal)(BOOL enabled);
@property (nonatomic, copy, readonly) UICollectionView *(^ol_collectionViewLayout)(UICollectionViewLayout *layout);

@property (nonatomic, copy, readonly) UICollectionView *(^ol_registerCellXib)(Class cls);
@property (nonatomic, copy, readonly) UICollectionView *(^ol_registerCellClass)(Class cls);

@property (nonatomic, copy, readonly) UICollectionView *(^ol_registerHeaderXib)(Class cls);
@property (nonatomic, copy, readonly) UICollectionView *(^ol_registerHeaderClass)(Class cls);

@property (nonatomic, copy, readonly) UICollectionView *(^ol_registerFooterXib)(Class cls);
@property (nonatomic, copy, readonly) UICollectionView *(^ol_registerFooterClass)(Class cls);

#pragma mark-  delegate

@property (nonatomic, copy, readonly) UICollectionView *(^ol_numberOfSections)(NSInteger(^block)(UICollectionView *collectionView));
@property (nonatomic, copy, readonly) UICollectionView *(^ol_numberOfRows)(NSInteger(^block)(UICollectionView *collectionView, NSInteger section));
@property (nonatomic, copy, readonly) UICollectionView *(^ol_cellForRow)(UICollectionViewCell *(^block)(UICollectionView *collectionView, NSIndexPath *indexPath));
@property (nonatomic, copy, readonly) UICollectionView *(^ol_viewForHeader)(UICollectionReusableView *(^block)(UICollectionView *collectionView, NSIndexPath *indexPath));
@property (nonatomic, copy, readonly) UICollectionView *(^ol_viewForFooter)(UICollectionReusableView *(^block)(UICollectionView *collectionView, NSIndexPath *indexPath));
@property (nonatomic, copy, readonly) UICollectionView *(^ol_didSelectRow)(void (^didSelectRow)(UICollectionView *collectionView, NSIndexPath *indexPath));

@end

NS_ASSUME_NONNULL_END
