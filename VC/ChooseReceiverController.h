//
//  ChooseReceiverController.h
//  Megafon
//
//  Created by Miaohz on 11-10-12.
//  Copyright 2011 广州市易杰数码科技有限公司. All rights reserved.
//
//  Management zhangss

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "NewDirectorMessageController.h"
#import "MixSearchMessageView.h"
#import "ChooseCell.h"

@class NewSNSViewController;
typedef enum
{
    OnlineSearchNone = 0,
    OnlineSearchFetching,
    OnlineSearchShowing,
    
    OnlineStateEnd
}OnlineSearchingState;

@interface ChooseReceiverController : BaseController<UITableViewDelegate,UITableViewDataSource,
MixSearchMessageDelegate,UITextFieldDelegate>
{
	UITableView    *fansTable;
	NSMutableArray *fansArray;
	NSMutableArray *searchArray;
	NewDirectorMessageController *_parent;
	
	BOOL           isSearching;
	UIButton       *searchBackView;
    BOOL           bNextPage;
    NSString       *_strMoreCell;
    
    //online searching
    OnlineSearchingState   onlineSearchState;
    NSString               *strSearchCell;
    NSString               *searchOnlineEntity;
    
    MixSearchMessageView *cabSearchBar;    
    UINavigationBar      *navBar;
    NewSNSViewController *_newSnsView;	
	NSInteger            m_friendType;
}
@property (nonatomic ,copy)   NSString *_strMoreCell;
@property (nonatomic, assign) NewSNSViewController *_newSnsView;//add by wangchao 2012/3/17
@property (nonatomic, retain) UITableView *fansTable;
@property (nonatomic, retain) NSMutableArray *fansArray;
@property (nonatomic, retain) NewDirectorMessageController *_parent;
@property (nonatomic, retain) UIButton* searchBackView;
@property (nonatomic ,retain) MixSearchMessageView *cabSearchBar;
@property (nonatomic, assign) BOOL bNextPage;
@property (nonatomic, retain) NSString *strSearchCell;
@property (nonatomic, retain) NSString *searchOnlineEntity;

- (id)initWithFriendType:(NSInteger)type;

@end
