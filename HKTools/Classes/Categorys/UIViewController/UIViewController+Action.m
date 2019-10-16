//
//  UIViewController+Action.m
//  LJYNavi
//
//  Created by LJY on 16/4/7.
//  Copyright © 2016年 LJY. All rights reserved.
//

#import "UIViewController+Action.h"

@implementation UIViewController (Action)

static char targetParamerKey;
static char preNavigationControllerKey;

- (void)setTargetParamer:(id)targetParamer
{
    objc_setAssociatedObject(self, &targetParamerKey, targetParamer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
- (id)targetParamer
{
    return objc_getAssociatedObject(self, &targetParamerKey);
}

- (void)setPreNavigationController:(UINavigationController *)preNavigationController
{
    objc_setAssociatedObject(self, &preNavigationControllerKey, preNavigationController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UINavigationController *)preNavigationController
{
    return objc_getAssociatedObject(self, &preNavigationControllerKey);
}
#pragma mark push
- (void)popWtihTagetParamer:(id)targetParamer
{
    UINavigationController* navC = (UINavigationController*)([self isKindOfClass:UINavigationController.class] ? self : self.navigationController);
    
    if (targetParamer)
    {
        UIViewController* targetVC = navC.viewControllers[navC.viewControllers.count - 2];
        targetVC.targetParamer = targetParamer;
        
    }
    
    [navC popViewControllerAnimated:YES];
}

- (void)popToRootWtihTagetParamer:(id)targetParamer
{
    UINavigationController* navC = (UINavigationController*)([self isKindOfClass:UINavigationController.class] ? self : self.navigationController);
    
    if (targetParamer)
    {
        UIViewController* targetVC = navC.viewControllers[0];
        targetVC.targetParamer = targetParamer;
    }
    
    [navC popToRootViewControllerAnimated:YES];
}
- (void)popToViewController:(UIViewController*) targetVC andTagetParamer:(id)targetParamer
{
    UINavigationController* navC = (UINavigationController*)([self isKindOfClass:UINavigationController.class] ? self : self.navigationController);
    targetVC.targetParamer = targetParamer;
    //   加速1毫秒
    dispatch_async(dispatch_get_main_queue(), ^{
        [navC popToViewController:targetVC animated:YES];
    });
    
}
- (void)popToViewController:(NSArray*)array andTagetParamers:(NSDictionary*)targetParamers
{
    
    for (id item in array)
    {
        
        Class targetClass = nil;
        if ([item respondsToSelector:@selector(alloc)])
        {
            targetClass = item;
        }
        else
        {
            // do nothing
        }
        
        if (!targetClass)
        {
            continue;
        }
        else
        {
            
            UINavigationController* navC = (UINavigationController*)([self isKindOfClass:UINavigationController.class] ? self : self.navigationController);
            for (UIViewController *vc in navC.viewControllers)
            {
                
                if ([vc isKindOfClass:targetClass])
                {
                    [navC popToViewController:vc andTagetParamer:targetParamers[NSStringFromClass(vc.class)]];
                    return;
                }
            }
        }
        
    }
    
}

- (void)popToViewControllerClass:(Class) targetClass
{
    
    if ([targetClass respondsToSelector:@selector(alloc)])
    {
        UINavigationController* navC = (UINavigationController*)([self isKindOfClass:UINavigationController.class] ? self : self.navigationController);
        for (UIViewController *vc in navC.viewControllers)
        {
            
            if ([vc isKindOfClass:targetClass])
            {
                [navC popToViewController:vc animated:YES];
                return;
            }
        }
    }
    else
    {
        // do nothing
    }
    
}

- (void)popToViewController:(UIViewController *) vc
{
     UINavigationController* navC = (UINavigationController*)([self isKindOfClass:UINavigationController.class] ? self : self.navigationController);
    if ([self isExistedVC:vc])
    {
        [navC popToViewController:vc animated:YES];
    }
    else
    {
        // do nothing
    }
}


-(void)delyPopWithTime:(NSTimeInterval)time andTagetParamer:(id)targetParamer
{
    
    [self performSelector:@selector(popWtihTagetParamer:) withObject:targetParamer afterDelay:time];
}

- (void)push:(UIViewController*) targetVC andTagetParamer:(id)targetParamer
{
    UINavigationController* navC = (UINavigationController*)([self isKindOfClass:UINavigationController.class] ? self : self.navigationController);
    targetVC.targetParamer = targetParamer;
    //   加速1毫秒
    dispatch_async(dispatch_get_main_queue(), ^{
        [navC pushViewController:targetVC animated:YES];
    });
    
}

- (void)showViewController:(Class)targetClass andTagetParamer:(id)targetParamer andCreatTargetClass:(creatTargetClass)creatTargetClass
{
    
    UINavigationController* navC = (UINavigationController*)([self isKindOfClass:UINavigationController.class] ? self : self.navigationController);
    BOOL hasVC = false;
    for (UIViewController *vc in navC.viewControllers)
    {
        
        if ([vc isKindOfClass:targetClass])
        {
            [navC popToViewController:vc andTagetParamer:targetParamer];
            hasVC = true;
        }
        
    }
    
    if (hasVC == false) [navC push:creatTargetClass() andTagetParamer:targetParamer];
}

- (BOOL)isExistedViewController:(Class)targetClass
{
    UINavigationController* navC = (UINavigationController*)([self isKindOfClass:UINavigationController.class] ? self : self.navigationController);
    for (UIViewController *vc in navC.viewControllers)
        if ([vc isKindOfClass:targetClass]) return YES;
    return NO;
}

- (BOOL)isExistedVC:(UIViewController *) targetVC
{
    UINavigationController* navC = (UINavigationController*)([self isKindOfClass:UINavigationController.class] ? self : self.navigationController);
    return [navC.viewControllers containsObject:targetVC];
}

- (BOOL)isPreViewController:(Class)targetClass
{
    UINavigationController* navC = (UINavigationController*)([self isKindOfClass:UINavigationController.class] ? self : self.navigationController);
    UIViewController *vc = navC.viewControllers[navC.viewControllers.count-2];
    return  ([vc isKindOfClass:targetClass]);
    
}

- (UIViewController *)preViewController
{
    UINavigationController* navC = (UINavigationController*)([self isKindOfClass:UINavigationController.class] ? self : self.navigationController);
    UIViewController *vc = navC.viewControllers[navC.viewControllers.count-2];
    return  vc;
    
}
#pragma mark dely
-(void)delyWithTime:(NSTimeInterval)time withAction:(SEL) action
{
    [self performSelector:action withObject:nil afterDelay:time];
}

#pragma mark modal

- (void)presentRoot:(UIViewController*) targetVC andTagetParamer:(id)targetParamer
{
    UINavigationController* nav = nil;
    if ([targetVC isKindOfClass:UINavigationController.class])
    {
        nav = (UINavigationController*)targetVC;
    }
    else
    {
        Class navClass = object_getClass(self.navigationController);
        nav = [[navClass alloc] initWithRootViewController:targetVC];
    }
    nav.viewControllers[0].preNavigationController = self.navigationController;
    nav.viewControllers[0].targetParamer = targetParamer;
    nav.viewControllers[0].navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"close_icon"] style:UIBarButtonItemStylePlain target:nav.viewControllers[0] action:@selector(leftBarButtonItemAction:)];
    
    [self present:nav andTagetParamer:targetParamer];
}

- (void)leftBarButtonItemAction:(UIBarButtonItem*) sender
{
    [self dismiss];
}

- (void)present:(UIViewController*) targetVC andTagetParamer:(id)targetParamer
{
    [self present:targetVC andTrnsitionStyle:UIModalTransitionStyleCoverVertical andComplation:nil andTagetParamer:targetParamer];
}

- (void)present:(UIViewController*) targetVC andTrnsitionStyle:(UIModalTransitionStyle) trusitionStyle andTagetParamer:(id)targetParamer
{
    [self present:targetVC andTrnsitionStyle:trusitionStyle andComplation:nil andTagetParamer:targetParamer];
}

- (void)present:(UIViewController*) targetVC andComplation:(dispatch_block_t) complation andTagetParamer:(id)targetParamer
{
    [self present:targetVC andTrnsitionStyle:UIModalTransitionStyleCoverVertical andComplation:complation andTagetParamer:targetParamer];
}

- (void)present:(UIViewController*) targetVC andTrnsitionStyle:(UIModalTransitionStyle) trusitionStyle andComplation:(dispatch_block_t) complation andTagetParamer:(id)targetParamer
{
    if (!targetVC)
    {
        return;
    }
    
    //解决present慢 点击cell时 提速 6s左右 （7s---0.6s）
    dispatch_async(dispatch_get_main_queue(), ^{
        
        targetVC.targetParamer = targetParamer;
        targetVC.modalTransitionStyle = trusitionStyle;
        [self presentViewController: targetVC animated:YES completion:^{
            if (complation) complation();
        }];
    });
}

@end
