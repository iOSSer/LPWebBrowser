//
//  ViewController.m
//  LPWebBrowserDemo
//
//  Created by lipeng on 15/5/21.
//  Copyright (c) 2015年 lipeng. All rights reserved.
//

#import "ViewController.h"
#import "LPWebBrowser.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txfUrl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Browser";
    self.txfUrl.placeholder = @"input url";
    self.txfUrl.text = @"www.taobao.com";
}
- (IBAction)openUrl:(id)sender {
    
    NSString *url = self.txfUrl.text;
    //调用方法，传入一个 URL text
    LPWebBrowser *browser = [[LPWebBrowser alloc] initWithUrl:url];
    [self.navigationController pushViewController:browser animated:YES];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.txfUrl resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
