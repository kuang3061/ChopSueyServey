//
//  DemoDrawReck.m
//  DemoCareers
//
//  Created by farben_cc on 16/7/15.
//  Copyright © 2016年 KCC. All rights reserved.
//

#import "DemoDrawReck.h"
#import "Macroe.h"

@implementation DemoDrawReck


- (void)drawRect:(CGRect)rect {
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    /*
     * 画线
     CGContextMoveToPoint(contextRef, 20, 20);
     CGContextAddLineToPoint(contextRef, 200, 20);
     CGContextSetRGBStrokeColor(contextRef, 98, 98, 98, 1);
     CGContextStrokePath(contextRef);
     */
    
    CGContextSetLineWidth(contextRef, 1.0f);
    UIFont *font = [UIFont boldSystemFontOfSize:18.0f];
    NSString *string = @"卡机的开发及打啊水电费来看卡戴珊就发了看见的佛IQ无头日埃里克森金佛求气温就请假卡房间啊可怜我姐夫刻录机费轻微天气我去哦我无人请肥 啊来萨克的减肥 啊来卡死的叫法";
    CGSize size1 = [string boundingRectWithSize:CGSizeMake(self.frame.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|
                    NSStringDrawingUsesFontLeading|
                    NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:font} context:nil].size;
    CGFloat height = size1.height;
    [string drawInRect:CGRectMake(10, 30, self.frame.size.width-20, height) withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:RGBA(88, 88, 88, 1),NSBackgroundColorAttributeName:RGBA(100, 100, 100, 1)}];
    NSLog(@"%@\n%@",NSStringFromCGRect(self.frame),NSStringFromCGSize(size1));
    
}


@end
