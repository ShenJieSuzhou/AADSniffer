//
//  AlphaMaskViewController.m
//  SnailQRCode
//
//  Created by silicon on 17/5/11.
//  Copyright © 2017年 com.snailgames. All rights reserved.
//

#import "AlphaMaskViewController.h"

@interface AlphaMaskViewController ()

@end

@implementation AlphaMaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        SGQRCodeScanningVC *vc = [[SGQRCodeScanningVC alloc] init];
                        [self presentViewController:vc animated:NO completion:^{
                            
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
            [self presentViewController:vc animated:NO completion:^{
                
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//支持旋转
-(BOOL)shouldAutorotate{
    return YES;
}


//支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeLeft;
}

//一开始的方向  很重要
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationLandscapeLeft;
}

@end
