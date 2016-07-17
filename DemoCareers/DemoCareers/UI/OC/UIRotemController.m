//
//  UIRotemController.m
//  KCCDemo
//
//  Created by farben_cc on 16/7/13.
//  Copyright © 2016年 farben_cc. All rights reserved.
//

#import "UIRotemController.h"
#import "PickViewController.h"
#import "DrawReckController.h"


@interface UIRotemController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *rotemTableView;
@property (nonatomic, copy) NSArray *rotemListArray;
@end


@implementation UIRotemController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.rotemTableView];
}
#pragma mark - UITableViewDelegate UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.rotemListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *indenCell = @"indenCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indenCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indenCell];
    }
    cell.textLabel.text = [self.rotemListArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.hidesBottomBarWhenPushed = YES;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            PickViewController *picker = [[PickViewController alloc] init];
            [self.navigationController pushViewController:picker animated:YES];
        }
            break;
        case 1:
        {
            DrawReckController *draw = [[DrawReckController alloc] init];
            [self.navigationController pushViewController:draw animated:YES];
        }
            break;
            
        default:
            break;
    }
    self.hidesBottomBarWhenPushed = NO;
}

- (UITableView *)rotemTableView {
    if (!_rotemTableView) {
        _rotemTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _rotemTableView.delegate = self;
        _rotemTableView.dataSource = self;
    }
    return _rotemTableView;
}
- (NSArray *)rotemListArray {
    if (!_rotemListArray) {
        _rotemListArray = @[@"UIPickerView",@"DrawReckController"];
    }
    return _rotemListArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
