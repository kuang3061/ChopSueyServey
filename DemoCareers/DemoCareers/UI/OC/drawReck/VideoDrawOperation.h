//
//  VideoDrawOperation.h
//  DemoCareers
//
//  Created by farben_cc on 16/7/18.
//  Copyright © 2016年 KCC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Macroe.h"
//typedef void (^NewVideoBlock)(CGImageRef *imageRef,NSString *fileUrl);

//typedef void(^NewVideoBlock)(CGImageRef imageRef, NSString *fileURL);
//typedef void(^finshVideoBlock)(NSString *path);

@interface VideoDrawOperation : NSOperation

- (instancetype)initDecoURL:(NSString *)path
              newVideoBlock:(NewVideoBlock)newVideoBlock
              finshVideoBlock:(finshVideoBlock)finshBlock;

@end
