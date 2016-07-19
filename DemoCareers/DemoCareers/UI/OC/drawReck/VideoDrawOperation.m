//
//  VideoDrawOperation.m
//  DemoCareers
//
//  Created by farben_cc on 16/7/18.
//  Copyright © 2016年 KCC. All rights reserved.
//

#import "VideoDrawOperation.h"
#import <AVFoundation/AVFoundation.h>

@interface VideoDrawOperation ()
@property (nonatomic, strong) NSString *path;
@property (nonatomic, copy)NewVideoBlock newVideoBlock;
@property (nonatomic, copy)finshVideoBlock finshVideoBlock;
@end

@implementation VideoDrawOperation

- (instancetype)initDecoURL:(NSString *)path newVideoBlock:(NewVideoBlock)newVideoBlock finshVideoBlock:(finshVideoBlock)finshBlock {
    if (self = [super init]) {
        _path = path;
        _newVideoBlock = newVideoBlock;
        _finshVideoBlock = finshBlock;
    }
    return self;
}
/**
 *  operation main meth
 * 把NSOperation交给队列去维护，只需要实现main方法就行了，但是你如果想要手动去控制这个线程(启动。。。)，需要自己调用start方法，但是这样是不安全的，因为若 没有获得充分资源，而此时你调用start方法，就会抛出异常。这是官方文档里面说的 ;start启动方法的话会引起  queue count 的不断增加，但是 从main 里面启动就没有。实现main方法, 线程串行执行; 实现start方法, 线程并发执行
 */
- (void)main {
    
    @autoreleasepool {
        if (self.isCancelled) {
            _newVideoBlock = nil;
            _finshVideoBlock = nil;
            return;
        }
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[[NSURL alloc] initFileURLWithPath:self.path] options:nil];
        NSError *error;
        AVAssetReader *reader = [[AVAssetReader alloc] initWithAsset:asset error:&error];
        if (error) {
            return;
        }
        NSArray *videoTrcks = [asset tracksWithMediaType:AVMediaTypeVideo];
        AVAssetTrack *track = [videoTrcks objectAtIndex:0];
        
        int m_pixlFrameType = kCVPixelFormatType_32BGRA;
        
        NSDictionary *operation = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:m_pixlFrameType] forKey:(id)kCVPixelBufferPixelFormatTypeKey];
        
        AVAssetReaderTrackOutput *trackOutput = [[AVAssetReaderTrackOutput alloc] initWithTrack:track outputSettings:operation];
        [reader addOutput:trackOutput];
        [reader startReading];
        
        if (self.cancelled) {
            _newVideoBlock = nil;
            _finshVideoBlock = nil;
            return;
        }
        while ([reader status] == AVAssetReaderStatusReading && track.nominalFrameRate > 0) {
            if (self.cancelled) {
                _newVideoBlock = nil;
                _finshVideoBlock = nil;
                return;
            }
            CMSampleBufferRef sampleBuffer = [trackOutput copyNextSampleBuffer];
            CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
            CVPixelBufferLockBaseAddress(imageBuffer, 0);
            size_t byteyPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
            size_t width = CVPixelBufferGetWidth(imageBuffer);
            size_t height = CVPixelBufferGetHeight(imageBuffer);
            
            char *pixle = CVPixelBufferGetBaseAddress(imageBuffer);
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGContextRef context = CGBitmapContextCreate(pixle, width, height, 8, byteyPerRow, colorSpace, kCGBitmapByteOrder32Little|kCGImageAlphaPremultipliedFirst);
            if (context != NULL) {
                CGImageRef imageRef = CGBitmapContextCreateImage(context);
                CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
                CGColorSpaceRelease(colorSpace);
                CGContextRelease(context);
                size_t width = CGImageGetWidth(imageRef);
                size_t heiht = CGImageGetHeight(imageRef);
                size_t bitPerComponent = CGImageGetBitsPerComponent(imageRef);
                size_t bytesPerRow = 0;
                CGColorSpaceRef colorSpa = CGColorSpaceCreateDeviceRGB();
                CGColorSpaceModel spaceModel = CGColorSpaceGetModel(colorSpa);
                CGBitmapInfo bitInfo = CGImageGetBitmapInfo(imageRef);
                if (spaceModel == kCGColorSpaceModelRGB) {
                    uint32_t alpha = (bitInfo & kCGBitmapAlphaInfoMask);
                    if (alpha == kCGImageAlphaNone) {
                        bitInfo &= ~kCGBitmapAlphaInfoMask;
                        bitInfo |= kCGImageAlphaNoneSkipFirst;
                    } else if (!(alpha == kCGImageAlphaNoneSkipFirst || alpha == kCGImageAlphaNoneSkipLast)) {
                        bitInfo &= ~kCGBitmapAlphaInfoMask;
                        bitInfo |= kCGImageAlphaPremultipliedFirst;
                    }
                }
                CGContextRef context = CGBitmapContextCreate(NULL, width, heiht, bitPerComponent, bytesPerRow, colorSpa, bitInfo);
                CGColorSpaceRelease(colorSpa);
                if (!context) {
                    if (self.newVideoBlock) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (self.cancelled) {
                                _newVideoBlock= nil;
                                _finshVideoBlock = nil;
                                return;
                            }
                            self.newVideoBlock(imageRef,self.path);
                            CGImageRelease(imageRef);
                            
                        });
                    }
                }else{
                    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, width, heiht), imageRef);
                    CGImageRef inflatedImageRef = CGBitmapContextCreateImage(context);
                    CGContextRelease(context);
                    if (self.newVideoBlock) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (self.newVideoBlock) {
                                _newVideoBlock = nil;
                                _finshVideoBlock = nil;
                                return;
                            }
                            self.newVideoBlock(inflatedImageRef,self.path);
                            CGImageRelease(inflatedImageRef);
                        });
                    }
                    CGImageRelease(imageRef);
                }
                if(sampleBuffer) {
                    CMSampleBufferInvalidate(sampleBuffer);
                    CFRelease(sampleBuffer);
                    sampleBuffer = NULL;
                    
                } else {
                    break;
                }
            }
            [NSThread sleepForTimeInterval:CMTimeGetSeconds(track.minFrameDuration)];
        }
        if (self.cancelled) {
            _newVideoBlock = nil;
            _finshVideoBlock = nil;
            return;
        }
        if (self.finshVideoBlock) {
            self.finshVideoBlock(self.path);
        }
    }
    
}

@end
