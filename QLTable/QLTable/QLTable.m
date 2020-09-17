//
//  QLTable.m
//  QLTable
//
//  Created by RWLi on 2020/9/18.
//  Copyright © 2020  RWLi. All rights reserved.
//

#import "QLTable.h"
#import "QLCell.h"

#define headerHeight (60)
#define cellHeight   (50)

@interface QLTable ()<UITableViewDelegate,UITableViewDataSource,QLCellDelegate>
@property(nonatomic,strong) NSArray*  contents;
@property(nonatomic,assign)CGPoint initOffset;
@property(nonatomic,strong)QLCell *headerV;
@property(nonatomic,strong) QLCellModle  *titleItem;
@end

@implementation QLTable

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        [self selfInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self selfInit];
    }
    return self;
}

-(void)selfInit{
    self.separatorStyle= UITableViewCellSeparatorStyleNone;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.dataSource = self;
    self.delegate = self;
    [self registerNib:[UINib nibWithNibName:NSStringFromClass([QLCell class]) bundle:nil] forCellReuseIdentifier:@"qlcell"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_qlDelegate) {
        _contents = [_qlDelegate contentFortableView:tableView];
        return _contents.count;
    }
    
    return 0;
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row >= _contents.count) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"errorCell"];
        if (!cell) {
            return [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"errorCell"];
        }
        return cell;
    }
    
    QLCell *cell=[tableView dequeueReusableCellWithIdentifier:@"qlcell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    QLCellModle *cellItem = self.contents[indexPath.row];
    cell.lab.text= cellItem.leftTitle;
    cell.delegate = self;
    cell.indexPath = indexPath;
    cell.rightV.contentOffset = _initOffset;
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return cellHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return headerHeight;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self tabvHeader];
}

-(UIView *)tabvHeader{
    if (_headerV) {
        return _headerV;
    }
    
    
    _headerV = [QLCell creatCell];
    _headerV.frame = CGRectMake(0, 0, 0,headerHeight );
    
    if (_qlDelegate) {
        _titleItem = [_qlDelegate titleModelForHeaderOftableView:self];
        _headerV.lab.text= _titleItem.leftTitle;
        _headerV.delegate = self;
        
    }
   
    return _headerV;
   }


#pragma mark-- QLCellDelegate
-(NSString *)titleWithQLCell:(QLCell *)cell rightVindexpath:(NSIndexPath *)indexPath {
    if (cell== _headerV) {
        return self.titleItem.rightTitles[indexPath.row];
    }else{
    QLCellModle *cellItem = self.contents[cell.indexPath.row];
    return  cellItem.rightTitles[indexPath.row];
    }
    return @"";
}

-(NSInteger)rowsCountWithQLCell:(QLCell *)cell{
    QLCellModle *m = nil;
    if (cell == _headerV) {
        m = self.titleItem;
    }else{
    m = self.contents[cell.indexPath.row];
    }
    return m.rightTitles.count;
}


-(void)labTouch:(QLCell*)cell{
    if (_qlDelegate) {
        [_qlDelegate tableView:self didSelectRowAtIndexPath:[self indexPathForCell:cell]];
    }
}

-(void)QLCell:(QLCell *)cell DidSelectItemAtIndexPath:(NSIndexPath *)indexPath rightVindexPath:(NSIndexPath *)Rindexpath{
    if (_qlDelegate) {
        [_qlDelegate tableView:self didSelectRowAtIndexPath:indexPath];
    }
}


-(void)QLCellDidScrollWithContentOffsetX:(CGFloat)Offsetx{
    _initOffset = CGPointMake(Offsetx, 0);
    [self setTabOffset:_initOffset];
}

-(void)setTabOffset:(CGPoint)offset{
    for (QLCell *cell in self.visibleCells) {
        cell.rightV.contentOffset = offset;
    }
    _headerV.rightV.contentOffset = offset;
}


@end
