//
//  JsCoreViewController.m
//  JavascriptCoreDemo
//
//  Created by 董瑞鹤 on 2017/7/31.
//  Copyright © 2017年 董瑞鹤. All rights reserved.
//

#import <JavaScriptCore/JavaScriptCore.h>
#import "JsCoreViewController.h"
#import "JsCallOcMethod.h"



@interface JsCoreViewController ()<UIWebViewDelegate>

@end

@implementation JsCoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建webview事例
    UIWebView *myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    myWebView.delegate = self;
    //加添webview实图到控制器视图
    [self.view addSubview:myWebView];
    //组装url
    //从服务器获取url
    //NSString *path = @"https://www.baidu.com/";
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    //NSURL *url = [NSURL URLWithString:path];
    //NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //[myWebView loadRequest:request];

    //从本地获取url
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [myWebView loadHTMLString:html baseURL:baseURL];
    
    
    // Do any additional setup after loading the view.
}


#pragma mark --webViewDelegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    //网页加载之前会调用此方法
    return YES;
}
-(void)webViewDidStartLoad:(UIWebView *)webView {
    //开始加载网页调用此方法
}
-(void)webViewDidFinishLoad:(UIWebView *)webView {
    //网页加载完成调用此方法
    //首先创建jSContext对象(此处通过当前webView的键获取到jscontext)
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //确保js存在alert方法
    NSString *alertJs = @"alert('test js call oc')";
    context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        NSLog(@"JS Error: %@", exception);
    };
    //调用上下文执行js方法
    [context evaluateScript:alertJs];
    
    
    
    //以下演示js调用oc    JscallOc为js里的方法
    context[@"JsCallOc"] = ^() {
        NSArray *args = [JSContext currentArguments];
        for (id obj in args) {
            NSLog(@"%@",obj);
        }
        JSContext *context = [JSContext currentContext]; // 这里不要用self.context 会导致循环引用
    };
    //此处oc对应的方法尚未报漏给js，我们只能通过context触发js方法 在oc里调起js方法
    NSString *func1 = @"JsCallOc('参数1')";
    [context evaluateScript:func1];
    
    NSString *func2 = @"JsCallOc('参数2','参数3')";
    [context evaluateScript:func2];
    
    
    //代码优化，通过JSExport将oc供js调用的代码封装并暴露给js
    JsCallOcMethod *jsCallOcObject = [[JsCallOcMethod alloc] init];
    context[@"ocMethods"] = jsCallOcObject;
    
    //如下调用
    NSString *JsCallOcMethod = @"ocMethods.JsCallOcMethod()";
    [context evaluateScript:JsCallOcMethod];
    
    NSString *JsCallOcMethod1 = @"ocMethods.JsCallOcMethod1('a')";
    [context evaluateScript:JsCallOcMethod1];
    
    NSString *JsCallOcMethod2 = @"ocMethods.JsCallOcMethod2SecondMessage('a','b')";
    [context evaluateScript:JsCallOcMethod2];
    

    
    
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    //网页加载失败调用此方法
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
