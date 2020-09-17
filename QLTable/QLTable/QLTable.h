//
//  QLTable.h
//  QLTable
//
//  Created by RWLi on 2020/9/18.
//  Copyright © 2020  RWLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QLCellModle.h"

NS_ASSUME_NONNULL_BEGIN

@protocol QLTableDelegate <NSObject>

@required
-(QLCellModle*)titleModelForHeaderOftableView:(UITableView *)tableView;
-(NSArray<QLCellModle*>*)contentFortableView:(UITableView *)tableView;
@optional
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;


@end

@interface QLTable : UITableView
@property(nonatomic,weak) id<QLTableDelegate> qlDelegate;

@end

NS_ASSUME_NONNULL_END
