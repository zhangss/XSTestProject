//
//  ZSProcessor.m
//  XSTestProject
//
//  Created by zhangss on 13-9-26.
//
//

#import "ZSProcessor.h"

@implementation ZSProcessor

#pragma mark -
#pragma mark Init / Dealloc

- (void)dealloc
{
    [_nsQueue release];
    [_asiQueue release];
    [super dealloc];
}

#pragma mark -
#pragma mark ASI同步请求
- (void)startASISynchronous
{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:HTTP_TEST_URL];
    [request startSynchronous];
    
    NSError *error = [request error];
    if (!error)
    {
        //正确返回数据
        NSString *responseStr = [request responseString];
        NSLog(@"%@",responseStr);
    }
}

#pragma mark -
#pragma mark ASI异步请求
- (void)startASIAsynchronous
{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:HTTP_TEST_URL];
    request.delegate = self;
    
    /*
     使用Request的userInfo或者tag属性在回调中区分request,这个参数不会被放到请求包内
     不要使用request的URL区分请求，URL会被重定向的；可以使用request的originalURL,这个是原始的URL
     */
    request.userInfo = [NSDictionary dictionary];
    request.tag = 1;
    
    /*
     Referer参照页 参考
     正确的写法应该是referrer(介绍人/推荐人),但是写错的人太多了，所以标准就将错就错了。
     作用是告诉服务器这个请求是从哪个页面过来的，方便用户做访问统计等操作。
     */
    [request addRequestHeader:HTTP_KEY_REFERER value:@"www.zs.com"];
    
    [request startAsynchronous];
    
    /*
     1.异步或者是加入队列的请求可以取消，调用[request cancel]即可.
     2.Canel方法会使request返回请求失败，请求失败的回调会被调用，如果不想被调用可以设置delegate为nil或者调用[request clearDelegatesAndCancel]
     3.同步请求不可以取消。
     */
}

- (void)startASIAsynchronousWithInBlock
{
    //声明request时要使用__block修饰符，这是为了告诉block不要retain request，以免出现retain循环，因为request是会retain block的。
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:HTTP_TEST_URL];
    [request setCompletionBlock:^{
        //正确返回
    }];
    
    [request setFailedBlock:^{
        //错误返回
    }];
    
    //开始异步请求
    [request startAsynchronous];
    
    //清理Request
//    [self clearASIRequset:request];
}

#pragma mark -
#pragma mark Clear ASIRequest
//request并不retain它们的代理，所以有可能你已经释放了代理，而之后request完成了，这将会引起崩溃。
//大多数情况下，如果你的代理即将被释放，你一定也希望取消所有request，因为你已经不再关心它们的返回情况了。
- (void)clearASIRequset:(ASIHTTPRequest *)request
{
    [request clearDelegatesAndCancel];
    if ([request retainCount] > 0)
    {
        [request release];
    }
}

#pragma mark -
#pragma mark ASIHTTPRequestDelegate
/*
   These are the default delegate methods for request status
   You can use different ones by setting didStartSelector / didFinishSelector / didFailSelector
 */
- (void)requestStarted:(ASIHTTPRequest *)request
{
    
}
- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders
{

}
- (void)request:(ASIHTTPRequest *)request willRedirectToURL:(NSURL *)newURL
{
    
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    
}
- (void)requestRedirected:(ASIHTTPRequest *)request
{
    
}

/*
   When a delegate implements this method, it is expected to process all incoming data itself
   This means that responseData / responseString / downloadDestinationPath etc are ignored
   You can have the request call a different method by setting didReceiveDataSelector
 
   如果你想处理服务器响应的数据（例如，你想使用流解析器对正在下载的数据流进行处理），你应该实现代理函数 request:didReceiveData:。
   注意如果你这么做了，ASIHTTPRequest将不会填充responseData到内存，也不会将数据写入文件（downloadDestinationPath ）——你必须自己搞定这两件事（之一）。
 */
- (void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)data
{
    
}

/*
   If a delegate implements one of these, it will be asked to supply credentials when none are available
   The delegate can then either restart the request ([request retryUsingSuppliedCredentials]) once credentials have been set
   or cancel it ([request cancelAuthentication])
 */
- (void)authenticationNeededForRequest:(ASIHTTPRequest *)request
{

}
- (void)proxyAuthenticationNeededForRequest:(ASIHTTPRequest *)request
{
    
}

