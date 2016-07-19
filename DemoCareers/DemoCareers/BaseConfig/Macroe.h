//
//  Macroe.h
//  KCCDemo
//
//  Created by farben_cc on 16/6/27.
//  Copyright © 2016年 farben_cc. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#ifndef Macroe_h
#define Macroe_h

#define RGBA(R,G,B,A) [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]

#define KDevWidth  [[UIScreen mainScreen] bounds].size.width
#define KDevHeight [[UIScreen mainScreen] bounds].size.height

typedef void(^NewVideoBlock)(CGImageRef imageRef, NSString *fileURL);
typedef void(^finshVideoBlock)(NSString *path);

#endif /* Macroe_h */
