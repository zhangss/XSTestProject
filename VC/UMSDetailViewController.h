//
//  UMSDetailViewController.h
//  Megafon
//
//  Created by lifuzhen on 12-4-6.
//  Copyright 2012 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileTableHeadView.h"
#import "RCSAccount.h"
#import "BaseController.h"

@interface UMSDetailViewController : BaseController 
<UITableViewDelegate,UITableViewDataSource>
{
	ProfileTableHeadView *umsHeadView;
	UITableView *umsTableView;
	RCSAccount *rcsAccount;
}
@end
