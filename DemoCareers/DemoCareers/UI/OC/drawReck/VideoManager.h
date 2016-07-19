//
//  VideoManager.h
//  DemoCareers
//
//  Created by farben_cc on 16/7/19.
//  Copyright © 2016年 KCC. All rights reserved.
//

#import <Foundation/Foundation.h>
//@class VideoDrawOperation;
#import "Macroe.h"
@interface VideoManager : NSObject

@property (nonatomic, strong) NSMutableDictionary *queueDictionary;
@property (nonatomic, strong) NSOperationQueue *queue;

+ (instancetype)shareInstance;

- (void)decodeVideo:(NSString *)filePath
withVideoPerDataBlock:(NewVideoBlock)block
  decodeFinishBlock:(finshVideoBlock)finishBlock;

- (void)cancelOperationByFilePath:(NSString *)filePath;

- (void)cancelAllOperation;

@end
