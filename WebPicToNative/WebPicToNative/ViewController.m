//
//  ViewController.m
//  WebPicToNative
//
//  Created by paprika on 2017/12/13.
//  Copyright © 2017年 paprika. All rights reserved.
//

#import "ViewController.h"
@import WebKit;
@interface ViewController ()<WKNavigationDelegate,UIGestureRecognizerDelegate,WKUIDelegate>
@property(nonatomic)WKWebView * webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    NSURL *url = [NSURL URLWithString:@"http://image.baidu.com"];
    NSURLRequest *res = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:res];
}

#pragma mark - JS Fucntions
//注入JS
- (NSString*)jsString{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"tools.js" withExtension:nil];
    return [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:NULL];
}
//检查JS是否注入成功
- (void)checkJsWithCompletion:(void (^)(void))completion{
    NSString *js = @"typeof pa_imageSourceFromPoint;";
    [self.webView evaluateJavaScript:js completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        //NSLog(@"%@",result);
        if (error != nil) {
            NSLog(@">>>>>>>>>>>注入没有成功<<<<<<<<<<<<<");
            return ;
        }
        completion();
    }];
}
#pragma mark - Tap Action
- (void)tapWebView:(UITapGestureRecognizer *)ges{
    
    CGPoint point = [ges locationInView:self.webView];
    NSString *js = [NSString stringWithFormat:@"pa_imageSourceFromPoint(%g,%g)",point.x,point.y];
    NSLog(@"\n\n---点击位置 ===> %@\n\n",js);
    
    [self checkJsWithCompletion:^{
        [self.webView evaluateJavaScript:js completionHandler:^(id _Nullable result, NSError * _Nullable error) {
    
               NSLog(@"\n\n---图片URL地址 ===> %@\n\n",result);
           
        }];
    }];
    
}
#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    //NSLog(@">>>>>>>>%@",navigationAction.request);
    decisionHandler(WKNavigationActionPolicyAllow);
    
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    [webView evaluateJavaScript:[self jsString] completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        //NSLog(@">>>>>>>>>>>%@",result);
        [self checkJsWithCompletion:^{
            NSLog(@">>>>>>>>>>>>>>>注入成功<<<<<<<<<<<<<<<<<");
        }];
    }];
}

#pragma mark - WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{

    NSLog(@"\n\n---图片在webView中位置 ===> %@\n\n",message);
    completionHandler();
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return true;
}

#pragma mark - Lazy Load
//懒加载
- (WKWebView *)webView{
    if (_webView == nil) {
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapWebView:)];
        tap.delegate = self;
        [_webView addGestureRecognizer:tap];
    }
    return _webView;
}

@end
