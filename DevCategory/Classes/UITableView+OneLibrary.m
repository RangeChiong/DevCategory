//
//  UITableView+OneLibrary.m
//  findproperty
//
//  Created by Ranger on 16/8/20.
//  Copyright © 2016年 Centaline. All rights reserved.
//

#import "UITableView+OneLibrary.h"
@import ObjectiveC.runtime;

@interface __OLTableViewHelper : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSInteger(^numberOfSections)(UITableView *tableView);
@property (nonatomic, copy) NSInteger(^numberOfRows)(UITableView *tableView, NSInteger section);
@property (nonatomic, copy) UITableViewCell *(^cellForRow)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, copy) void (^didSelectRow)(UITableView *tableView, NSIndexPath *indexPath);

@end

@implementation __OLTableViewHelper

- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.numberOfSections ? self.numberOfSections(tableView) : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.numberOfRows ? self.numberOfRows(tableView, section) : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.cellForRow ? self.cellForRow(tableView, indexPath) : nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    !self.didSelectRow ?: self.didSelectRow(tableView, indexPath);
}

@end

@interface UITableView (__OneLibraryPrivate)

@property (nonatomic, strong) __OLTableViewHelper *tableViewHelper;

@end

_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wobjc-property-implementation\"")

@implementation UITableView (OneLibrary)

- (__OLTableViewHelper *)tableViewHelper {
    return objc_getAssociatedObject(self, _cmd) ?: ({
        __OLTableViewHelper *helper = [__OLTableViewHelper new];
        self.delegate = helper;
        self.dataSource = helper;
        objc_setAssociatedObject(self, _cmd, helper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        helper;
    });
}

#pragma mark-  public methods

- (UITableView *(^)(id<UITableViewDelegate>))ol_delegate {
    return ^UITableView *(id<UITableViewDelegate> delegate) {
        self.delegate = delegate;
        return self;
    };
}

- (UITableView *(^)(id<UITableViewDataSource>))ol_datasource {
    return ^UITableView *(id<UITableViewDataSource> datasource) {
        self.dataSource = datasource;
        return self;
    };
}

- (UITableView *(^)(UIView *))ol_tableHeaderView {
    return ^UITableView *(UIView *view) {
        self.tableHeaderView = view;
        return self;
    };
}

- (UITableView *(^)(UIView *))ol_tableFooterView {
    return ^UITableView *(UIView *view) {
        self.tableFooterView = view;
        return self;
    };
}

- (UITableView *(^)(CGFloat))ol_rowHeight {
    return ^UITableView *(CGFloat h) {
        self.rowHeight = h;
        return self;
    };
}

- (UITableView *(^)(CGFloat))ol_estimatedRowHeight {
    return ^UITableView *(CGFloat h) {
        self.estimatedRowHeight = h;
        return self;
    };
}

- (UITableView *(^)(CGFloat))ol_sectionHeaderHeight {
    return ^UITableView *(CGFloat h) {
        self.sectionHeaderHeight = h;
        return self;
    };
}


- (UITableView *(^)(CGFloat))ol_sectionFooterHeight {
    return ^UITableView *(CGFloat h) {
        self.sectionFooterHeight = h;
        return self;
    };
}

- (UITableView *(^)(Class))ol_registerCellXib {
    return ^UITableView *(Class cls) {
        NSString *name = NSStringFromClass(cls);
        [self registerNib:[UINib nibWithNibName:name bundle:nil] forCellReuseIdentifier:name];
        return self;
    };
}

- (UITableView *(^)(Class))ol_registerCellClass {
    return ^UITableView *(Class cls) {
        [self registerClass:cls forCellReuseIdentifier:NSStringFromClass(cls)];
        return self;
    };
}


- (UITableView *(^)())ol_adjustTopPosition {
    return ^UITableView * {
        return self.ol_adjustTopPositionWithHeight(CGFLOAT_MIN);
    };
}

- (UITableView *(^)(CGFloat))ol_adjustTopPositionWithHeight {
    return ^UITableView *(CGFloat h) {
        self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, h)];
        return self;
    };
}


- (UITableView *(^)())ol_adjustBottomPosition {
    return ^UITableView * {
        return self.ol_adjustBottomPositionWithHeight(49);
    };
}

- (UITableView *(^)(CGFloat))ol_adjustBottomPositionWithHeight {
    return ^UITableView *(CGFloat h) {
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, h)];
        return self;
    };
}

#pragma mark-  delegate

- (UITableView *(^)(NSInteger (^)(UITableView *)))ol_numberOfSections {
    return ^UITableView *(NSInteger (^block)(UITableView *)) {
        self.tableViewHelper.numberOfSections = block;
        return self;
    };
}

- (UITableView *(^)(NSInteger (^)(UITableView *, NSInteger)))ol_numberOfRows {
    return ^UITableView *(NSInteger (^block)(UITableView *, NSInteger)) {
        self.tableViewHelper.numberOfRows = block;
        return self;
    };
}

- (UITableView *(^)(UITableViewCell *(^)(UITableView *, NSIndexPath *)))ol_cellForRow {
    return ^UITableView *(UITableViewCell *(^block)(UITableView *, NSIndexPath *)) {
        self.tableViewHelper.cellForRow = block;
        return self;
    };
}

- (UITableView *(^)(void (^)(UITableView *, NSIndexPath *)))ol_didSelectRow {
    return ^UITableView *(void(^block)(UITableView *, NSIndexPath *)) {
        self.tableViewHelper.didSelectRow = block;
        return self;
    };
}

_Pragma("clang diagnostic pop")

@end
