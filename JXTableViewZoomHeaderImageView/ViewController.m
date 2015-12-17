//
//  ViewController.m
//  JXTableViewZoomHeaderImageView
//
//  Created by jiaxin on 15/12/17.
//  Copyright © 2015年 jiaxin. All rights reserved.
//

#import "ViewController.h"
#import "ZoomHeaderView.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) ZoomHeaderView *headerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
    //没有约束
//    ZoomHeaderView *headerView = [[ZoomHeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300) type:ZoomHeaderViewTypeNoConstraint];
    //代码约束
//    ZoomHeaderView *headerView = [[ZoomHeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300) type:ZoomHeaderViewTypeCodeConstraint];
    //xib约束
    ZoomHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"ZoomHeaderView" owner:nil options:nil] lastObject];
    tableView.tableHeaderView = headerView;
    self.headerView = headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"index--%ld",(long)indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    [self.headerView updateHeaderImageViewFrameWithOffsetY:offsetY];
}

@end
