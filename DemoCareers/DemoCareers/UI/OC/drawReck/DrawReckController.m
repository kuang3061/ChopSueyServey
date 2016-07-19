//
//  DrawReckController.m
//  DemoCareers
//
//  Created by farben_cc on 16/7/15.
//  Copyright © 2016年 KCC. All rights reserved.
//

#import "DrawReckController.h"
#import "DemoDrawReck.h"
#import "Macroe.h"
#import "VideoManager.h"
@implementation DrawReckController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DemoDrawReck *draw = [[DemoDrawReck alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)];
    draw.backgroundColor = RGBA(99, 99, 99, 1);
    [self.view addSubview:draw];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"testVideo" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    
    VideoManager *videoM = [[VideoManager shareInstance] decodeVideo:url withVideoPerDataBlock:^(CGImageRef imageRef, NSString *fileURL) {
        
    } decodeFinishBlock:^(NSString *path) {
        
    }];
    
}

@end
