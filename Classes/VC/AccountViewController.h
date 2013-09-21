//
//  AccountViewController.h
//  Megafon
//
//  Created by mac on 12-4-17.
//  Copyright 2012年 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "MBProgressHUD.h"
#import "ReturnCodeModel.h"
#import "AesCrypt.h"


@class ThirdAccountInfo;
@class RCSAccount;
@interface AccountViewController :BaseController<UITableViewDelegate,
UITableViewDataSource,UITextFieldDelegate,MBProgressHUDDelegate> 
{
    UITextField       *accountField;
    UITextField       *pwdField;
    NSString          *titleStr;
    UITableView       *table;
    RCSAccount        *currentAccount; 
//    NSTimer           *changeAccountTimer;//定时器多余 zhengxiaohe 2012-11-12
    ReturnCodeModel	  *returnCodeModel;
    NSInteger         imType;
	BOOL			  m_bchangeAccount;
    ThirdAccountInfo *tdIMAccount;    //保存第三方帐号
    NSString          *thirdAccount;
    NSString          *thirdPassword;
    AesCrypt          *m_aesCrypt; //加密对象声明  zhengxiaohe 2012-09-12 add
}

@property (nonatomic, copy)   NSString     *titleStr;
@property (nonatomic, retain) UITextField  *accountField;
@property (nonatomic, retain) UITextField  *pwdField;
@property (nonatomic, assign) NSInteger     imType;
@property (nonatomic, copy)   NSString     *thirdAccount;
@property (nonatomic, copy)   NSString     *thirdPassword;
@property (nonatomic, retain) AesCrypt     *aesCrypt;//加密对象声明  zhengxiaohe 2012-09-12 add
@property (nonatomic, retain) ThirdAccountInfo *tdIMAccount;
- (void)initSuperView;
@end
