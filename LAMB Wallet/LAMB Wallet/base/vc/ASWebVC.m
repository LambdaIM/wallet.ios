
#import "ASWebVC.h"
#import <WebKit/WKWebView.h>
#import <WebKit/WebKit.h>

@interface ASWebVC () <WKScriptMessageHandler,WKNavigationDelegate,WKUIDelegate>

@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) WKUserContentController *uerConter;

@end

@implementation ASWebVC


static void *WkwebBrowserContext = &WkwebBrowserContext;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self loadData];
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self clearCache];
    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"prompt"];
    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"appDownloadPic"];
}
//注意，观察的移除
-(void)dealloc{
    [self.wkWebView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"prompt"];
    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"appDownloadPic"];
    [self.wkWebView setNavigationDelegate:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 80, 20);
    [rightBtn setImage:[UIImage imageNamed:@"Group_close"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(closePressed) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightitem;

//    NSDictionary *dic =[NSDictionary dictionaryWithObject:[UIColor day212733_nightFFFFFF] forKey:NSForegroundColorAttributeName];
//    [rightitem setTitleTextAttributes:dic forState:UIControlStateNormal];

//    [self.view addSubview:self.wkWebView];
    [self.view addSubview:self.progressView];
    
    self.wkWebView.backgroundColor = [UIColor whiteColor];
    [self loadData];
}

- (void)loadData {
//    [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:self.urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    
    NSLog(@"路径%@",self.urlString);
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:self.urlString]];
   [self.wkWebView loadRequest:request];
}
/* 注释:返回按钮*/
- (void)onBackButtonClicked
{
    if ([self.wkWebView canGoBack]) {
        [self.wkWebView goBack];
    }else{
        if (self.navigationController.viewControllers.count>=2) {
            [self.navigationController popViewControllerAnimated:YES];//首页公告web
        }else{
            [self dismissViewControllerAnimated:YES completion:nil];//注册协议web
        }
    }
}

- (void)closePressed
{
    if (self.navigationController.viewControllers.count>=2) {
        [self.navigationController popViewControllerAnimated:YES];//首页公告web
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];//注册协议web
    }
}

-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}
#pragma mark delegate
//KVO监听进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.wkWebView) {
        [self.progressView setAlpha:1.0f];
        BOOL animated = self.wkWebView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.wkWebView.estimatedProgress animated:animated];
        
        // Once complete, fade out UIProgressView
        if(self.wkWebView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
#pragma mark - 网页加载完成
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"---%@---",@"f");
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSString *webTitle = webView.title;
    if (webTitle.length > 0) {
        self.title = webTitle;
    }
}
//开始加载
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    //开始加载的时候，让加载进度条显示
    self.progressView.hidden = NO;
}
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"---%@---", error.localizedDescription);
}
#pragma mark - 拦截H5跳转
/* 注释:拦截url 暂时不用这种方式交互*/
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {

    NSString *strRequest = [navigationAction.request.URL.absoluteString stringByRemovingPercentEncoding];
    //如果是跳转一个新页面
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }

    
    decisionHandler(WKNavigationActionPolicyAllow);
     

}//0445


#pragma mark 处理回调
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    __weak typeof(self) weakSelf = self;
    
    
    if ([message.body isKindOfClass:[NSString class]]) {
        NSData *jsonData = [message.body dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
        NSString *method = [dict objectForKey:@"method"];
        NSString *callback = [dict objectForKey:@"callback"];
        
        if ([method isEqualToString:@"get"]) {
            NSString *data = [dict objectForKey:@"data"];
            if ([data isEqualToString:@"token"]) {
//                NSString *jscallback = [NSString stringWithFormat:@"%@('%@')",callback,[WCSUserInfo currentUser].accessToken];
//                [self.wkWebView evaluateJavaScript:jscallback completionHandler:^(id _Nullable result, NSError * _Nullable error) {
//
//                }];
            }
        }
    }
}
#pragma mark get
- (WKWebView *)wkWebView{
    if (!_wkWebView) {
        
        //设置网页的配置文件
        WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc]init];
        WKPreferences *preferences = [WKPreferences new];
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        [_wkWebView.scrollView setShowsVerticalScrollIndicator:NO];
        [_wkWebView.scrollView setShowsHorizontalScrollIndicator:NO];
        _wkWebView.UIDelegate = self;
        
        // 允许可以与网页交互，选择视图
        config.selectionGranularity = YES;
        // web内容处理池
        config.processPool = [[WKProcessPool alloc] init];
        
         
        
        self.uerConter = config.userContentController ;
        // 添加消息处理，注意：self指代的对象需要遵守WKScriptMessageHandler协议，结束时需要移除
        [self.uerConter addScriptMessageHandler:self name:@"prompt"];
        [self.uerConter addScriptMessageHandler:self name:@"appDownloadPic"];
        
        
        // 是否支持记忆读取
        config.suppressesIncrementalRendering = YES;
 
        
        CGSize ss = [UIScreen mainScreen].bounds.size;
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ss.width, ss.height-self.view.safeAreaInsets.top-self.view.safeAreaInsets.bottom) configuration:config];


        _wkWebView.navigationDelegate = self;
        //kvo 添加进度监控
        [_wkWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:WkwebBrowserContext];
        //开启手势触摸
        _wkWebView.allowsBackForwardNavigationGestures = YES;
        [self.view addSubview:_wkWebView];
        //适应你设定的尺寸
//        [_wkWebView sizeToFit];
    }
    return _wkWebView;
}

- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.frame = CGRectMake(0, self.wkWebView.top, self.view.bounds.size.width, 3);
        // 设置进度条的色彩
        [_progressView setTrackTintColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:.1]];
        _progressView.progressTintColor = [UIColor yellowColor];
    }
    return _progressView;
}
// 清理clearWKWebViewCache缓存
- (void)clearCache {
    // 9.0之后才有的
    NSArray * types =@[WKWebsiteDataTypeMemoryCache,WKWebsiteDataTypeDiskCache];
    NSSet *websiteDataTypes = [NSSet setWithArray:types];
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
    }];
}

@end
