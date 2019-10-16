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
 * @param time 倒计时
 * @param oldTitle 旧title
 * @param titleColor 文字颜色
 */

- (void)setTitleCountdownDisplayTime:(NSInteger)time
                        WithOldTitle:(NSString *)oldTitle
                          titleColor:(UIColor *)titleColor;
/**
* 设置按钮的标题倒计时 带背景
* @param time 倒计时
* @param oldTitle 旧title
* @param bgcolor 背景颜色
* @param titleColor 文字颜色
*/

- (void)setTitleCountdownDisplayTime:(NSInteger)time
                        WithOldTitle:(NSString *)oldTitle
                 WithBackgroundColor:(UIColor *)bgcolor
                          titleColor:(UIColor *)titleColor;
@end
