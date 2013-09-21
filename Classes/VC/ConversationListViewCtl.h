//
//  ConversationListViewCtl.h
//  Megafon
//
//  Created by  sunliang on 12-2-12.
//  Copyright 2012 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "MixSearchMessageView.h"
#import "IMandSMScheck.h"
#import "BaseController.h"
#import <CoreData/CoreData.h>
#import "MIXModelSortData.h"
#define CURRENT_PAGE_NUMBER 30

@class SessionModel;
@interface ConversationListViewCtl : BaseController
<UITableViewDelegate,UITableViewDataSource,
EGORefreshTableHeaderDelegate,
MixSearchMessageDelegate,UITextFieldDelegate,
NSFetchedResultsControllerDelegate>
{

	UITableView *_tableView;
	
	MixSearchMessageView *mySearchBar;
	UIButton *searchBackView;
	BOOL isSearching;//是否正在搜索
	MIXModelSortData *filterArray;//存储搜索结果的数组
    BOOL isSearchText;//是否有 有效的搜索字符串
	
	//add by zuodd 2012/4/27 begine
	UIImageView *toptipsview;
	//end
	
	MIXModelSortData *allSessionModel;//所有的会话
	
	EGORefreshTableHeaderView *_refreshHeaderView;//下拉刷新视图
	BOOL isRefresh;//标识是否正在下拉刷新
	CGSize keyBoardSize;
	
	//保存要删除的ModalID
	NSString *m_currentDeleteModelId;
	
	BOOL bIsDeleteSendMsgSucess;
    
    NSFetchedResultsController *sModelFetchResultsController;
    

    BOOL isVisible;
    BOOL isNeedReload;
    
    NSMutableArray * changeArray;
    
    int searchID;
}

@property (nonatomic ,retain) MixSearchMessageView *mySearchBar;
@property (nonatomic ,copy) NSString *currentDeleteModelId;
@property (nonatomic ,retain) NSFetchedResultsController *sModelFetchResultsController;


- (void)deleteChat:(NSIndexPath *)deleteIndex;

- (void)startLoadData;
- (void)stopLoadData;
- (void)addKeyBoardNotification;

- (void) hideSearch;

- (void)onNAStatusUpdate;
@end
