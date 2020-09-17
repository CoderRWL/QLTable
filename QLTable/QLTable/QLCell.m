//
//  QLCell.m
//  initVC
//
//  Created by lrw on 2016/12/22.
//  Copyright © 2016年 lrw. All rights reserved.
//

#import "QLCell.h"
#import "QLCocell.h"


@interface QLCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
//
@property(nonatomic,assign)BOOL drag;
//
@property(nonatomic,assign)NSIndexPath *selectPath;
@end

@implementation QLCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UICollectionViewFlowLayout *layout1 =[[UICollectionViewFlowLayout alloc]init];
    layout1.itemSize=CGSizeMake(80, self.lab.bounds.size.height);
    layout1.scrollDirection= UICollectionViewScrollDirectionHorizontal;
    layout1.minimumLineSpacing=0;
    layout1.minimumInteritemSpacing = 0;
    self.rightV.collectionViewLayout=layout1;
    self.rightV.showsVerticalScrollIndicator = NO;
    self.rightV.showsHorizontalScrollIndicator = NO;
    self.rightV.delegate=self;
    self.rightV.dataSource=self;
    [self.rightV registerNib:[UINib nibWithNibName:NSStringFromClass([QLCocell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"co"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labTouch:)];
    self.lab.userInteractionEnabled = YES;
    [self.lab addGestureRecognizer:tap];
}

+(instancetype)creatCell{
    return  [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self ) owner:nil options:nil].firstObject;
//    UINib *nib =[UINib nibWithNibName:NSStringFromClass(self) bundle:nil];
//    return [nib instantiateWithOwner:nil options:nil].lastObject;
}

-(void)labTouch:(QLCell*)cell{
    if (_PDStruct.QLCellDelegatePerform5) {
        [_delegate labTouch:self];
    }
}

#pragma mark --collection view代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_PDStruct.QLCellDelegatePerform1) {
        return [_delegate rowsCountWithQLCell:self];
    }else{
    return 10;
    }
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    QLCocell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"co" forIndexPath:indexPath];
    if (_PDStruct.QLCellDelegatePerform) {
        NSString *text = [_delegate titleWithQLCell:self  rightVindexpath:indexPath];
        cell.coLab.text = text;
    }else{
        cell.coLab.text =[NSString stringWithFormat:@"%ld",(long)indexPath.item];
    }
    if (_PDStruct.QLCellDelegatePerform4) {
        cell.coLab.backgroundColor = [_delegate QLCellWithSetColabColr:self andCellIndexpath:self.indexPath];
        if (cell.coLab.backgroundColor == [UIColor blackColor]) {
            cell.coLab.textColor = [UIColor whiteColor];
        }else{
            cell.coLab.textColor = [UIColor blackColor];
        }
    }
    if (_PDStruct.QLCellDelegatePerform6) {
        
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_PDStruct.QLCellDelegatePerform2) {
        [_delegate QLCell:self DidSelectItemAtIndexPath:self.indexPath rightVindexPath:indexPath];
    }
    _selectPath = indexPath;
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _drag = YES;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _drag = NO;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
        if (_PDStruct.QLCellDelegatePerform3 && _drag ==YES ) {
            [_delegate QLCellDidScrollWithContentOffsetX:scrollView.contentOffset.x];
        }
}

-(void)setDelegate:(id<QLCellDelegate>)delegate{
    _delegate = delegate;
    if (_delegate) {
        _PDStruct.QLCellDelegate = true;
        if ([_delegate respondsToSelector:@selector(titleWithQLCell:rightVindexpath:)]) {
            _PDStruct.QLCellDelegatePerform = true;
        }
        if ([_delegate respondsToSelector:@selector(rowsCountWithQLCell:)]) {
            _PDStruct.QLCellDelegatePerform1 = true;
        }
        if ([_delegate respondsToSelector:@selector(QLCell: DidSelectItemAtIndexPath: rightVindexPath:)]) {
            _PDStruct.QLCellDelegatePerform2 = true;
        }
        if ([_delegate respondsToSelector:@selector(QLCellDidScrollWithContentOffsetX:)]) {
            _PDStruct.QLCellDelegatePerform3 = true;
        }
        if ([_delegate respondsToSelector:@selector(QLCellWithSetColabColr: andCellIndexpath:)]) {
            _PDStruct.QLCellDelegatePerform4 = true;
        }
        if ([_delegate respondsToSelector:@selector(labTouch:)]) {
            _PDStruct.QLCellDelegatePerform5 = true;
        }
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



@end
