//
//  LoginViewController.h
//  RCS
//
//  Created by etop on 11-4-22.
//  Copyright 2011 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AesCrypt.h"
#import "Reachability.h"
#import "RCSAppDelegate.h"
#import "BaseController.h"
#import <SystemConfiguration/SCNetworkReachability.h>

#define TAG_BASE                9000
#define TAG_MBHUD               TAG_BASE + 4
#define TAG_MBHUD_REGIST		TAG_BASE + 5

@class RCSAccount;
         
@interface LoginViewController : BaseController <UITextFieldDelegate,UIAlertViewDelegate>
{
	UITextField						*nameField;			//名称框
	UITextField						*pwdField;			//密码框
	UIImageView						*waitingDlg;		//等待框
	UIImageView						*loginView;			//登录框
	UIControl						*backgroundView;	//背景框
    NSString                        *random;
    BOOL                            isLoginOut;			//是登出后显示
    BOOL                            wantToProcessLoginNotification; 
}
@property (nonatomic, retain)  UITextField *nameField;
@property (nonatomic, retain)  UITextField *pwdField;
@property (nonatomic, retain)  NSString    *random;
@property (nonatomic, assign) BOOL isLoginOut;//是登出后显示
@property (nonatomic, assign) BOOL wantToProcessLoginNotification;   //增加外部接口 注册界面登陆时需要调用

-(void)showWaiting;

@end
