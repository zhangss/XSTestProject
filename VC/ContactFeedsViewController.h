//
//  ContactFeedsViewController.h
//  Megafon
//
//  Created by zhangss on 11-10-27.
//  Copyright 2011 广州市易杰数码科技有限公司. All rights reserved.
//
//  
//  Management zhangss

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "Contact.h"
#import "EGORefreshTableHeaderView.h"
#import "SNSFeedData.h"
#import "BaseFriend.h"
#import "SNSListCell.h"

@interface ContactFeedsViewController : BaseController
<UITableViewDelegate, SNSListCellDelegate, UITableViewDataSource,
EGORefreshTableHeaderDelegate>
{
	Contact          *contact;              //融合之后 查看联系人融合的Feed
	BaseFriend       *TFFriend;             //group查看单个好友Feed
	UITableView      *myTableView;
	NSMutableArray   *myFeedsData;          //数据源
	NSMutableArray   *myCellArray;          //缓存的cell
	NSMutableArray   *linkedTFArray;        //融合的好友 融合界面使用
	NSMutableArray   *snsTypeArrary;        //需要刷新的第三方数组
		
	EGORefreshTableHeaderView *_refreshHeaderView;//下拉刷新视图
	BOOL             _reloading;            //标识是否正在下拉刷新	
	
    UILabel         *_noFeedsInfo;
    NSString        *m_curFeedID;             //当前选中的FeedID
    
    NSMutableDictionary       *m_heightDic;
    SNSListCell               *snscell;
    BOOL            m_isRefrash;
    NSMutableDictionary       *m_urlDic;
}

@property(nonatomic,retain) Contact        *contact;
@property(nonatomic,retain) NSMutableArray *myFeedsData;
@property(nonatomic,retain) NSMutableArray *myCellArray;
@property(nonatomic,retain) NSMutableArray *linkedTFArray;
@property(nonatomic,retain) NSMutableArray *snsTypeArrary;
@property(nonatomic,retain) BaseFriend     *TFFriend;
@property(nonatomic,retain) NSString       *m_curFeedID;

@end