#pragma mark -
#pragma mark ASI队列操作
- (void)startASIRequestInNSOperationQueue
{
    if (!_nsQueue)
    {
        _nsQueue = [[NSOperationQueue alloc] init];
        _nsQueue.maxConcurrentOperationCount = 3;  //操作队列的线程最大并发数
    }
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:HTTP_TEST_URL];
    request.delegate = self;
    
    /*
     自定义返回函数 参数是ASIHTTPRequest
     如果不设置则使用默认代理
     */
    request.didFailSelector = @selector(requestFinished:);
    request.didFailSelector = @selector(requestFailed:);
    
    //请求加入队列
    [_nsQueue addOperation:request];
}

- (void)startASIRequestInASINetworkQueues
{
    if (!_asiQueue)
    {
        _asiQueue = [[ASINetworkQueue alloc] init];
        _asiQueue.maxConcurrentOperationCount = 3;  //操作队列的线程最大并发数
    }
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:HTTP_TEST_URL];
    request.delegate = self;
    
    /*
     ASINetworkQueue是NSOperationQueue的子类 提供更高级的特性
     1.当一个request开始执行时，这个代理函数会被调用
     _asiQueue.requestDidStartSelector
     
     2.当队列中的request收到服务器返回的头信息时，这个代理函数会被调用。对于下载很大的文件，这个通常比整个request的完成要早。
     _asiQueue.requestDidReceiveResponseHeadersSelector

     3.当每个request完成时，这个代理函数会被调用。
     _asiQueue.requestDidFinishSelector

     4.当每个request失败时，这个代理函数会被调用。
     _asiQueue.requestDidFailSelector

     5.当队列完成（无论request失败还是成功）时，这个代理函数会被调用。
     _asiQueue.queueDidFinishSelector
     */
    
    /*
     ASINetworkQueues与NSOperationQueues稍有不同，加入队列的request不会立即开始执行。如果队列打开了进度开关，那么队列开始时，会先对所有GET型request进行一次HEAD请求，获得总下载大小，然后真正的request才被执行。
     
     向一个已经开始进行的ASINetworkQueue加入request会怎样？
     如果你使用ASINetworkQueue来跟踪若干request的进度，只有当新的request开始执行时，总进度才会进行自适应调整（向后移动）。ASINetworkQueue不会为队列开始后才加入的request进行HEAD请求，所以如果你一次向一个正在执行的队列加入很多request，那么总进度不会立即被更新。
     如果队列已经开始了，不需要再次调用[queue go]。
     */
    //请求加入队列
    [_asiQueue addOperation:request];
    
    /*
     当ASINetworkQueue中的一个request失败时，默认情况下，ASINetworkQueue会取消所有其他的request。要禁用这个特性，设置 [queue setShouldCancelAllRequestsOnFailure:NO]。
     ASINetworkQueues只可以执行ASIHTTPRequest操作，不可以用于通用操作。试图加入一个不是ASIHTTPRequest的NSOperation将会导致抛出错误。
     */
    _asiQueue.shouldCancelAllRequestsOnFailure = NO;
}

#pragma mark -
#pragma mark ASIFromateData Post表单
- (void)postForms
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:HTTP_TEST_URL];
    [request setPostValue:@"zhang" forKey:@"name"];
    [request setPostValue:@"ss" forKey:@"test"];
    
    // Upload a file on disk
    NSString *filePath = @"/Users/ben/Desktop/ben.jpg";
    [request setFile:filePath forKey:@"photo"];
    
    //自动以MiME头
    [request setFile:@"/Users/Desktop/ben.jpg" withFileName:@"myphoto.jpg" andContentType:@"image/jpeg"
              forKey:@"photo"];
    
    // Upload an NSData instance
    NSData *imageData = [NSData data];
    [request setData:imageData withFileName:@"myphoto.jpg" andContentType:@"image/jpeg" forKey:@"photo"];
    
    //统一个KEY对应多值设置 服务器会认为是一个数组
    [request addPostValue:@"zhang" forKey:@"Users"];
    [request addPostValue:@"ss" forKey:@"Users"];
    
    //自定义Put请求(使用post数据方式)
    /*
    [request appendPostData:[@"This is my data" dataUsingEncoding:NSUTF8StringEncoding]];
    // Default becomes POST when you use appendPostData: / appendPostDataFromFile: / setPostBody:
    [request setRequestMethod:HTTP_METHOD_SET];
     */
}

