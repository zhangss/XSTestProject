//
//  RulesViewController.h
//  Megafon
//
//  Created by zhangshengrong on 12-5-8.
//  Copyright 2012 华为技术有限公司. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "ForwardPolicy.h"
#import "WeekDaysController.h"
#import "DayTimeController.h"
#import "RulesViewController.h"

#import "BlackWhiteListViewController.h"
#import "CABMainViewController.h"



@interface RulesViewController : BaseController <UITableViewDelegate,
UITableViewDataSource,UITextFieldDelegate,UIAlertViewDelegate,
WeekDaysControllerDelegate,DayTimeControllerDelegate,BlackWhiteListViewControllerDelegate,CABListSelectDelegate>
{
	NSInteger	callType; //1:add,2:Advanced setting
	NSInteger	policyType; //0:forward,1:copy
	
	NSString     *daysString;
	NSString     *timeString;
	NSString     *numberString;
	NSString     *addressString;

	BOOL  isMoblieOrMail; //YES:mobile NO:Mail
	UITextField *addressText;
	UIButton *addBtn; 
	
	UITableView *ruleTable;
	
	NSMutableArray *rowsData;
	
	ForwardPolicy *policy;
}

@property (nonatomic, assign) NSInteger callType;
@property (nonatomic, assign) NSInteger policyType;

@property (nonatomic, retain) NSString    *daysString;
@property (nonatomic, retain) NSString    *timeString;
@property (nonatomic, retain) NSString    *numberString;
@property (nonatomic, retain) NSString    *addressString;

@property (nonatomic, retain) ForwardPolicy *policy;

@property (nonatomic, retain) UITextField *addressText;
@property (nonatomic, retain) UIButton *addBtn;


@end
