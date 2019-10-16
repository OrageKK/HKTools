//
//  UIButton+timer.m
//  MOIE_KJB_IOS
//
//  Created by apple on 2017/4/11.
//  Copyright © 2017年 moie. All rights reserved.
//

#import "UIButton+timer.h"

@implementation UIButton (timer)

#pragma mark - 设置按钮倒计时

- (void)setTitleCountdownDisplayWithOldTitle:(NSString *)oldTitle{
    
    UIFont *oldFont = self.titleLabel.font;
    UIColor *oldColor = self.titleLabel.textColor;
    
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self setTitle:oldTitle forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
                self.titleLabel.font = oldFont;
                self.alpha = 1.f;
                [self setTitleColor:oldColor forState:UIControlStateNormal];
            });
        }else{
            int seconds = timeout % 120;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [self setTitle:[NSString stringWithFormat:@"%@秒",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                self.userInteractionEnabled = NO;
                self.alpha = 0.5;
               // self.titleLabel.font = [UIFont systemFontOfSize:oldFont.pointSize];
                [self setTitleColor:[UIColor colorWithRGB:0x0D95FF] forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
}
- (void)setTitleCountdownDisplayWithOldTitle:(NSString *)oldTitle WithBackgroundColor:(UIColor *)bgcolor titleColor:(UIColor *)titleColor{
    
    UIFont *oldFont = self.titleLabel.font;
    UIColor *oldColor = self.titleLabel.textColor;
    UIColor *oldBgColor = self.backgroundColor;
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self setTitle:oldTitle forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
                self.titleLabel.font = oldFont;
                self.alpha = 1.f;
                [self setTitleColor:oldColor forState:UIControlStateNormal];
                self.backgroundColor = oldBgColor;
            });
        }else{
            int seconds = timeout % 120;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [self setTitle:[NSString stringWithFormat:@"%@秒",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                self.userInteractionEnabled = NO;
                self.alpha = 0.5;
                // self.titleLabel.font = [UIFont systemFontOfSize:oldFont.pointSize];
                [self setTitleColor:titleColor forState:UIControlStateNormal];
                self.backgroundColor = bgcolor;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
}
@end
