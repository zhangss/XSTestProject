//
//  SNSBindViewController.h
//  Megafon
//
//  Created by  zhangss on 11-10-31.
//  Copyright 2011 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "ThirdAccountInfo.h"
/*
 本页面以WebView实现SNS绑定的功能,本页面仅用于此
 */

@interface SNSBindViewController : BaseController <UIWebViewDelegate,UIAlertViewDelegate>
{
	UIWebView    *bindWeb;         //加载内容的主View
//	UIAlertView  *alertError;	   //错误提示 绑定超时
	BOOL         isWaitViewShow;   //显示等待框
	UIView       *hideView;
	NSInteger    type;
	id           _object;          //父试图
	
	BOOL         isBindSuccess;    //标志是否绑定成功 可能出现失败之后 返回成功的情况
	BOOL         isAlertShowing;    //标志是否绑定成功 可能出现失败之后 返回成功的情况
    
    //超时相关
    NSTimer *checkTimer;	
}
@property(nonatomic, retain)NSDate *startLoadTime;
@property(nonatomic, retain)NSTimer *checkTimer;


//传入需要绑定的第三方SNS类型 及本页面的父视图
- (id)initWithSNSType:(NSInteger)snsType andParent:(id)parent;
//请求绑定返回成功之后做的事情
- (void)doSomethingAfterLogin;
- (void)setCheckTimer:(NSTimer *)timer;
- (void)checkTimerout:(NSTimer*)timer;
- (void)finishWithFailed:(NSString *)alertString;

@end
