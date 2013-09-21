//
//  ContactAssistantViewController.h
//  Megafon
//
//  Created by lifuzhen on 11-12-18.
//  Copyright 2011 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"

@interface ContactAssistantViewController : BaseController <UITableViewDelegate,
UITableViewDataSource,UIActionSheetDelegate,UIAlertViewDelegate>
{
	UIView *bgView;
}

@end
