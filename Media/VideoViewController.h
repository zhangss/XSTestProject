//
//  VideoViewController.h
//  XSTestProject
//
//  Created by 张松松 on 13-6-7.
//
//

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "MediaPlayer/MediaPlayer.h"
/*
 该页面可以用于完成以下类型简单的界面加载
 1.WebView 网页展示视频
 2.MPMoviePlayerController 视频
 */

//视频模式 本地/网络 视频
#define WebVideo 0


@interface VideoViewController : BaseController <UIWebViewDelegate,UINavigationControllerDelegate>
{
	NSString  *movieUrl;       //传入的URL
	UIWebView *videoWebView;  //加载的WebView
	UIImage   *videoEndImage;  //视频播放结束之后最后一帧图片
	BOOL      loadByWebView;   //是否是用WebView加载URL
        
    MPMoviePlayerViewController *moviePlayerViewController;
}

@property (retain) MPMoviePlayerViewController *moviePlayerViewController;
@property (nonatomic, retain)NSString *movieUrl;
@property (nonatomic, retain)UIWebView *videoWebView;
@property (nonatomic, retain)UIImage *videoEndImage;
@property (nonatomic, assign)BOOL loadByWebView;


@end



