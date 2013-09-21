//
//  AllServicesViewController.h
//  Megafon
//
//  Created by  dengyafeng on 12-3-29.
//  Copyright 2012 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DirectMessageController.h"


@interface AllServicesViewController : BaseController 
<UITableViewDelegate,
UITableViewDataSource,
DirectMessageControllerDelegate>
{

	UITableView *table;
	NSMutableArray *datalist;
	
	//UIView *coverView;
}
@property (nonatomic, retain) NSMutableArray *datalist;
@property (nonatomic, retain) UITableView *table;


- (void)refreshDataSource;

// add by gengjf 2012-04-05
- (void)setVisible:(BOOL)visible;
//

//- (void)refreshCoverViewFrame:(CGRect)theRect;
@end
