//
//  PrivacyViewController.h
//  Megafon
//
//  Created by zhangss on 11-10-11.
//  Copyright 2011 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"

@interface PrivacyViewController : BaseController<UIWebViewDelegate>
{
	UIWebView   *m_privacyWebView;
	//BOOL        m_bisWaitViewShow;
	//UIAlertView *m_alertError;
}
@end
