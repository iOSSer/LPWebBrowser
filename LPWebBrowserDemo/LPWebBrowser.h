//
//  LPWebBrowser.h
//  LPWebBrowserDemo
//
//  Created by lipeng on 15/5/21.
//  Copyright (c) 2015年 lipeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPWebBrowser : UIViewController<UIWebViewDelegate>

- (instancetype)initWithUrl:(NSString *)url;

@property (nonatomic, strong) UIWebView *webview;

@property (nonatomic, copy) NSString *url;


@end
