//
//  BlackWhiteListViewController.h
//  Megafon
//
//  Created by lifuzhen on 12-5-4.
//  Copyright (c) 2012年 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "MBProgressHUD.h"
#import "CABMainViewController.h"
typedef enum {
	FromBlackList = 0,  //黑名单
	FromOtherShowPhone = 2,  //其它
}PushControllerType;


typedef enum {
	FromForwardSelect = 0,  //Forward
	FromCopySelect = 1  // copy
}FromWhichNumSelType;

@protocol BlackWhiteListViewControllerDelegate <NSObject>

@optional
- (void)parentControllerArray:(NSMutableArray*) array;

@end

@interface BlackWhiteListViewController : BaseController
<UITableViewDelegate,
UITableViewDataSource,
UITextFieldDelegate,
CABListSelectDelegate>
{
    PushControllerType fromType;
    
    UITableView *tableView;
    
    NSMutableArray *resouceArray;       //展示列表数据
    NSMutableArray *wantDeleteArray;    //要删除的数据
    NSMutableArray *wantAddArray;       //要添加的数据
    
    BOOL isEdit;
    BOOL isPop;
    UISwitch *switchView;
    UITextField *inputText;
    
    id <BlackWhiteListViewControllerDelegate> delegate;
    
    FromWhichNumSelType fromWhichNumType;
}

@property (nonatomic, retain) NSMutableArray *resouceArray;
@property (nonatomic, assign) PushControllerType fromType;
@property (nonatomic, assign) FromWhichNumSelType fromWhichNumType;
@property (nonatomic, assign) id <BlackWhiteListViewControllerDelegate> delegate;


@end
