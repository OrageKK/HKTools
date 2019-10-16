//
//  UIView+Borde.h
//  New_Panda
//
//  Created by 黄坤 on 2017/12/20.
//  Copyright © 2017年 Susan's mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Borde)
- (void)setBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width;
@end
