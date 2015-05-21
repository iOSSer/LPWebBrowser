//
//  LPWebBrowser.m
//  LPWebBrowserDemo
//
//  Created by lipeng on 15/5/21.
//  Copyright (c) 2015年 lipeng. All rights reserved.
//

#import "LPWebBrowser.h"
@interface LPWebBrowser ()

@property (nonatomic, strong) UIBarButtonItem *barGoBack;
@property (nonatomic, strong) UIBarButtonItem *barGoForward;

@end

@implementation LPWebBrowser


- (instancetype)initWithUrl:(NSString *)url
{
    self = [super init];
    if (self) {
        _url = url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationController.toolbarHidden = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(goAction)];
    
    if (![_url hasPrefix:@"http://"]) {
        _url = [NSString stringWithFormat:@"http://%@", _url];
    }
    
    self.webview = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webview.delegate = self;
    [self.view addSubview:self.webview];
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    
    self.barGoBack = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:105 target:self action:@selector(goBack)];
    
    self.barGoForward = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:106 target:self action:@selector(goForward)];
    
    self.barGoBack.enabled = self.barGoForward.enabled = NO;
    
    UIBarButtonItem *barFlexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];;
    
//    UIBarButtonItem *barFixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    UIBarButtonItem *barReload = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    
    UIBarButtonItem *barCopy = [[UIBarButtonItem alloc] initWithTitle:@"Copy" style:UIBarButtonItemStylePlain target:self action:@selector(goCopyUrl)];
    
    self.toolbarItems = @[barFlexibleSpace, self.barGoBack, barFlexibleSpace, self.barGoForward,barFlexibleSpace, barReload, barFlexibleSpace, barCopy, barFlexibleSpace];
}

- (void) barButtonEnable
{
    self.barGoBack.enabled = self.webview.canGoBack;
    self.barGoForward.enabled = self.webview.canGoForward;

}

- (void) goBack
{
    [self.webview goBack];
}

- (void) goForward
{
    [self.webview goForward];
}

- (void) refresh
{
    [self.webview stopLoading];
    [self.webview reload];
}

- (void) goCopyUrl
{
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    pasteBoard.string = self.webview.request.URL.absoluteString;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已复制到剪切板" delegate:self cancelButtonTitle:nil otherButtonTitles:@"好", nil];
    [alert show];
}

- (void) goAction
{
    
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self barButtonEnable];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self barButtonEnable];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
