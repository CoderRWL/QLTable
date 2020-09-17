//
//  ViewController.m
//  QLTable
//
//  Created by RWLi on 2020/9/18.
//  Copyright © 2020  RWLi. All rights reserved.
//

#import "ViewController.h"
#import "QLTable.h"

@interface ViewController ()<QLTableDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    QLTable *tab = [[QLTable alloc]initWithFrame:CGRectMake(0, 100, 414,700) style:UITableViewStylePlain];
    tab.qlDelegate = self;
    [self.view addSubview:tab];
    
}


#pragma mark -QLTableDelegate

- (QLCellModle *)titleModelForHeaderOftableView:(UITableView *)tableView{
    
    QLCellModle *titleModel  = [[QLCellModle alloc]init];
    titleModel.leftTitle = @"名称";
    titleModel.rightTitles = @[@"item1",@"item2",@"item3",@"item4",@"item5",@"item6",@"item7",@"item8",@"item9",@"item10",].mutableCopy;
    
    return titleModel;
}

- (NSArray<QLCellModle *> *)contentFortableView:(UITableView *)tableView{
    
    NSMutableArray *contents = @[].mutableCopy;
    for (int i= 0; i< 20; i++) {
        QLCellModle *model = [[QLCellModle alloc]init];
        model.leftTitle = [NSString stringWithFormat:@"left%d",i];
        
        for (int j =0; j<10; j++) {
            [model.rightTitles addObject:[NSString stringWithFormat:@"right%d-%d",i,j]];
        }
        [contents addObject:model];
    }
    
    return contents;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

@end
