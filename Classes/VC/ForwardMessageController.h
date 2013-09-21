//
//  ForwardMessageController.h
//  Megafon
//
//  Created by zhangshengrong on 11-10-17.
//  Copyright 2011 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "RMCManager.h"
#import "ForwardPolicy.h"
#import "RuleCell.h"
#import "RulesViewController.h"
#import "CABMainViewController.h"


@interface ForwardMessageController : BaseController <UITableViewDelegate,UITableViewDataSource,
UITextFieldDelegate,UIAlertViewDelegate,
RuleCellDelegate,UITextFieldDelegate,CABListSelectDelegate>{
	
	UITableView *forwardTable;
	BOOL switchstate;				//业务开关状态
	NSMutableArray *rulesArray;
	BOOL isEdit;					  //是否处于删除状态
	BOOL isEditForwardName;			  //是否处于改变名字状态
	ForwardPolicy *rule;
	RuleCell *currEditCell;
	NSMutableArray *rulesToDelete;    // 需删除的rule数组
	NSMutableArray *policyToDelete;
	UIButton *deleteBtn;
	CalledCopyOrForwardType fromType;
    BOOL isNeedRollBack;
    NSInteger modifyPolicyCallBackCalledCount;
    NSString *currentFwRulesID;
    UISwitch *m_ConnectorForAllRull; //控制所有规则的开关
	BOOL isKeyboardShow;
}
@property (nonatomic, assign) CalledCopyOrForwardType fromType;
@property (nonatomic, assign) BOOL switchstate;
@property (nonatomic, assign) NSString *currentFwRulesID;
@property (nonatomic, retain) UISwitch *connectorForAllRull;//控制所有规则的开关
@end