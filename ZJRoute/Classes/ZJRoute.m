//
//  ZJRoute.m
//  ZJDemo
//
//  Created by 张建 on 2018/4/27.
//  Copyright © 2018年 张建. All rights reserved.
//

#import "ZJRoute.h"

static NSString *kHttp = @"http";
static NSString *kHttps = @"https";

@implementation ZJRoute

+ (instancetype)route
{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

/**
 示例入参: ZJDemo://ZJFirst?id=102&username=hi
 示例出参:
 ZJFirst -> ZJFirstViewController
 params:{ @"id": @"102",
          @"username": @"hi"
        }
 */
- (void)routeURL:(NSString *)urlString
{
    [self routeURL:urlString params:nil];
}

- (void)routeURL:(NSString *)urlString params:(NSDictionary *)params
{
    NSAssert(urlString, @"urlString 不能为nil");
    NSString *encodingString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:encodingString];
    NSString *schemeLowercaseString = url.scheme.lowercaseString;
    UIViewController *currentVC = [UIViewController getCurrentViewController];

   if ([schemeLowercaseString isEqualToString:@"http"] || [schemeLowercaseString isEqualToString:@"https"])
    {
        NSString *classStr = [self.routeKeyClass objectForKey:@"https"] ?: [self.routeKeyClass objectForKey:@"http"];
        [self pushWithURL:encodingString params:params classsString:classStr];
    }
    else
    {
        NSString *classStr = [self.routeKeyClass objectForKey:url.host];
        NSAssert(url.host, @"映射表中不存在 %@ 对应的类名",url.host);
        if ([self isExistPopViewControllerClassName:classStr currentVC:currentVC]) return;
        if ([self isTabBarSubViewControllerClassName:classStr currentVC:currentVC]) return;
        [self pushWithURL:encodingString params:params classsString:classStr];
    }
}

- (void)pushWithURL:(NSString *)urlString params:(NSDictionary *)params classsString:(NSString *)classsString
{
    NSMutableDictionary *mParams = [NSMutableDictionary dictionaryWithDictionary:params];
    Class class = NSClassFromString(classsString);
    NSMutableDictionary *urlParams = [self fetchParamsWithUrl:[NSURL URLWithString:urlString]];
    [mParams addEntriesFromDictionary:urlParams];
    UIViewController *pushViewController =  [[class alloc] init];
    NSAssert(pushViewController, @"工程中不存在类:%@",classsString);
    pushViewController.urlString = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    pushViewController.params = mParams;
    [[UIViewController getCurrentViewController].navigationController pushViewController:pushViewController animated:YES];
    self.pushViewController = pushViewController;
}

- (NSMutableDictionary *)fetchParamsWithUrl:(NSURL *)url
{
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
    //url中参数的key value
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    for (NSURLQueryItem *item in urlComponents.queryItems)
    {
        [params setValue:item.value forKey:item.name];
    }
    return params;
}

- (BOOL)isExistPopViewControllerClassName:(NSString *)className currentVC:(UIViewController *)currentVC
{
    for (id vc in currentVC.navigationController.viewControllers)
    {
        if ([vc isMemberOfClass:[NSClassFromString(className) class]])
        {
            self.pushViewController = vc;
            [currentVC.navigationController popToViewController:vc animated:YES];
            return YES;
        }
    }
    return NO;
}

- (BOOL)isExistPopWKWebViewControllerHost:(NSString *)host currentVC:(UIViewController *)currentVC
{
    for (UIViewController *vc in currentVC.navigationController.viewControllers)
    {
        NSURL *url = [NSURL URLWithString:vc.urlString];
        if ([host isEqualToString:url.host])
        {
            self.pushViewController = vc;
            [currentVC.navigationController popToViewController:vc animated:YES];
            return YES;
        }
    }
    return NO;
}

- (BOOL)isTabBarSubViewControllerClassName:(NSString *)className currentVC:(UIViewController *)currentVC
{
    BOOL isTabbar = NO;
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    if (![rootVC isKindOfClass:[UITabBarController class]]) return NO;
    UITabBarController *tabVC = (UITabBarController *)rootVC;
 
    for (int index = 0; index < tabVC.viewControllers.count; index++)
    {
        UINavigationController *navigation = tabVC.viewControllers[index];
        if (navigation.viewControllers.count &&
            [navigation.viewControllers[0] isKindOfClass:NSClassFromString(className)])
        {
            tabVC.selectedIndex = index;
            isTabbar = YES;
        }
    }
    return isTabbar;
}

- (NSDictionary *)routeKeyClass
{
    if (!_routeKeyClass)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"ZJRoute" ofType:@"plist"];
        _routeKeyClass = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return _routeKeyClass;
}

@end
