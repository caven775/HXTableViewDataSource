//
//  HXTableViewDataSource.m
//  dafa
//
//  Created by TAL on 2018/7/6.
//  Copyright © 2018年 TAL. All rights reserved.
//

#import "HXTableViewDataSource.h"

@interface HXTableViewDataSource ()

@property (nonatomic, copy) NSArray * dataArray;
@property (nonatomic, copy) hxRegisterCell hx_registerCell;
@property (nonatomic, copy) hxCellCallBack hx_cellCallBack;

@end

@implementation HXTableViewDataSource

+ (instancetype)dataSourceWithRegisterCell:(hxRegisterCell)registerCell
{
    return [[self alloc] initWithRegisterCell:registerCell callBack:nil];
}

+ (instancetype)dataSourceWithRegisterCell:(hxRegisterCell)registerCell callBack:(hxCellCallBack)callBack
{
    return [[self alloc] initWithRegisterCell:registerCell callBack:callBack];
}

- (instancetype)initWithRegisterCell:(hxRegisterCell)registerCell
{
    return [[HXTableViewDataSource alloc] initWithRegisterCell:registerCell callBack:nil];
}

- (instancetype)initWithRegisterCell:(hxRegisterCell)registerCell callBack:(hxCellCallBack)callBack
{
    self = [super init];
    if (self) {
        self.hx_cellCallBack = callBack;
        self.hx_registerCell = registerCell;
    }
    return self;
}

- (void)hx_reloadData:(NSArray *)dataArray tableView:(UITableView *)tableView
{
    if (!dataArray) {
        dataArray = @[];
    }
    self.dataArray = dataArray;
    [tableView reloadData];
}


#pragma mark -- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self hx_numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self hx_numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self hx_isSectionsTableView]) {
        if (self.hx_registerCell) {
            return self.hx_registerCell(tableView, [self hx_sectionArray:indexPath.section][indexPath.row]);
        }
    } else {
        if (self.hx_registerCell) {
            return self.hx_registerCell(tableView, self.dataArray[indexPath.row]);
        }
    }
    return nil;
}


#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.hx_cellCallBack) {
        id dataItem = nil;
        if ([self hx_isSectionsTableView]) {
            dataItem = [self hx_sectionArray:indexPath.section][indexPath.row];
        } else {
            dataItem = self.dataArray[indexPath.row];
        }
        self.hx_cellCallBack([tableView cellForRowAtIndexPath:indexPath], indexPath, dataItem);
    }
}


#pragma mark -- other

- (NSInteger)hx_numberOfSections
{
    return [self hx_isSectionsTableView] ? [self.dataArray count] : 1;
}

- (NSInteger)hx_numberOfRowsInSection:(NSInteger)section
{
    if ([self hx_isSectionsTableView]) {
        return [[self hx_sectionArray:section] count];
    }
    return [self.dataArray count];
}

- (NSArray *)hx_sectionArray:(NSInteger)section
{
    return (NSArray *)self.dataArray[section];
}

- (BOOL)hx_isSectionsTableView
{
    NSSet * dataSet = [NSSet setWithArray:self.dataArray];
    return [[dataSet anyObject] isKindOfClass:[NSArray class]];
}

@end
