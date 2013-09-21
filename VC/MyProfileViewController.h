//
//  MyProfileViewController.h
//  Megafon
//
//  Created by lifuzhen on 12-4-1.
//  Copyright 2012 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCSAccount.h"
#import "MBProgressHUD.h"
#import "BaseController.h"
#import "MyProfileHeadView.h"

@interface MyProfileViewController : BaseController <UITableViewDelegate,UITableViewDataSource,MyProfileHeadViewDelegate>{

	NSMutableArray *hasBindSNSArray;
	NSMutableArray *hasBindSNSContentArray;
	NSMutableArray *hasBindIMArray;
	NSMutableArray *hasBindIMContentArray;
    NSMutableDictionary *hasBindIMStatusDict;
	UITableView *profileTableView;
    MBProgressHUD *mBProgressHUD;
    NSTimer *refreshTimeOut;
	BOOL isRootView;	//标识是否是根视图,根视图要留出下面的tabBar区域(默认是YES)
    BOOL isVisibleView;
    BOOL m_isDealLogoutPressed;//防止多次弹出登出的提示框
    NSMutableSet   *onOrOfflineOperationType;
}
@property (nonatomic,retain) NSTimer  *refreshTimeOut;
@property (nonatomic ,assign) BOOL isRootView;

- (void)getMyProfileBlanceRequest;
@end
