//
//  ZSProcessor.h
//  XSTestProject
//
//  Created by zhangss on 13-9-26.
//
//

#import <Foundation/Foundation.h>
#import "BaseProcessor.h"

/*
 ASI
 在平台支持情况下，ASIHTTPRequest1.8以上支持block。
 */

@interface ZSProcessor : BaseProcessor
<ASIHTTPRequestDelegate>
{
    NSOperationQueue *_nsQueue;
    ASINetworkQueue  *_asiQueue;
}

#pragma mark -
#pragma mark ASI同步请求
//同步请求会阻塞主线程的执行，这导致用户界面不响应用户操作，任何动画都会停止渲染。
- (void)startASISynchronous;

#pragma mark -
#pragma mark ASI异步请求
//下面是最简单的异步请求方法，这个request会在全局的NSOperationQueue中执行，若要进行更复杂的操作，我们需要自己创建NSOperationQueue或者ASINetworkQueue，后面会讲到。
- (void)startASIAsynchronous;

//在平台支持情况下，ASIHTTPRequest1.8以上支持block。
- (void)startASIAsynchronousWithInBlock;

#pragma mark -
#pragma mark Clear ASIRequest
//request并不retain它们的代理，所以有可能你已经释放了代理，而之后request完成了，这将会引起崩溃。
//大多数情况下，如果你的代理即将被释放，你一定也希望取消所有request，因为你已经不再关心它们的返回情况了。
- (void)clearASIRequset:(ASIHTTPRequest *)request;

#pragma mark -
#pragma mark ASI队列操作
//使用NSOperationQueue控制请求
- (void)startASIRequestInNSOperationQueue;

//使用ASINetworkQueues控制请求
- (void)startASIRequestInASINetworkQueues;

#pragma mark -
#pragma mark ASIFromateData Post 上传表单
- (void)postForms;

#pragma mark -
#pragma mark ASI DownLoad Data 下载数据
- (void)downLoadData;

#pragma mark -
#pragma mark ASI Progress进度追踪
- (void)trackForDowunLoadProgress;
- (void)trackForUpLoadProgress;

#pragma mark -
#pragma mark ASI 身份验证
- (void)checkAuthor;

#pragma mark -
#pragma mark ASI Cookies 缓存
- (void)userCookies;

#pragma mark -
#pragma mark ASI Compressed 压缩
- (void)doC;
@end
