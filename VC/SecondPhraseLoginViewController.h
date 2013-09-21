//
//  SecondPhraseLoginViewController.h
//  RCS
//
//  Created by zuodongdong on 2012/4/1.
//  Copyright 2011 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "CustomUIBarButtonItem.h"
#import "MBProgressHUD.h"



@interface SecondPhraseLoginViewController : BaseController<UIAlertViewDelegate,UITextFieldDelegate,UIScrollViewDelegate>
{
	BOOL   isAgreebool;
	BOOL   isAcceptbool;	
	UIButton	*AgreeBtn;
	UIButton	*AcceptBtn;
	NSString	*namestr;
	NSString	*pwdstr;
	UITextField *nameField;
	UITextField *pwdField;
	BOOL		busePhoneBook;
	CustomUIBarButtonItem *leftButton;
	
	UIImageView *m_imgRegistSuccess;
	MBProgressHUD *m_MBProgreeHuD;
	UIScrollView  *m_scrollView;
 
    NSString   *random;
}

@property (assign) BOOL isAgreebool;
@property (assign) BOOL isAcceptbool;
@property (assign) BOOL busePhoneBook;
@property (nonatomic,retain) UIButton *AgreeBtn;
@property (nonatomic,retain) UIButton *AcceptBtn;
@property (nonatomic,retain) UITextField *nameField;
@property (nonatomic,retain) UITextField *pwdField;
@property (nonatomic,retain) NSString *namestr;
@property (nonatomic,retain) NSString *pwdstr;
@property (nonatomic,retain) NSString   *random;

@end
