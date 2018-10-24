//
//  SnailQRCode.h
//  SnailQRCode
//
//  Created by silicon on 17/5/8.
//  Copyright © 2017年 com.snailgames. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
//! Project version number for SnailQRCode.
FOUNDATION_EXPORT double SnailQRCodeVersionNumber;

//! Project version string for SnailQRCode.
FOUNDATION_EXPORT const unsigned char SnailQRCodeVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <SnailQRCode/PublicHeader.h>


@interface SnailQRCode : NSObject

+ (SnailQRCode *)getInstance;

- (void)startScanQRCode:(UIViewController *)rootViewCtrl;

@end
