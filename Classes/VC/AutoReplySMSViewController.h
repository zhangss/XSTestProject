//
//  AutoReplySMSViewController.h
//  Megafon
//
//  Created by lifuzhen on 12-2-21.
//  Copyright 2012 广州市易杰数码科技有限公司. All rights reserved.

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "RMCManager.h"
#import "CustomUIBarButtonItem.h"
#import "HavePlaceHoldTextView.h"

@interface AutoReplySMSViewController : BaseController
<UITableViewDelegate,
UITableViewDataSource,
UITextViewDelegate,
UITextFieldDelegate>
{
	UITableView   *replyTable;
	UISwitch      *switchview;
	HavePlaceHoldTextView    *m_Textview;
	UITextField   *myTotalText;
	NSInteger     autoReplyLength;
	NSString      *acontent;
	BOOL          isopen;
	RMCManager    *rmcManager;
	BOOL          isAlreadySetForAll;
	NSString      *autoForAllOperateID;
    CustomUIBarButtonItem *saveButton;
    UIActivityIndicatorView *activeView;
} 
@property (nonatomic, retain) UITableView  *replyTable;
@property (nonatomic, retain) UISwitch     *switchview;
@property (nonatomic, retain) HavePlaceHoldTextView   *textview;
@property (nonatomic, retain) NSString     *acontent;
@property (nonatomic, retain) UITextField  *myTotalText;
@property (nonatomic, retain) NSString     *autoForAllOperateID;
@property (nonatomic, retain)CustomUIBarButtonItem *saveButton;
- (void)getAutoData;
- (void)getDataFromServer;
@end
