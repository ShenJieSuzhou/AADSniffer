//
//  SnailQRCode.m
//  SnailQRCode
//
//  Created by silicon on 17/5/8.
//  Copyright © 2017年 com.snailgames. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SnailQRCode.h"
#import "SGQRCodeScanningVC.h"
#import "SGQRCode.h"
#import "SGQRCodeConst.h"
@interface SnailQRCode ()

@end


@implementation SnailQRCode

+ (SnailQRCode *)getInstance{
    static SnailQRCode *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    
    return instance;
}

- (void)startScanQRCode:(UIViewController *)rootViewCtrl{
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        SGQRCodeScanningVC *vc = [[SGQRCodeScanningVC alloc] init];
                        [rootViewCtrl presentViewController:vc animated:NO completion:^{
                            
                        }];
                    });
                    
                    SGQRCodeLog(@"当前线程 - - %@", [NSThread currentThread]);
                    // 用户第一次同意了访问相机权限
                    SGQRCodeLog(@"用户第一次同意了访问相机权限");
                } else {
                    // 用户第一次拒绝了访问相机权限
                    SGQRCodeLog(@"用户第一次拒绝了访问相机权限");
                }
            }];
        } else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
            SGQRCodeScanningVC *vc = [[SGQRCodeScanningVC alloc] init];
            [rootViewCtrl presentViewController:vc animated:NO completion:^{
                
            }];
        } else if (status == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
            NSLog(@"请打开相机访问权限开关");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SnailQRCodeStatusDenied" object:@"请打开相机访问权限开关"];
            
        } else if (status == AVAuthorizationStatusRestricted) {
            NSLog(@"因为系统原因, 无法访问相册");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SnailQRCodeStatusDenied" object:@"因为系统原因, 无法访问相册"];

        }
    } else {
        NSLog(@"未检测到您的摄像头");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SnailQRCodeStatusDenied" object:@"未检测到您的摄像头"];
    }
}

@end
