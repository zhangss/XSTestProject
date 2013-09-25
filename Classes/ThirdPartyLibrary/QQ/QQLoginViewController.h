//
//  QQLoginViewController.h
//  XSTestProject
//
//  Created by zhangss on 13-9-25.
//
//

#import "BaseController.h"

@interface QQLoginViewController : BaseController
<UIWebViewDelegate>
{
    UIWebView *_webView;
    NSString *_token;
    NSString *_openID;
}

@end
