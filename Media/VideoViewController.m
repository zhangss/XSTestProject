//
//  VideoViewController.m
//  XSTestProject
//
//  Created by 张松松 on 13-6-7.
//
//

#import "VideoViewController.h"

@interface VideoViewController ()

@end

#define MAXTIMEOUT 25
#define PLAYBUTTON_TAG 11
#define IMAGE_TAG 12
#define kProgressViewTag 1001

@implementation VideoViewController

@synthesize movieUrl;
@synthesize videoWebView;
@synthesize videoEndImage;
@synthesize loadByWebView;
@synthesize moviePlayerViewController;


#pragma mark -
#pragma mark Init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    self.moviePlayerViewController = nil;
    [movieUrl release];
    if(videoWebView)
    {
        [videoWebView stopLoading];
        videoWebView.delegate = nil;
        [videoWebView release];
        videoWebView = nil;
    }
    [videoEndImage release];
    [super dealloc];
}

#pragma mark - 
#pragma mark Life Cycel
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor grayColor];
    self.navigationItem.titleView = [XSTestUtils navigationTitleWithString:NSLocalizedString(@"Video",@"")];
    
    //是否网络视频
    if (WebVideo)
    {
        loadByWebView = YES;
    }
    else
    {
        //本地视频
        //获取文件
        NSString *fileName = [[NSBundle mainBundle] pathForResource:@"test_movie" ofType:@"mp4"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:fileName]) {
            //文件不存在
            return;
        }
        //文件路径获得，尝试多种格式，有些不支持，将视频放到resources即可
        //NSString *movieFile= [[NSBundle mainBundle] pathForResource:@"视频文件名" ofType:@"视频格式"];
        
        //转换为url格式的路径
        movieUrl = [[NSString stringWithFormat:@"%@",fileName] retain];
    }
    
    if (loadByWebView) //use the webview do the url request
    {
        //init the web view
        UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        webView.backgroundColor = [UIColor blackColor];
        webView.delegate = self;
        webView.scalesPageToFit = YES;
        webView.allowsInlineMediaPlayback = YES;
        webView.mediaPlaybackRequiresUserAction = YES;
        self.videoWebView = webView;
        [self.view addSubview:videoWebView];
        [webView release];
        
        //init request
        NSMutableURLRequest *videoRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:movieUrl]];
        [videoRequest setTimeoutInterval:15];
        [videoWebView loadRequest:videoRequest];
        [videoRequest release];
        
        //add wait view
        UIActivityIndicatorView *progressInd = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
        progressInd.alpha = 0.8;
        progressInd.tag = kProgressViewTag;
        progressInd.center = videoWebView.center;
        [self.view addSubview:progressInd];
        [progressInd startAnimating];
    }
    else
    {        
        /*
         !!!:文件路径转化成URL需要使用下面的方法 上面的方法转换成的URL为空
         */
        //NSURL *movieURL = [NSURL URLWithString:movieUrl];
        NSURL *movieURL = [[[NSURL alloc] initFileURLWithPath:movieUrl] autorelease];
        [self createAndConfigurePlayerWithURL:movieURL
                                   sourceType:MPMovieSourceTypeUnknown];
        
        //直接调用moviePlayer播放
        [self addVideothumbnailImage];
        //显示loading
        //code...
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidUnload
{
    [self deletePlayerAndNotificationObservers];
    
    self.movieUrl = nil;
    self.videoWebView = nil;
    self.videoEndImage = nil;
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Methods
//根据最后一帧图片的大小 返回需要显示的ImageV的大小 居中显示
- (CGRect)getImageViewRectFromeImageSize:(CGSize)aImageSize
{
    CGRect imageVRect = CGRectZero;
    CGFloat scale = aImageSize.width/aImageSize.height;
    CGRect viewFrame = self.view.frame;
    if (viewFrame.size.height * scale > viewFrame.size.width)
    {
        imageVRect = CGRectMake(0, 0, viewFrame.size.width, viewFrame.size.width / scale);
    }
    else
    {
        imageVRect = CGRectMake(0, 0, viewFrame.size.height * scale, viewFrame.size.height);
    }
    return imageVRect;
}


//添加缩略图 用于展示
- (void)addVideothumbnailImage
{
    if (nil == videoEndImage)
    {
        //没有视频缩略图 自己从视频中获取
        NSURL *movieURL = [[[NSURL alloc] initFileURLWithPath:movieUrl] autorelease];
        videoEndImage = [[XSTestUtils thumbnailImageForVideo:movieURL atTime:0.0] retain];
        if (nil == videoEndImage)
        {
            //默认图片
            videoEndImage = [[UIImage imageNamed:@"sampleIamge2.jpg"] retain];
        }
    }
    
    UIImageView *videoImageV = (UIImageView*)[self.view viewWithTag:IMAGE_TAG];
    if (!videoImageV)
    {
        CGSize imageSize = videoEndImage.size;
        if (!CGSizeEqualToSize(imageSize,CGSizeZero))
        {
            CGRect imageVRect = [self getImageViewRectFromeImageSize:imageSize];
            UIImageView *videoImageV = [[UIImageView alloc] init];
            videoImageV.frame = imageVRect;
            videoImageV.tag = IMAGE_TAG;
            videoImageV.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0 -30);
            videoImageV.image = videoEndImage;
            [self.view addSubview:videoImageV];
            [videoImageV release];
        }
    }
    
    //add play button
    UIButton *playBtn = (UIButton*)[self.view viewWithTag:PLAYBUTTON_TAG];
    if (!playBtn)
    {
        UIImage *playImage = [UIImage imageNamed:@"viose_icon"];
        UIButton *playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        playButton.tag = PLAYBUTTON_TAG;
        [playButton addTarget:self action:@selector(playMovie) forControlEvents:UIControlEventTouchUpInside];
        [playButton setBackgroundImage:playImage forState:UIControlStateNormal];
        //[playButton setBackgroundColor:[UIColor blueColor]];
        playButton.frame = CGRectMake((self.view.frame.size.width - playImage.size.width) / 2,
                                      (self.view.frame.size.height - 44 - playImage.size.height) / 2,
                                      playImage.size.width, playImage.size.height);
        [self.view addSubview:playButton];
    }
    
}

- (void)removeVideothumbnailImage
{
    UIButton *playBtn = (UIButton*)[self.view viewWithTag:PLAYBUTTON_TAG];
    if (playBtn)
    {
        [playBtn removeFromSuperview];
    }
    UIImageView *videoImageV = (UIImageView*)[self.view viewWithTag:IMAGE_TAG];
    if (videoImageV)
    {
        [videoImageV removeFromSuperview];
    }
}

#pragma mark -
#pragma mark MoviewPlayer Method
-(void)createAndConfigurePlayerWithURL:(NSURL *)aMovieURL sourceType:(MPMovieSourceType)sourceType
{
    MPMoviePlayerViewController *playerViewController = [[MPMoviePlayerViewController alloc] initWithContentURL:aMovieURL];
    [self setMoviePlayerViewController:playerViewController];
    
    videoEndImage= [[playerViewController.moviePlayer thumbnailImageAtTime:0 timeOption:MPMovieTimeOptionExact] retain];
    [playerViewController release];

    //设置属性
    MPMoviePlayerController *aplayer = [self.moviePlayerViewController moviePlayer];
    [aplayer setContentURL:aMovieURL];
    aplayer.movieSourceType = sourceType;
    aplayer.controlStyle = MPMovieControlStyleFullscreen;
    aplayer.repeatMode = MPMovieRepeatModeNone;
    
    //add Notifacation
    [self installMovieNotificationObservers];
}

#pragma mark -
#pragma mark Movie Play Start
//手动点击播放
- (void)playMovie
{
    //显示loading
    //code...
    
    [[self.moviePlayerViewController moviePlayer] prepareToPlay];//准备播放
    [[self.moviePlayerViewController moviePlayer] play];
//    [self presentMoviePlayerViewControllerAnimated:self.moviePlayerViewController];
    [[UIApplication sharedApplication].keyWindow addSubview:self.moviePlayerViewController.view];
}

#pragma mark -
#pragma mark Movie Notification Handlers

-(void)installMovieNotificationObservers
{
    MPMoviePlayerController *player = [[self moviePlayerViewController] moviePlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification
                                               object:player];

}

-(void)removeMovieNotificationHandlers
{
    MPMoviePlayerController *player = [[self moviePlayerViewController]moviePlayer];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackStateDidChangeNotification object:player];    
}

