//
//  LinkThirdPartViewController.h
//  Megafon
//
//  Created by zhangss on 11-10-14.
//  Copyright 2011 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "Contact.h"

@interface LinkThirdPartViewController : BaseController <UITableViewDelegate,UITableViewDataSource> {
	
	Contact        *curContact;
	NSMutableArray *bindedThirdParty;                //绑定的第三方服务 数组
	NSMutableArray *bindedThirdPartyFriendCount;     //绑定的第三方服务的好友个数 数组
	
	NSInteger       fromType;                        //
}

@property (nonatomic,assign) NSInteger fromType;

- (void)initContact:(Contact *)contact;

@end
