//
//  GuideThirdPartyBindingViewController.h
//  Megafon
//
//  Created by zhangss on 11-10-8.
//  Copyright 2011 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "MBProgressHUD.h"
#import "ReturnCodeModel.h"
#import "AesCrypt.h"

@class RCSAccount;
@class ThirdAccountInfo;
@interface GuideThirdPartyBindingViewController : BaseController
<UITableViewDelegate,
UITableViewDataSource,
UITextFieldDelegate,
MBProgressHUDDelegate> 
{
	UITableView       *table;
	RCSAccount        *currentAccount;
	UITextField       *accountField;
	UITextField       *pwdField;
	MBProgressHUD     *S_MBProgreeHuD;
	ReturnCodeModel	  *returnCodeModel;
	NSIndexPath       *indexPath; //记住用户点击的cell索引
	NSString          *titleStr;
    AesCrypt          *m_aesCrypt;//[加密数据库密码对象声明] 
    ThirdAccountInfo * m_TempThirdAccount; //临时存放第三方账号信息
    ThirdAccountInfo * m_ThirdAccount; //创建第三方表
    NSUInteger        m_ImType;      //第三方type
}
@property (nonatomic, retain) NSIndexPath *indexPath;
@property (nonatomic, copy)   NSString *titleStr;
@property (nonatomic, retain) AesCrypt *aesCrypt;
@property (nonatomic, retain) ThirdAccountInfo *tempThirdAccount;//临时存放第三方账号信息
@property (nonatomic, retain) ThirdAccountInfo *thirdAccount;//创建第三方表
@property (nonatomic, assign) NSUInteger imType; //第三方type
- (void)getNavTitle;
- (void)initSuperView;
@end
