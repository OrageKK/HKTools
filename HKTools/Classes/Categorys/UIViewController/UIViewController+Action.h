//
//  UIViewController+Action.h
//  LJYNavi
//
//  Created by LJY on 16/4/7.
//  Copyright © 2016年 LJY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef UIViewController*(^creatTargetClass)(void);

@interface UIViewController (Action)

@property (nonatomic, strong) id targetParamer;
@property (nonatomic, strong) UINavigationController* preNavigationController; // when presentingViewController is UITabBarController must use preNavigationController action

/**
 *  pop
 */
- (void)popWtihTagetParamer:(id)targetParamer;
/**
 *  popToRoot
 */
- (void)popToRootWtihTagetParamer:(id)targetParamer;
/**
 *  popToViewController
 *
 *  @param array   @[AloneViewController.class]
 *  @param targetParamers   @[@"AloneViewController",targetParamer]
 */
- (void)popToViewController:(NSArray*)array andTagetParamers:(NSDictionary*)targetParamers;
- (void)popToViewControllerClass:(Class) targetClass;
- (void)popToViewController:(UIViewController *) vc;
/**
 *  delyPop
 *
 */
-(void)delyPopWithTime:(NSTimeInterval)time andTagetParamer:(id)targetParamer;
/**
 *  push
 *
 */
- (void)push:(UIViewController*) targetVC andTagetParamer:(id)targetParamer;
/**
 *  push || pop
 *
 */
- (void)showViewController:(Class)targetClass andTagetParamer:(id)targetParamer andCreatTargetClass:(creatTargetClass)creatTargetClass;
/**
 *  isExisted
 *
 */
- (BOOL)isExistedViewController:(Class)targetClass;
- (BOOL)isExistedVC:(UIViewController *) targetVC;
/**
 *  isPre
 *
 */
- (BOOL)isPreViewController:(Class)targetClass;
- (UIViewController *)preViewController;

/**
 *  dely action
 *
 */

- (void)delyWithTime:(NSTimeInterval)time withAction:(SEL) action;

/**
 *  present
 *
 *  @param targetVC      UIModalTransitionStyleCrossDissolve
 */
- (void)present:(UIViewController*) targetVC andTagetParamer:(id)targetParamer;
/**
 *  presentRoot
 *
 */
- (void)presentRoot:(UIViewController*) targetVC andTagetParamer:(id)targetParamer;
- (void)leftBarButtonItemAction:(UIBarButtonItem*) sender;
/**
 *  present
 *
 */
- (void)present:(UIViewController*) targetVC andComplation:(dispatch_block_t) complation andTagetParamer:(id)targetParamer;
/**
 *  present
 *
 *  @param trusitionStyle 展现方式
 *                        UIModalTransitionStyleCoverVertical    // 垂直上钻
 *                        UIModalTransitionStyleFlipHorizontal   // 水平翻转
 *                        UIModalTransitionStyleCrossDissolve    // 中间弹出
 *                        UIModalTransitionStylePartialCurl      // 翻页效果
 */
- (void)present:(UIViewController*) targetVC andTrnsitionStyle:(UIModalTransitionStyle) trusitionStyle andTagetParamer:(id)targetParamer;
/**
 *  present
 *
 */
- (void)present:(UIViewController*) targetVC andTrnsitionStyle:(UIModalTransitionStyle) trusitionStyle andComplation:(dispatch_block_t) complation andTagetParamer:(id)targetParamer;
@end
