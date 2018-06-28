//
//  ZJFirstViewController.m
//  ZJRoute_Example
//
//  Created by 张建 on 2018/6/28.
//  Copyright © 2018 MaricleZhang. All rights reserved.
//

#import "ZJFirstViewController.h"
#import "ZJRoute.h"

@interface ZJFirstViewController ()

@end

@implementation ZJFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"第一个标题";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSString *urlStr = [NSString stringWithFormat:@"%@://%@?id=102&username=1233",@"11",@"ZJSecond"];
//    [[ZJRoute route] routeURL:@"https://www.baidu.com"];
//    [[ZJRoute route] routeURL:ZJNativeURL(@"ZJSecond") params:@{@"title" : @"第二个标题"}];
    
    [[ZJRoute route] routeURL:ZJNativeURL(@"ZJSecond?title=第二个标题") params:@{@"title" : @"第二个标题"}];
    [UIViewController getCurrentViewController].callBackBlock = ^(id obj) {
        self.title = obj;
    };
}

@end
