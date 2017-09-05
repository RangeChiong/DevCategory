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

@property (nonatomic, copy, readonly) UITableView *(^zy_delegate)(id<UITableViewDelegate> delegate);
@property (nonatomic, copy, readonly) UITableView *(^zy_datasource)(id<UITableViewDataSource> datasource);

@property (nonatomic, copy, readonly) UITableView *(^zy_tableHeaderView)(UIView *view);
@property (nonatomic, copy, readonly) UITableView *(^zy_tableFooterView)(UIView *view);

@property (nonatomic, copy, readonly) UITableView *(^zy_rowHeight)(CGFloat h);
@property (nonatomic, copy, readonly) UITableView *(^zy_estimatedRowHeight)(CGFloat h);
@property (nonatomic, copy, readonly) UITableView *(^zy_sectionHeaderHeight)(CGFloat h);
@property (nonatomic, copy, readonly) UITableView *(^zy_sectionFooterHeight)(CGFloat h);

@property (nonatomic, copy, readonly) UITableView *(^zy_registerCellXib)(Class cls);
@property (nonatomic, copy, readonly) UITableView *(^zy_registerCellClass)(Class cls);

@property (nonatomic, copy, readonly) UITableView *(^zy_adjustTopPosition)();
@property (nonatomic, copy, readonly) UITableView *(^zy_adjustTopPositionWithHeight)(CGFloat h);

@property (nonatomic, copy, readonly) UITableView *(^zy_adjustBottomPosition)();
@property (nonatomic, copy, readonly) UITableView *(^zy_adjustBottomPositionWithHeight)(CGFloat h);

#pragma mark-  delegate

@property (nonatomic, copy, readonly) UITableView *(^zy_numberOfSections)(NSInteger(^block)(UITableView *tableView));
@property (nonatomic, copy, readonly) UITableView *(^zy_numberOfRows)(NSInteger(^block)(UITableView *tableView, NSInteger section));
@property (nonatomic, copy, readonly) UITableView *(^zy_cellForRow)(UITableViewCell *(^block)(UITableView *tableView, NSIndexPath *indexPath));
@property (nonatomic, copy, readonly) UITableView *(^zy_didSelectRow)(void(^block)(UITableView *tableView, NSIndexPath *indexPath));

@end

NS_ASSUME_NONNULL_END
