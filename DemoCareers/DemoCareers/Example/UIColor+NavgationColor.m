//
//  UIColor+NavgationColor.m
//  DemoCareers
//
//  Created by farben_cc on 16/7/15.
//  Copyright © 2016年 KCC. All rights reserved.
//

#import "UIColor+NavgationColor.h"

@implementation UIColor (NavgationColor)

- (UIImage *)navgationSetBackImage {
    UIGraphicsBeginImageContext(CGSizeMake(1, 1));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddRect(context, CGRectMake(0, 0, 1, 1));
    [self set];
    CGContextFillPath(context);
    UIImage *grahocsImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return grahocsImage;
}

@end
