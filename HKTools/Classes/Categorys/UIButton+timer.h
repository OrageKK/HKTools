//
//  UIButton+timer.h
//  MOIE_KJB_IOS
//
//  Created by apple on 2017/4/11.
//  Copyright © 2017年 moie. All rights reserved.
//

#import <UIKit/UIKit.h>

// 按钮倒计时

@interface UIButton (timer)

/**
 * 设置按钮的标题倒计时
 */

- (void)setTitleCountdownDisplayWithOldTitle:(NSString *)oldTitle;
- (void)setTitleCountdownDisplayWithOldTitle:(NSString *)oldTitle WithBackgroundColor:(UIColor *)bgcolor titleColor:(UIColor *)titleColor;
@end
