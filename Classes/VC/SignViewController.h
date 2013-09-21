//
//  SignViewController.h
//  RCS
//
//  Created by lifuzhen on 11-7-5.
//  Copyright 2011 广州市易杰数码科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseController.h"
#import "AppConfig.h"
#import "CustomUIBarButtonItem.h"
#import "HavePlaceHoldTextView.h"
@interface SignViewController : BaseController
<UITableViewDelegate,
UITableViewDataSource,
UITextViewDelegate,
UITextFieldDelegate> 
{
	UISwitch *signSwitch;
	HavePlaceHoldTextView *signText;
	NSString *signApp;
	NSString *signC;
	UITableView *signTable;
	UIActivityIndicatorView *activeView;
	BOOL switchState;
	UITextField *totalText;
	NSInteger signatureLength;
	BOOL		  beginInput;
	CustomUIBarButtonItem *saveButton;
}
@property (nonatomic, retain) UISwitch *signSwitch;
@property (nonatomic, retain) HavePlaceHoldTextView *signText;
@property (nonatomic, retain) UITableView *signTable;
@property (nonatomic, retain) NSString *signC;
@property (nonatomic, retain) NSString *signApp;
@property (nonatomic, assign) BOOL switchState;
@property (nonatomic, retain) UITextField *myTotalText;
@property (nonatomic,retain) CustomUIBarButtonItem *saveButton;
- (void)addNotification;
@end
