//
//  UIViewController+ZJRoute.m
//  ZJDemo
//
//  Created by 张建 on 2018/4/27.
//  Copyright © 2018年 张建. All rights reserved.
//

#import "UIViewController+ZJRoute.h"
#import <objc/runtime.h>

static void *kZJURLString = @"kZJURLString";
static void *kZJURLParams = @"kZJURLParams";
static void *kZJCallBackBlock = @"kZJCallBackBlock";

@implementation UIViewController (ZJRoute)

+ (UIViewController *)getCurrentViewController
{
    id result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    if ([result isKindOfClass:[UITabBarController class]])
    {
        result = [[(UITabBarController *)result viewControllers] objectAtIndex:[(UITabBarController *)result selectedIndex]];
    }
    
    if ([result isKindOfClass:[UINavigationController class]])
    {
        result = [(UINavigationController *)result topViewController];
    }
    
    if ([result isKindOfClass:[UINavigationController class]])
    {
        result = [(UINavigationController *)result topViewController];
    }
    
    return result;
}

#pragma mark - Setter/Getter

- (void)setUrlString:(NSString *)urlString
{
    objc_setAssociatedObject(self, kZJURLString, urlString, OBJC_ASSOCIATION_COPY);
}

- (NSString *)urlString
{
    return objc_getAssociatedObject(self, kZJURLString);
}

- (void)setParams:(NSMutableDictionary *)params
{
    objc_setAssociatedObject(self, kZJURLParams, params, OBJC_ASSOCIATION_COPY);
}

- (NSMutableDictionary *)params
{
    return objc_getAssociatedObject(self, kZJURLParams);
}

- (void)setCallBackBlock:(ZJCallBackBlock)callBackBlock
{
    objc_setAssociatedObject(self, kZJCallBackBlock, callBackBlock, OBJC_ASSOCIATION_COPY);
}

- (ZJCallBackBlock)callBackBlock
{
    return objc_getAssociatedObject(self, kZJCallBackBlock);
}

@end
