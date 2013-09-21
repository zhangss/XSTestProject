//
//  GuideViewController.h
//  RCS
//
//  Created by lu jingyu on 11-7-22.
//  Copyright 2011 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "MBProgressHUD.h"
#import "RCSAppDelegate.h"

@interface GuideViewController : BaseController <UIScrollViewDelegate>{

	UIScrollView					*scrollView;
	UIPageControl					*pageControl;
	NSMutableDictionary				*dicGetLoaclNum;
	UIImageView						*imgwaitngGetTel;
	NSInteger						m_icounter;
}
- (void)createLoadingMBMode:(NSString*)message;
@end
