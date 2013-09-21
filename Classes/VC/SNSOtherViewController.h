//
//  SNSOtherViewController.h
//  Megafon
//
//  Created by zhangss on 12-4-10.
//  Copyright 2012 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import <MediaPlayer/MediaPlayer.h>
/*
 该页面可以用于完成以下类型简单的界面加载
 1.WebView 网页展示视频
 2.MPMoviePlayerController 视频
 */

@interface SNSOtherViewController : BaseController <UIWebViewDelegate> 
{
	NSString  *movieUrl;       //传入的URL
	UIWebView *videoWebView;   //加载的WebView
	BOOL      loadByWebView;   //是否是用WebView加载URL
}
@property (nonatomic, retain)NSString  *movieUrl;
@property (nonatomic, retain)UIWebView *videoWebView;
@property (nonatomic, assign)BOOL      loadByWebView;

@end
