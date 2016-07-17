//
//  PickViewController.m
//  KCCDemo
//
//  Created by farben_cc on 16/7/13.
//  Copyright © 2016年 farben_cc. All rights reserved.
//

#import "PickViewController.h"

@interface PickViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong) UIPickerView *picView;
@property (nonatomic, copy)NSArray *pickViewList;
@property (nonatomic, strong) UIButton *arcRandmBtn;
@end

@implementation PickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"- - - %ld",self.pickViewList.count);
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.arcRandmBtn];
    [self.view addSubview:self.picView];
}

#pragma mark - UIPickerViewDataSource  UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return self.pickViewList.count;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    NSArray *componentArray = self.pickViewList[component];
    return componentArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSArray *rowArray = self.pickViewList[component];
    NSString *pickTitle = rowArray[row];
    return pickTitle;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
}
#pragma mark - button click
- (void)clickArcRandmBtn:(UIButton *)sender {
    for (int component = 0; component < self.pickViewList.count; component++) {
        int todl = (int)[self.pickViewList[component] count];
        int randomNumber = arc4random()%todl;
        int oldRow = (int)[self.picView selectedRowInComponent:0];
        while (oldRow == randomNumber) {
            randomNumber = arc4random() % todl;
        }
        [self.picView selectRow:randomNumber inComponent:component animated:YES];
//        [self pickerView:nil didSelectRow:randomNumber inComponent:component];
    }
}
#pragma mark - creat UI
- (UIPickerView *)picView {
    if (!_picView) {
        _picView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-200, self.view.frame.size.width, 200)];
        _picView.delegate = self;
        _picView.dataSource = self;
        _picView.backgroundColor = [UIColor yellowColor];
    }
    return _picView;
}
- (UIButton *)arcRandmBtn {
    if (!_arcRandmBtn) {
        _arcRandmBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 100, 100)];
        _arcRandmBtn.backgroundColor = [UIColor magentaColor];
        [_arcRandmBtn addTarget:self action:@selector(clickArcRandmBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:_arcRandmBtn];
    }
    return _arcRandmBtn;
}
- (NSArray *)pickViewList {
    if (!_pickViewList) {
        NSString *arrayPath = [[NSBundle mainBundle] pathForResource:@"pickerList" ofType:@"plist"];
        NSArray *foodArray = [NSArray arrayWithContentsOfFile:arrayPath];
        _pickViewList = foodArray;
    }
    return _pickViewList;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