#pragma mark -
#pragma mark ASI DownLoad Data
- (void)downLoadData
{
    /*
     如果你请求的资源很大，你可以直接将数据下载到文件中来节省内存。此时，ASIHTTPRequest将不会一次将返回数据全部保持在内存中。
     当我们把数据下载到downloadDestinationPath时，数据将首先被存在临时文件中。此时文件的路径名存储在temporaryFileDownloadPath中(如果不设置这个值，会自动生成一个文件名，在模拟器中，文件被创建在$TMPDIR中)。
     当request完成时，会发生下面两件事之一：
        <1>如果数据是被压缩过（gzip）的，那么这个压缩过的文件将被解压到downloadDestinationPath，临时文件会被删除。
        <2>如果数据未被压缩，那么这个文件将被移动到downloadDestinationPath，冲突解决方式是：覆盖已存在的文件。
        <3>注意，如果服务器响应数据为空，那么文件是不会被创建的。如果你的返回数据可能为空，那么你应该先检查下载文件是否存在，再对文件进行操作。

     */
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:HTTP_TEST_URL];
    request.downloadDestinationPath = @"/Users/Desktop/my_file.txt";
    
    /*
     HTTP的状态码
     ASIHTTPRequest并不对HTTP状态码做任何处理（除了重定向和授权状态码，下面会介绍到），所以你必须自己检查状态值并正确处理。
     */
    NSInteger statusCode = request.responseStatusCode;
    NSString *statusMessage = request.responseStatusMessage;
    NSLog(@"%d:%@",statusCode,statusMessage);
    
    /*
     HTTP的响应头
     */
    NSString *poweredBy = [request.responseHeaders objectForKey:HTTP_KEY_POWEREDBY];
    NSString *contentType = [request.responseHeaders objectForKey:HTTP_KEY_CONTENTTYPE];
    NSLog(@"%@:%@:%@",poweredBy,contentType,request.responseHeaders);
    
    /*
     文本编码
     ASIHTTPRequest会试图读取返回数据的编码信息（Content-Type头信息）。如果它发现了编码信息，它会将编码信息设定为合适的 NSStringEncoding.如果它没有找到编码信息，它会将编码设定为默认编码（NSISOLatin1StringEncoding）。
     当你调用[request responseString]，ASIHTTPRequest会尝试以responseEncoding将返回的Data转换为NSString。
     */
    
    /*
     重定向
     当遇到以下HTTP状态码之一时，ASIHTTPRequest会自动重定向到新的URL：
     301 Moved Permanently(永久的、长期的)
     302 Found
     303 See Other
     
     当发生重定向时，响应数据的值（responseHeaders，responseCookies，responseData，responseString等等）将会映射为最终地址的相应返回数据。
     当URL发生循环重定向时，设置在这个URL上的cookie将被储存到全局域中，并在适当的时候随重定向的请求发送到服务器。
     (Cookies set on any of the urls encountered during a redirection cycle will be stored in the global cookie store, and will be represented to the server on the redirected request when appropriate.)
     
     你可以关闭自动重定向：将shouldRedirect设置为NO。
     默认情况下，自动重定向会使用GET请求（请求体为空）。这种行为符合大多数浏览器的行为，但是HTTP spec规定301和302重定向必须使用原有方法。
     要对301、302重定向使用原方法（包含请求体），在发起请求之前，设置shouldUseRFC2616RedirectBehaviour 为YES。
     */
}

