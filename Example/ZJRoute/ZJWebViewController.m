//
//  ZJWebViewController.m
//  ZJRoute_Example
//
//  Created by 张建 on 2018/6/28.
//  Copyright © 2018 MaricleZhang. All rights reserved.
//

#import "ZJWebViewController.h"
#import <WebKit/WebKit.h>
#import "UIViewController+ZJRoute.h"

@interface ZJWebViewController ()

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation ZJWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    [self loadUrl:self.urlString];
}

- (void)loadUrl:(NSString *)urlStr
{
    NSURL *url = [NSURL URLWithString:urlStr];
    if (url)
    {
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }
}
#pragma mark - Setter/Getter

- (WKWebView *)webView
{
    if (!_webView)
    {
        _webView = [[WKWebView alloc] initWithFrame:self.view.frame];
        _webView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _webView;
}

@end
