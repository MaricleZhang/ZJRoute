//
//  UIViewController+ZJRoute.h
//  ZJDemo
//
//  Created by 张建 on 2018/4/27.
//  Copyright © 2018年 张建. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZJCallBackBlock)(id obj);
@interface UIViewController (ZJRoute)

@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) NSMutableDictionary *params;
@property (nonatomic, copy) ZJCallBackBlock callBackBlock;

/** 获取当前控制器  */
+ (UIViewController *)getCurrentViewController;

@end
