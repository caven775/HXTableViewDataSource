//
//  HXTableViewDataSource.h
//  dafa
//
//  Created by TAL on 2018/7/6.
//  Copyright © 2018年 TAL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef UITableViewCell * (^hxRegisterCell)(UITableView * tableView, id dataItem);
typedef void(^hxCellCallBack)(UITableViewCell * cell, NSIndexPath * indexPath, id dataItem);

@interface HXTableViewDataSource : NSObject <UITableViewDelegate, UITableViewDataSource>

+ (instancetype)dataSourceWithRegisterCell:(hxRegisterCell)registerCell;
- (instancetype)initWithRegisterCell:(hxRegisterCell)registerCell;

+ (instancetype)dataSourceWithRegisterCell:(hxRegisterCell)registerCell
                               callBack:(hxCellCallBack)callBack;

- (instancetype)initWithRegisterCell:(hxRegisterCell)registerCell
                         callBack:(hxCellCallBack)callBack;

- (void)hx_reloadData:(nullable NSArray *)dataArray
            tableView:(UITableView *)tableView;

@end