#pragma mark -
#pragma mark ASI Progress进度追踪
- (void)trackForDowunLoadProgress
{
    /*
     每个ASIHTTPRequest有两个delegate用来追踪进度：
     downloadProgressDelegate(下载)
     uploadProgressDelegate (上传).
     进度delegate可以是NSProgressIndicators (Mac OS X) 或者 UIProgressViews (iPhone).ASIHTTPRequest会自适应这两个class的行为。你也可以使用自定义class作为进度delegate，只要它响应setProgress:函数。
     如果你执行单个request，那么你需要为该request设定upload/download进度delegate
     如果你在进行多个请求，并且你想要追踪整个队列中的进度，你必须使用ASINetworkQueue并设置队列的进度delegate
     如果上述两者你想同时拥有，恭喜你，0.97版以后的ASIHTTPRequest，这个可以有 ^ ^
     
     IMPORTANT:如果你向一个要求身份验证的网站上传数据，那么每次授权失败，上传进度条就会被重置为上一次的进度值。因此，当与需要授权的web服务器交互时，建议仅当useSessionPersistence为YES时才使用上传进度条，并且确保你在追踪大量数据的上传进度之前，先使用另外的request来进行授权。
     追踪小于128KB的数据上传进度目前无法做到，而对于大于128kb的数据，进度delegate不会收到第一个128kb数据块的进度信息。这是因为CFNetwork库API的限制。PS:貌似苹果已经跟新改正了该问题。
     */
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:HTTP_TEST_URL];
    UIProgressView *progressView = [[[UIProgressView alloc] init] autorelease];
    [request setDownloadProgressDelegate:progressView];
    [request startSynchronous];
    
    NSLog(@"Progress:%f",progressView.progress);
    
    /*
     一系列的Requst的进度
     */
    [_asiQueue cancelAllOperations];
    [_asiQueue setDownloadProgressDelegate:progressView];
    [_asiQueue setDelegate:self];
    //selector中可以得到进度
    [_asiQueue setRequestDidFinishSelector:@selector(requestFinished:)];
    int i;
    for (i = 0; i < 5; i++)
    {
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:HTTP_TEST_URL];
        [_asiQueue addOperation:request];
    }
    [_asiQueue go];
    
    /*
     ASIHTTPRequest提供两种进度条显示，简单进度条和精确进度条，使用ASIHTTPRequests 和ASINetworkQueues的showAccurateProgress 来控制。为一个request设置showAccurateProgress只会对该request有效。如果你为一个队列设置showAccurateProgress，那么会影响队列里所有的request。
     简单进度条
     当使用简单进度条时，进度条只会在一个request完成时才更新。对于单个request，这意味着你只有两个进度状态：0%和100%。对于一个有5个request的队列来说，有五个状态：0%，25%，50%，75%，100%，每个request完成时，进度条增长一次。
     简单进度条（showAccurateProgress = NO）是ASINetworkQueue的默认值，适用于大量小数据请求。
     
     精确进度条
     当使用精确进度条时，每当字节被上传或下载时，进度条都会更新。它适用于上传/下载大块数据的请求，并且会更好的显示已经发送/接收的数据量。
     使用精确进度条追踪上传会轻微降低界面效率，因为进度delegate（一般是UIProgressViews 或NSProgressIndicators）会更频繁地重绘。
     使用精确进度条追踪下载会更影响界面效率，因为队列会先为每个GET型request进行HEAD请求，以便统计总下载量。强烈推荐对下载大文件的队列使用精确进度条，但是要避免对大量小数据请求使用精确进度条。
     精确进度条（showAccurateProgress = YES）是以同步方式执行的ASIHTTPRequest的默认值。
     */
    request.showAccurateProgress = YES;
    _asiQueue.showAccurateProgress = YES;
    
    /*
     自定义进度需要实现的
     ASIProgressDelegate 协议定义了所有能更新一个request进度的方法。多数情况下，设置你的uploadProgressDelegate或者 downloadProgressDelegate为 NSProgressIndicator或者UIProgressView会很好。但是，如果你想进行更复杂的追踪，你的进度delegate实现下列函数要比 setProgress: (iOS) 或者 setDoubleValue: / setMaxValue: (Mac)好：
     这些函数允许你在实际量的数据被上传或下载时更新进度，而非简单方法的0到1之间的数字。
     downloadProgressDelegates方法
     request:didReceiveBytes: 每次request下载了更多数据时，这个函数会被调用（注意，这个函数与一般的代理实现的request:didReceiveData:函数不同）。
     request:incrementDownloadSizeBy: 当下载的大小发生改变时，这个函数会被调用，传入的参数是你需要增加的大小。这通常发生在request收到响应头并且找到下载大小时。
     uploadProgressDelegates方法
     request:didSendBytes: 每次request可以发送更多数据时，这个函数会被调用。注意：当一个request需要消除上传进度时（通常是该request发送了一段数据，但是因为授权失败或者其他什么原因导致这段数据需要重发）这个函数会被传入一个小于零的数字。
     */
}

