//
//  URLRequestViewController.m
//  XSTestProject
//
//  Created by SAIC_Zhangss on 14-4-15.
//
//

#import "URLRequestViewController.h"

@interface URLRequestViewController ()

@end

//#define BASE_URL @"http://portal.dds.com/mobileteam/_layouts/15/start.aspx#/SitePages/getRecoBrandList.aspx"
#define BASE_URL @"http://www.baidu.com"

@implementation URLRequestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self startUrlConnection];
    [self startASIHttpRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma makr Request
- (void)startASIHttpRequest
{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:BASE_URL]];
    request.delegate = self;
    //默认就是yes
//    request.useKeychainPersistence = YES;
//    request.username = @"dds\\zhangsongsong";
//    request.password = @"Pass1234";
    [request startAsynchronous];
    
//    NSError *error = nil;
//    NSString *string = [NSString stringWithContentsOfURL:[NSURL URLWithString:BASE_URL] encoding:NSUTF8StringEncoding error:&error];
//    NSLog(@"%@",error);
}

- (void)startUrlConnection
{
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:BASE_URL]] delegate:self];
    [connection start];
    
    //同步方法
//    NSData *data = [NSURLConnection sendSynchronousRequest:<#(NSURLRequest *)#> returningResponse:<#(NSURLResponse **)#> error:<#(NSError **)#>];
}

#pragma mark -
#pragma mark ASIHttpRequest
- (void)requestStarted:(ASIHTTPRequest *)request
{
    NSLog(@"requestStarted:%@",request.url);
}
- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders
{
    NSLog(@"didReceiveResponseHeaders:%@",responseHeaders);
}
- (void)request:(ASIHTTPRequest *)request willRedirectToURL:(NSURL *)newURL
{
    NSLog(@"willRedirectToURL:%@",newURL);
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"%d",self.data.length);
    NSLog(@"%@",[[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding]);
    NSLog(@"requestFinished:%@",request.responseString);
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"requestFailed:%@",request.error);
}
- (void)requestRedirected:(ASIHTTPRequest *)request
{
    NSLog(@"requestRedirected:%@",request.url);
}
- (void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)data
{
    if (self.data)
    {
        [self.data appendData:data];
        NSLog(@"%d",data.length);
    }
    else
    {
        self.data = [NSMutableData dataWithData:data];
    }
    NSLog(@"didReceiveData:%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}
- (void)authenticationNeededForRequest:(ASIHTTPRequest *)request
{
    [request retryUsingSuppliedCredentials];
    NSLog(@"authenticationNeededForRequest:%@",request.url);
}
- (void)proxyAuthenticationNeededForRequest:(ASIHTTPRequest *)request
{
    [request retryUsingSuppliedCredentials];
    NSLog(@"proxyAuthenticationNeededForRequest:%@",request.url);
}

#pragma mark -
#pragma mark NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError:%@",error);
}
- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection
{
    NSLog(@"connectionShouldUseCredentialStorage:Yes");
    return YES;
}
- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    NSLog(@"willSendRequestForAuthenticationChallenge:%@",challenge);
}

// Deprecated authentication delegates.
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace\
{
    NSLog(@"canAuthenticateAgainstProtectionSpace:Yes");
    return YES;
}
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    NSLog(@"didReceiveAuthenticationChallenge:%@",challenge);
}
- (void)connection:(NSURLConnection *)connection didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    NSLog(@"didCancelAuthenticationChallenge:%@",challenge);
}

#pragma mark - 
#pragma mark NSURLConnectionDataDelegate
- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response
{
    NSLog(@"willSendRequest:%@",[request URL]);
    return request;
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"didReceiveResponse:%@",response);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (self.data) {
        [self.data appendData:data];
    }
    else
    {
        self.data = [NSMutableData dataWithData:data];
    }
    NSLog(@"didReceiveData:%d",[data length]);
}

- (NSInputStream *)connection:(NSURLConnection *)connection needNewBodyStream:(NSURLRequest *)request
{
    NSLog(@"needNewBodyStream:%@",[request URL]);
    return nil;
}
- (void)connection:(NSURLConnection *)connection
   didSendBodyData:(NSInteger)bytesWritten
 totalBytesWritten:(NSInteger)totalBytesWritten
totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    NSLog(@"didSendBodyData:");
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    NSLog(@"willCacheResponse:%@",cachedResponse);
    return cachedResponse;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"connectionDidFinishLoading");
    NSString *string = [[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
    NSLog(@"%d",self.data.length);
    NSLog(@"%@",string);
}

#pragma mark -
#pragma mark NSURLConnectionDownloadDelegate
- (void)connection:(NSURLConnection *)connection didWriteData:(long long)bytesWritten totalBytesWritten:(long long)totalBytesWritten expectedTotalBytes:(long long) expectedTotalBytes
{
    NSLog(@"didWriteData");
}
- (void)connectionDidResumeDownloading:(NSURLConnection *)connection totalBytesWritten:(long long)totalBytesWritten expectedTotalBytes:(long long) expectedTotalBytes
{
    NSLog(@"connectionDidResumeDownloading");
}

//- (void)connectionDidFinishDownloading:(NSURLConnection *)connection destinationURL:(NSURL *) destinationURL
//{
//    NSLog(@"connectionDidFinishDownloading:%@",destinationURL);
//}

@end
