//
//  AddServiceViewController.h
//  Megafon
//
//  Created by zhangshengrong on 12-4-3.
//  Copyright 2012 华为技术有限公司. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "GuideThirdPartyBindingViewController.h"
#import "BaseFriend.h"

@interface AddServiceViewController : BaseController <UITableViewDataSource,UITableViewDelegate> 
{
	UITableView *table;
	//未绑定的第三方数据源
	NSMutableArray *unbindedServerSNS;      //SNS
	NSMutableArray *unbindedServerIM;       //IM
}
@end
