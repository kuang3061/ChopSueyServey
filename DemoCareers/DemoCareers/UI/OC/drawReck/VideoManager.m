//
//  VideoManager.m
//  DemoCareers
//
//  Created by farben_cc on 16/7/19.
//  Copyright © 2016年 KCC. All rights reserved.
//

#import "VideoManager.h"
#import "VideoDrawOperation.h"
@implementation VideoManager

+ (instancetype)shareInstance {
    static VideoManager *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        _queueDictionary = [NSMutableDictionary dictionary];
        _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 30;
    }
    return self;
}

- (void)decodeVideo:(NSString *)filePath
withVideoPerDataBlock:(NewVideoBlock)block
  decodeFinishBlock:(finshVideoBlock)finishBlock{
    [self cancelOperationByFilePath:filePath];
    VideoDrawOperation *operation = [[VideoDrawOperation alloc] initDecoURL:filePath newVideoBlock:block finshVideoBlock:finishBlock];
    [self.queue addOperation:operation];
    self.queueDictionary[filePath] = operation;
}

- (void)cancelOperationByFilePath:(NSString *)filePath {
    VideoDrawOperation *operation = self.queueDictionary[filePath];
    if ([operation isCancelled]) {
        [self.queueDictionary removeObjectForKey:filePath];
        return;
    }
    
    [operation cancel];
    if ([operation isCancelled]) {
        [self.queueDictionary removeObjectForKey:filePath];
    }
}

- (void)cancelAllOperation {
    for (NSString *key in self.queueDictionary) {
        [self cancelOperationByFilePath:key];
    }
    [self.queue cancelAllOperations];
    [self.queueDictionary removeAllObjects];
}

@end
