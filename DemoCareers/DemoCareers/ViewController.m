//
//  ViewController.m
//  KCCDemo
//
//  Created by farben_cc on 16/6/21.
//  Copyright © 2016年 farben_cc. All rights reserved.
//

#import "ViewController.h"
#import "Macroe.h"
#import "UIRotemController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, copy)   NSArray *luaghArray;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 解析这段字符
    // @"<html></html>您好，在您完成<button url='http://pws.paic.com.cn/m/?module=paehome'>注册及实名认证</button>之后，系统<button url='http://baidu.com/?module=paehome'>登录</button>会给予一定积分奖励。今后您也可以参加<I>普惠推出的各种积分奖励活动</I>。所有奖励的活动积分将会在第二天进入您的账户< img src='http://pws.paic.com/eg tulip.jpg'></img>";
    self.view.backgroundColor = RGBA(120, 120, 120, 1);
    [self.view addSubview:self.tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.luaghArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdent = @"cellIdentfi";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text = [self.luaghArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.hidesBottomBarWhenPushed = YES;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            UIRotemController *roter = [[UIRotemController alloc] init];
            [self.navigationController pushViewController:roter animated:YES];
        }
            break;
        case 1:
        {
            
        }
            break;
            
        default:
            break;
    }
    self.hidesBottomBarWhenPushed = NO;
}
#pragma mark - getMoth
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KDevWidth, KDevHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (NSArray *)luaghArray {
    if (_luaghArray == nil) {
        _luaghArray = @[@"OC",@"Swift"];
    }
    return _luaghArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
