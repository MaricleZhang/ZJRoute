//
//  ZJSecondViewController.m
//  ZJRoute_Example
//
//  Created by MaricleZhang on 2018/6/28.
//  Copyright © 2018 MaricleZhang. All rights reserved.
//

#import "ZJSecondViewController.h"
#import "ZJRoute.h"

@interface ZJSecondViewController ()

@end

@implementation ZJSecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.params[@"title"];
    self.view.backgroundColor = [UIColor redColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSString *urlStr = [NSString stringWithFormat:@"%@://%@?id=102&username=1233",@"11",@"ZJSecond"];
    //    [[ZJRoute route] routeURL:@"https://www.baidu.com"];
    if (self.callBackBlock)
    {
        self.callBackBlock(@"回调改变第一个标题");
    }
    [[ZJRoute route] routeURL:ZJNativeURL(@"ZJFirst")];
}

@end