- (void)trackForUpLoadProgress
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:HTTP_TEST_URL];
    [request setPostValue:@"zhang" forKey:@"name"];
    [request setPostValue:@"ss" forKey:@"test"];
    UIProgressView *progressView = [[[UIProgressView alloc] init] autorelease];
    [request setUploadProgressDelegate:progressView];
    [request startSynchronous];
    NSLog(@"Progress:%f",progressView.progress);
    /*
     一系列的Requst的进度
     */
    [_asiQueue cancelAllOperations];
    [_asiQueue setUploadProgressDelegate:progressView];
    [_asiQueue setDelegate:self];
    //selector中可以得到进度
    [_asiQueue setRequestDidFinishSelector:@selector(requestFinished:)];
    int i;
    for (i = 0; i < 5; i++)
    {
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:HTTP_TEST_URL];
        [request setPostValue:@"zhang" forKey:@"name"];
        [_asiQueue addOperation:request];
    }
    [_asiQueue go];
}

#pragma mark -
#pragma mark ASI 身份验证
- (void)checkAuthor
{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:HTTP_TEST_URL];
    //设置用户名和密码
    request.username = @"";
    request.password = @"";
    
    /*
     如果打开了keychainPersistence，所有提供的可用的用户名和密码将被存储到keychain中，以后的request将会重用这些用户名密码，即使你关闭程序后重新打开也不影响。
     */
    request.useKeychainPersistence = YES;
    
    /*
     将授权凭据存储到session中
     如果打开了useSessionPersistence（默认即是如此），ASIHTTPRequest会把凭据存储到内存中，后来的request将会重用这些凭据。
     
     你不一定非要提前指定授权凭据，你还可以让每个request在无法从session或keychain中找到凭据时向它们的代理请求凭据。如果你要连接到一个你并不清楚授权类型的服务器时，这是很有用的。
     你的delegate必须实现authenticationNeededForRequest:方法，当request等待凭据时，ASIHTTPRequest将会暂停这个request。如果你持有你需要的凭据，那么先为request设定凭据，然后调用[request retryUsingSuppliedCredentials]即可。如果你想取消授权，调用[request cancelAuthentication]，此时，这个request也会被取消。
     从1.0.8版开始，一次只能有一个request的delegate收到authenticationNeededForRequest: 或者 proxyAuthenticationNeededForRequest:。当delegate处理第一个request时，其他需要授权的request将会被暂停。如果提供了一个凭据，当前进程中所有其他的request将会假定这个凭据对这个URL有效，并尝试重用这个凭据。如果delegate取消了授权，并且队列的shouldCancelAllRequestsOnFailure值为YES，所有其他的request都将被取消（它们也不会尝试请求凭据）。
     */
    request.useSessionPersistence = YES; //这一项一般情况下是默认的 无需手动打开
    
    /*
     NTLM授权
     要使用NTLM授权的Windows服务器，你还需要指定你要进行授权域。
     */
    request.domain = @"my_domaim";
    
    /*
     使用内建的授权对话框（目前只对iOS有效）
     这个特性归功于1.0.8版本的新类ASIAuthenticationDialog 。这个特性主要是用于授权代理，但是它也可以用来向用户取得授权凭据。
     为了更好的用户体验，大多数（连接单一服务的）app必须为request的delegate实现authenticationNeededForRequest:方法，或者避免同时使用代理式授权。
     (most apps that connect to a single service should implement authenticationNeededForRequest: in their request delegates, or avoid the use of delegation-style authentication altogether.)

     但是，会有一些情况下，为普通的授权使用ASIHTTPRequest的标准授权对话框更好：
     你不想创建你自己的登录表单
     你可能需要从外部资源获取数据，但是你不清楚你需不需要进行授权
     对于这些情况，为request设置shouldPresentAuthenticationDialog为YES，此时，如果你的代理没有实现authenticationNeededForRequest:方法，那么用户将会看到一个对话框。一次同时只有一个对话框可以显示出来，所以当一个对话框显示时，所有其他需要授权的request将会暂停。如果提供了一个凭据，当前进程中所有其他的request将会假定这个凭据对这个URL有效，并尝试重用这个凭据。如果delegate取消了授权，并且队列的shouldCancelAllRequestsOnFailure值为YES，所有其他的request都将被取消（它们也不会尝试请求凭据）。
     对于同步请求的request，授权对话框不会显示出来。
     这个对话框部分模仿了iPhone上Safari使用的授权对话框，它包含以下内容：
     一段信息来说明这些凭据是用于websever（而非一个proxy）
     你将要连接到服务器的主机名或者IP
     授权域（如果提供的话）
     填写用户名和密码的区域
     当连接到NTLM授权模式的服务器时，还会包含一个填写domain的区域
     一个说明信息，指明凭据是否将会被以明文方式发送（例如：“只有当使用基于非SSL的基本授权模式时才会以明文方式发送”）
     如果你想改变它的外观，你必须继承ASIHTTPRequest，并重写showAuthenticationDialog来显示你自己的对话框或ASIAuthenticationDialog子类。
     */
    request.shouldPresentAuthenticationDialog = YES;
    
    /*
     在服务器请求凭据前向服务器发送凭据
     在第一次生成request时，ASIHTTPRequest可以先向服务器发送凭据（如果有的话），而不是等服务器要求提供凭据时才提供凭据。这个特性可以提高使用授权的程序的执行效率，因为这个特性避免了多余的request。
     对于基本授权模式，要触发这个行为，你必须手动设置request的authenticationScheme为kCFHTTPAuthenticationSchemeBasic：
     [request setAuthenticationScheme:(NSString *)kCFHTTPAuthenticationSchemeBasic];
     对于其他授权方案，凭据也可以在服务器要求之前被发送，但是仅当有另一个request成功授权之后才行。
     在以下情况下，你也许想要禁用这个特性：
     你的程序可能会一次使用一系列凭据来与服务器对话
     安全性对于你的程序来说非常重要。使用这个特性是相对不安全的，因为你不能在凭据被发送前验证你是否连接到了正确的服务器。
     */
    request.shouldPresentCredentialsBeforeChallenge = NO;
}

