//
//  QQLoginViewController.m
//  XSTestProject
//
//  Created by zhangss on 13-9-25.
//
//

#import "QQLoginViewController.h"

@interface QQLoginViewController ()

@end

@implementation QQLoginViewController

#pragma mark -
#pragma mark Init / Dealloc
- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

#pragma mark -
#pragma mark View Life Cycel
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.titleView = [XSTestUtils navigationTitleWithString:@"QQLogin"];
    
    UIButton *QQLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [QQLogin setImage:[UIImage imageNamed:@"qqicon"] forState:UIControlStateNormal];
    [QQLogin addTarget:self action:@selector(loginQQ:) forControlEvents:UIControlEventTouchUpInside];
    QQLogin.frame = CGRectMake(10, 10, 60, 60);
    QQLogin.backgroundColor = [UIColor blueColor];
    [self.view addSubview:QQLogin];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    _webView.delegate = self;
    _webView.center = self.view.center;
    _webView.alpha = 0.0;
    [self.view addSubview:_webView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Methods
- (void)loginQQ:(id)sender
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         _webView.alpha = 1.0;
                         [self startRequest];
                     } completion:^(BOOL finished){
                         _webView.frame = CGRectMake(20, 20, SCREEN_WIDTH - 40, SCREEN_HEIGHT - NAVI_HEIGHT - 40);
                     }];
}

- (void)startRequest
{
//    NSString *rootString = @"https://graph.z.qq.com/moc2/authorize";  //WAP
    NSString *rootString = @"https://graph.qq.com/oauth2.0/authorize"; //PC
//    NSString *rootString = @"https://openmobile.qq.com/oauth2.0/m_authorize";
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",rootString,@"?response_type=token&client_id=100526432&redirect_uri=qq1234://www.qq.com&state=test&display=mobile"] ;
    
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *requestURL = [[NSMutableURLRequest alloc] initWithURL:url];
    
    //从请求中获取缓存输出
    NSURLCache *urlCache = [NSURLCache sharedURLCache];
    NSCachedURLResponse *response =
    [urlCache cachedResponseForRequest:requestURL];
    //判断是否有缓存
    if (response != nil)
    {
        NSLog(@"如果有缓存输出，从缓存中获取数据");
        [requestURL setCachePolicy:NSURLRequestReturnCacheDataDontLoad];
    }
    [_webView loadRequest:requestURL];
}

- (void)getQQUserInfo
{
    if (_token)
    {
        NSString *rootString = @"https://graph.qq.com/user/get_user_info";
        NSString *urlString = [NSString stringWithFormat:@"%@?oauth_consumer_key=%@&access_token=%@&openid=%@%@",rootString,@"100526432",_token,_openID,@"&format=json"] ;
        
        NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        ASIHTTPRequest *request =[ASIHTTPRequest requestWithURL:url];
        [request setRequestMethod:HTTP_METHOD_GET];
        [request setTimeOutSeconds:30];
        [request setDelegate:self];
        [request startSynchronous];
        NSError *error = [request error];
        if (error)
        {
            NSLog(@"Failed %@ with code %d and with userInfo %@",
                  [error domain],
                  [error code],
                  [error userInfo]);
        }
        else
        {
            NSString *string = [request responseString];
            NSLog(@"%@",string);
        }
    }

}
#pragma mark -
#pragma mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *returnStr = request.URL.absoluteString;
    NSLog(@"%@",returnStr);
    NSString *url = [NSString stringWithFormat:@"http://%@?#",@"qq1234\/\/www.qq.com"];
    NSRange range = [returnStr rangeOfString:url];
    NSString *openID = [NSString stringWithFormat:@"&openid="];
    NSRange openIDRange = [returnStr rangeOfString:openID];
    
    if (range.length > 0)
    {
        NSString *resultStr = [returnStr substringFromIndex:range.length];
        NSArray *array =[resultStr componentsSeparatedByString:@"&"];
        NSString *tokenString = [array objectAtIndex:0];
        _token = [[tokenString substringFromIndex:[tokenString rangeOfString:@"access_token="].length] retain];
        NSLog(@"tokern:%@",_token);
    }
    
    if (openIDRange.length > 0)
    {
        NSArray *array =[returnStr componentsSeparatedByString:@"&"];
        for (NSString *str in array)
        {
            NSRange newRange = [str rangeOfString:@"openid="];
            if (newRange.length > 0)
            {
                _openID = [str substringFromIndex:newRange.length];
                NSLog(@"OpenID：%@",_openID);
            }
        }
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{

}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{

}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

@end
