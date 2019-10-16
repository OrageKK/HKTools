//
//  UIViewController+Modal.m
//  iComeKernel
//
//  Created by 黄坤 on 2019/10/15.
//  Copyright © 2019 XZWL. All rights reserved.
//

#import "UIViewController+Modal.h"


@implementation UIViewController (Modal)
// 适配iOS13
- (UIModalPresentationStyle)modalPresentationStyle {
    return UIModalPresentationFullScreen;
}
@end
