//
//  UITableView+OneLibrary.h
//  findproperty
//
//  Created by Ranger on 16/8/20.
//  Copyright © 2016年 Centaline. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (OneLibrary)

@property (nonatomic, copy, readonly) UITableView *(^ol_delegate)(id<UITableViewDelegate> delegate);
@property (nonatomic, copy, readonly) UITableView *(^ol_datasource)(id<UITableViewDataSource> datasource);

@property (nonatomic, copy, readonly) UITableView *(^ol_tableHeaderView)(UIView *view);
@property (nonatomic, copy, readonly) UITableView *(^ol_tableFooterView)(UIView *view);

@property (nonatomic, copy, readonly) UITableView *(^ol_rowHeight)(CGFloat h);
@property (nonatomic, copy, readonly) UITableView *(^ol_estimatedRowHeight)(CGFloat h);
@property (nonatomic, copy, readonly) UITableView *(^ol_sectionHeaderHeight)(CGFloat h);
@property (nonatomic, copy, readonly) UITableView *(^ol_sectionFooterHeight)(CGFloat h);

@property (nonatomic, copy, readonly) UITableView *(^ol_registerCellXib)(Class cls);
@property (nonatomic, copy, readonly) UITableView *(^ol_registerCellClass)(Class cls);

@property (nonatomic, copy, readonly) UITableView *(^ol_adjustTopPosition)();
@property (nonatomic, copy, readonly) UITableView *(^ol_adjustTopPositionWithHeight)(CGFloat h);

@property (nonatomic, copy, readonly) UITableView *(^ol_adjustBottomPosition)();
@property (nonatomic, copy, readonly) UITableView *(^ol_adjustBottomPositionWithHeight)(CGFloat h);

#pragma mark-  delegate

@property (nonatomic, copy, readonly) UITableView *(^ol_numberOfSections)(NSInteger(^block)(UITableView *tableView));
@property (nonatomic, copy, readonly) UITableView *(^ol_numberOfRows)(NSInteger(^block)(UITableView *tableView, NSInteger section));
@property (nonatomic, copy, readonly) UITableView *(^ol_cellForRow)(UITableViewCell *(^block)(UITableView *tableView, NSIndexPath *indexPath));
@property (nonatomic, copy, readonly) UITableView *(^ol_didSelectRow)(void(^block)(UITableView *tableView, NSIndexPath *indexPath));

@end

NS_ASSUME_NONNULL_END
