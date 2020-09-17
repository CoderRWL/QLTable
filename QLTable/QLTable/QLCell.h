//
//  QLCell.h
//  initVC
//
//  Created by lrw on 2016/12/22.
//  Copyright © 2016年 lrw. All rights reserved.
//



#import <UIKit/UIKit.h>


//typedef void (^cellBlock)(NSIndexPath* path);
@class QLCell;
@protocol QLCellDelegate <NSObject>
@required
-(NSString *)titleWithQLCell:(QLCell*)cell rightVindexpath:(NSIndexPath*)indexPath;
-(NSInteger)rowsCountWithQLCell:(QLCell*)cell;
-(void)QLCell:(QLCell*)cell DidSelectItemAtIndexPath:(NSIndexPath*)indexPath  rightVindexPath:(NSIndexPath*)Rindexpath;
-(void)QLCellDidScrollWithContentOffsetX:(CGFloat)Offsetx;
-(UIColor *)QLCellWithSetColabColr:(QLCell*)cell andCellIndexpath:(NSIndexPath*)path;
-(void)labTouch:(QLCell*)cell;
-(BOOL)QLCellBtnIsHiddle:(QLCell*)cell;

@end

typedef  struct delegateSelector{
    BOOL QLCellDelegate;
    BOOL QLCellDelegatePerform;
    BOOL QLCellDelegatePerform1;
    BOOL QLCellDelegatePerform2;
    BOOL QLCellDelegatePerform3;
    BOOL QLCellDelegatePerform4;
    BOOL QLCellDelegatePerform5;
    BOOL QLCellDelegatePerform6;
}delePD ;

@interface QLCell : UITableViewCell





@property (weak, nonatomic) IBOutlet UILabel *lab;
@property (weak, nonatomic) IBOutlet UICollectionView *rightV;
//
//
@property(nonatomic,assign)delePD PDStruct;
//
@property(nonatomic,weak) id <QLCellDelegate>delegate;
//
@property(nonatomic,assign)NSIndexPath* indexPath;


+(instancetype)creatCell;


    @end