#pragma mark -
#pragma mark ASI Cookies 缓存
- (void)userCookies
{
    /*
     持久化cookie
     ASIHTTPRequest允许你使用全局存储来和所有使用CFNetwork或者NSURLRequest接口的程序共享cookie。
     如果设置useCookiePersistence为YES（默认值），cookie会被存储在共享的 NSHTTPCookieStorage 容器中，并且会自动被其他request重用。值得一提的是，ASIHTTPRequest会向服务器发送其他程序创建的cookie（如果这些cookie对特定request有效的话）。
     你可以清空session期间创建的所有cookie：
     [ASIHTTPRequest setSessionCookies:nil];
     这里的‘session cookies’指的是一个session中创建的所有cookie，而非没有过期时间的cookie（即通常所指的会话cookie，这种cookie会在程序结束时被清除）。
     另外，有个方便的函数 clearSession可以清除session期间产生的所有的cookie和缓存的授权数据。
     */
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:HTTP_TEST_URL];
    request.useCookiePersistence = YES; //默认值
    [ASIHTTPRequest setSessionCookies:nil]; //清空
    [ASIHTTPRequest clearSession];
    
    /*
     自己处理cookie
     如果你愿意，你大可以关闭useCookiePersistence，自己来管理某个request的一系列cookie.
     */
    NSMutableDictionary *property = [NSMutableDictionary dictionaryWithCapacity:10];
    [property setValue:@"testValue" forKey:NSHTTPCookieValue];
//    [property setValue:[@"testValue" encodedCookieValue] forKey:NSHTTPCookieValue];
    [property setValue:@"ASIHTTPRequestTestCookie" forKey:NSHTTPCookieName];
    [property setValue:@"zs.com" forKey:NSHTTPCookieDomain];
    [property setValue:[NSDate dateWithTimeIntervalSinceNow:60*60] forKey:NSHTTPCookieExpires];
    [property setValue:@"/asi-http-request/tests" forKey:NSHTTPCookiePath];
    NSHTTPCookie *cookie = [[NSHTTPCookie alloc] initWithProperties:property];
    request.useCookiePersistence = NO;
    [request setRequestCookies:[NSArray arrayWithObject:cookie]];
    [request startSynchronous];
    
    //将会打印: I have 'Test Value' as the value of 'ASIHTTPRequestTestCookie'
    NSLog(@"%@",[request responseString]);

}

@end
