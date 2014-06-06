//
//  UIWebViewController.m
//  XSTestProject
//
//  Created by 张松松 on 13-7-10.
//
//

#import "UIWebViewController.h"

@interface UIWebViewController ()

@end

@implementation UIWebViewController

#pragma mark -
#pragma mark Init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

#pragma mark -
#pragma mark Life Cycel
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationItem.titleView = [XSTestUtils navigationTitleWithString:@"UIWebView"];
    [self initWebView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UIMethods
- (void)initWebView
{
    //用网页展示出内容 HTML
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.delegate = self;
    
    /*
     Connects to a given URL by initiating an asynchronous client request.
     To stop this load, use the stopLoading method. To see whether the receiver is done loading the content, use the loading property.
     URL需要加http://前缀
     */
    NSURLRequest *aRequest = [[NSURLRequest alloc] initWithURL:[[[NSURL alloc] initWithString:@"http://portal.dds.com/mobileteam/SitePages/doReg.aspx"] autorelease]];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://portal.dds.com/mobileteam/SitePages/doReg.aspx"]];
    [webView loadRequest:aRequest];
    [aRequest release];
    
    //    - (void)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL;
    //    - (void)loadData:(NSData *)data MIMEType:(NSString *)MIMEType textEncodingName:(NSString *)textEncodingName baseURL:(NSURL *)baseURL;
    
    /*
     @property(nonatomic,readonly,retain) NSURLRequest *request;
     */
    //    webView.request
    
    [self.view addSubview:webView];
    [webView release];
}

- (void)addToolBar
{
    
}

#pragma mark -
#pragma mark UIWebViewDelegate
//@optional WebViewDelegate的代理都是可选实现的
/*
 Sent before a web view begins loading a frame.
 YES if the web view should begin loading content; otherwise, NO.
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //用户的操作类型
    switch (navigationType) {
        case UIWebViewNavigationTypeLinkClicked:
        {
            NSLog(@"WebView: UIWebViewNavigationTypeLinkClicked");
            break;
        }
        case UIWebViewNavigationTypeFormSubmitted:
        {
            NSLog(@"WebView: UIWebViewNavigationTypeFormSubmitted");
            break;
        }
        case UIWebViewNavigationTypeBackForward:
        {
            NSLog(@"WebView:UIWebViewNavigationTypeBackForward");
            break;
        }
        case UIWebViewNavigationTypeReload:
        {
            NSLog(@"WebView: UIWebViewNavigationTypeReload");
            break;
        }
        case UIWebViewNavigationTypeFormResubmitted:
        {
            NSLog(@"WebView: UIWebViewNavigationTypeFormResubmitted");
            break;
        }
        case UIWebViewNavigationTypeOther:
        {
            NSLog(@"WebView: User Action Unknow");
            break;
        }
        default:
            break;
    }
    return YES;
}

/*
 Sent after a web view starts loading a frame.
 */
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidStartLoad");
}

/*
 Sent after a web view finishes loading a frame.
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
}

/*
 Sent if a web view failed to load a frame.
 */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"didFailLoadWithError:%@",error);
}

@end
