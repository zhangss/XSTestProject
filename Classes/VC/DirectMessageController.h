//
//  DirectMessageController.h
//  Megafon
//
//  Created by zhangss on 12-3-19.
//  Copyright 2012 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BgScrollView.h"
#import "NewDirectorMessageController.h"
#import "DMSessionController.h"
#import "EGORefreshTableHeaderView.h"

@protocol DirectMessageControllerDelegate
@optional

- (void)readDataFromDB;

@end

@interface DirectMessageController : BaseController <UITableViewDelegate,UITableViewDataSource,BgScrollViewDelegate,EGORefreshTableHeaderDelegate,DMSessionControllerDelegate>
{
	UITableView			*m_directTableView;
	BgScrollView		*m_bgScroll;
	
	NSMutableArray		*m_cellArray;       //数据源 cell
	NSMutableArray		*m_dataArray;       //数据源 cell显示内容
	int					waitingCount;
	id <DirectMessageControllerDelegate> m_delegate;
	NSMutableDictionary *m_dmDictionary;    //数据源 字典
	BOOL				m_isMoreSelected;
	NSMutableArray		*m_feedArray;       //数据源 所有的Feed
	NSMutableArray      *m_funsArr;         //twitter followers的数据
    
    NSDate              *m_dmPreTimeMark;   //私信显示 第一条的时间标签
    NSDate              *m_dmNextTimeMark;  //私信显示 最后一天的时间标签
    NSMutableArray      *returnCodeArr;     //返回结果的Arr
    EGORefreshTableHeaderView   *refreshHeaderView;
    EGORefreshTableHeaderView   *refreshFooterView;
    BOOL                m_isRefresh;
}
@property(nonatomic,assign) id <DirectMessageControllerDelegate> m_delegate;
@property(nonatomic,retain) NSMutableArray *m_funsArr;
@property(nonatomic,retain) NSDate *m_dmPreTimeMark;
@property(nonatomic,retain) NSDate *m_dmNextTimeMark;

- (void)updateRefreshFooter;
@end