-(void)deletePlayerAndNotificationObservers
{
    [self removeMovieNotificationHandlers];
    [self setMoviePlayerViewController:nil];
}

/*
 !!!:视频播放 切到后台 然后切换到前台 视频无法继续播放，会一直处于loading界面
 */

- (void)moviePlayBackDidFinish:(NSNotification*)notification
{
    NSNumber *reason = [[notification userInfo] objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
    switch ([reason integerValue])
    {
            /* The end of the movie was reached. */
        case MPMovieFinishReasonPlaybackEnded:
            NSLog(@"MPMovieFinishReasonPlaybackEnded");
            //自动播放到停止 不移除view
            moviePlayerViewController.moviePlayer.currentPlaybackTime = 0;
            moviePlayerViewController.moviePlayer.initialPlaybackTime = 0;
            break;
            
            /* An error was encountered during playback. */
        case MPMovieFinishReasonPlaybackError:
            NSLog(@"An error was encountered during playback");
            [moviePlayerViewController.moviePlayer stop];
            [moviePlayerViewController.view removeFromSuperview];
            
            [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:moviePlayerViewController.moviePlayer];
            [moviePlayerViewController release];
            moviePlayerViewController = nil;
            break;
            
            /* The user stopped playback. */
        case MPMovieFinishReasonUserExited:
            NSLog(@"MPMovieFinishReasonUserExited");
            //手动点击退出 移除view
            [self dismissMoviePlayerViewControllerAnimated];
            [moviePlayerViewController.view removeFromSuperview];
            break;
            
        default:
            break;
    }
}

/* Called when the movie playback state has changed. */
- (void) moviePlayBackStateDidChange:(NSNotification*)notification
{
    MPMoviePlayerController *player = notification.object;
    
    /* Playback is currently stopped. */
    if (player.playbackState == MPMoviePlaybackStateStopped)
    {
        NSLog(@"MPMoviePlaybackStateStopped");
    }
    /*  Playback is currently under way. */
    else if (player.playbackState == MPMoviePlaybackStatePlaying)
    {
        NSLog(@"MPMoviePlaybackStatePlaying");
    }
    /* Playback is currently paused. */
    else if (player.playbackState == MPMoviePlaybackStatePaused)
    {
        NSLog(@"MPMoviePlaybackStatePaused");
    }
    /* Playback is temporarily interrupted, perhaps because the buffer
     ran out of content. */
    else if (player.playbackState == MPMoviePlaybackStateInterrupted)
    {
        NSLog(@"MPMoviePlaybackStateInterrupted");
    }
}

#pragma mark -
#pragma mark UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}
#pragma mark -
#pragma mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
//    navigationType = UIWebViewNavigationTypeFormResubmitted;
    NSLog(@"====Video1===Cache=%d",[webView.request cachePolicy]);
    return YES;
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //***Begin*** [SNS播放视频统一调用网页播放] modify by zhangss 2012-09-05
    UIActivityIndicatorView *progressInd = (UIActivityIndicatorView *)[self.view viewWithTag:kProgressViewTag];
    [progressInd startAnimating];
    //***End***
    NSLog(@"====Video2===Cache=%d",[webView.request cachePolicy]);
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //***Begin*** [SNS播放视频统一调用网页播放] modify by zhangss 2012-09-05
    UIActivityIndicatorView *progressInd = (UIActivityIndicatorView *)[self.view viewWithTag:kProgressViewTag];
    [progressInd stopAnimating];
    //***End***
    NSLog(@"====Video3===Cache=%d",[webView.request cachePolicy]);
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    /*帧负荷中断
     Error Domain=WebKitErrorDomain Code=102 "Frame load interrupted" UserInfo=0x1520fa50 {NSErrorFailingURLKey=http://www.youtube.com/v/vREOu6Axt8o?version=3&autohide=1&autoplay=1, NSErrorFailingURLStringKey=http://www.youtube.com/v/vREOu6Axt8o?version=3&autohide=1&autoplay=1, NSLocalizedDescription=Frame load interrupted}
     */
    
    //Yotube不能播放的FlastURL http://www.youtube.com/v/vREOu6Axt8o?version=3&autohide=1&autoplay=1
    //组装一下 http://www.youtube.com/v/vREOu6Axt8o?&feature=player_embedded  添加&feature=player_embedded变成网页地址
    
    /*网络断链  没有翻墙
     Error Domain=NSURLErrorDomain Code=-1005 "The network connection was lost." UserInfo=0x15b1fef0 {NSErrorFailingURLStringKey=http://www.youtube.com/v/vREOu6Axt8o?version=3&autohide=1&autoplay=1, NSErrorFailingURLKey=http://www.youtube.com/v/vREOu6Axt8o?version=3&autohide=1&autoplay=1, NSLocalizedDescription=The network connection was lost., NSUnderlyingError=0x15b30df0 "The network connection was lost."}
     */
    
    /*超时 10s
     Error Domain=NSURLErrorDomain Code=-1001 "The request timed out." UserInfo=0x9143030 {NSErrorFailingURLStringKey=http://www.youtube.com/watch?v=IfJe7_d9mHo&feature=share, NSErrorFailingURLKey=http://www.youtube.com/watch?v=IfJe7_d9mHo&feature=share, NSLocalizedDescription=The request timed out., NSUnderlyingError=0x913c270 "The request timed out."}
     */
    
    //***Begin*** [取消风火轮] modify by xiaoxidong 2012-12-12 add
    UIActivityIndicatorView *progressInd = (UIActivityIndicatorView *)[self.view viewWithTag:kProgressViewTag];
    [progressInd stopAnimating];
    //***End*** [取消风火轮] modify by xiaoxidong 2012-12-12 add
    
    //***begin*** [修改了错误捕获处理]  xiaoxidong 2012/12/01 modify
    NSString *errorString = nil;
    if (error.code == -1001)
    {
        errorString = [NSString stringWithString:NSLocalizedString(@"Request timeout.",@"")];
    }
    else if(error.code == -1005)
    {
        //errorString = [NSString stringWithString:NSLocalizedString(@"The network connection is abnormal",@"")];
        errorString = @"";
    }
    else if(error.code == -1009)
    {
        //errorString = [NSString stringWithString:NSLocalizedString(@"Network unavailable",@"")];
        errorString = @"";
    }
    else
    {
        errorString = [NSString stringWithString:NSLocalizedString(@"Can’t connect to the server. Please check network",@"")];
    }
    NSLog(@"error code:%d,%@",[error code],errorString);
    //***begin*** [返回错误码为－999，为204错误时，并不是网页加载不成功错误，最终网页能够加载成功，此2中不当成错误处理] xiaoxidong 2012/12/12 modify
    if ([error code] != -999 &&  error.code != 204)
    {
        //此处根据错误码 进行提示
        //code...
        
        [self performSelector:@selector(backButtonClicked) withObject:nil afterDelay:1];
        return;
    }
    //***end*** [返回错误码为－999，为204错误时，并不是网页加载不成功错误，最终网页能够加载成功，此2中不当成错误处理] xiaoxidong 2012/12/12 modify
    //***end*** [修改了错误捕获处理]  xiaoxidong 2012/12/01 modify
    //[self.navigationController popViewControllerAnimated:YES];
    NSLog(@"====SNS Error====WebVideo=%@",error);
}


@end
