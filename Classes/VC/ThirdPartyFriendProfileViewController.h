//
//  ThirdPartyFriendProfileViewController.h
//  Megafon
//
//  Created by zhangss on 11-10-27.
//  Copyright 2011 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "Contact.h"
#import "MBProgressHUD.h"
#import "AsyImageView.h"

#define IM_LOG_MODULE          @"-=IM=-"
#define IM_LOG_FUNC_ENTER      @"-METHOD ENTER-"
#define IM_LOG_FUNC_EXIT       @"-METHOD EXIT-"
#define IM_LOG_ERROR           @"-ERROR-"

@class BaseFriend;

@protocol ThirdFriendLinkToContactDelegate
@optional
- (void)thirdLinkToContact:(Contact *)contact;
@end

@protocol CABDisplayNameChangeDelegate<NSObject>
@optional
- (void)displayNameChangeOnCabMainView;
@end

@interface ThirdPartyFriendProfileViewController : BaseController
<UITableViewDelegate,
UITableViewDataSource,
MBProgressHUDDelegate,
UIAlertViewDelegate, 
ThirdFriendLinkToContactDelegate> 
{
	NSInteger   thirdPartyType;         /*区别第三方好友类型*/ //SNS:FB,TW,VK,OD:10,11,12,13 IM:GT,VK,OD:2,4,5
	BaseFriend  *TFFriend;              //0:简介界面传入的第三方好友 1:从融合界面 传入要被融合的好友
	NSInteger   fromType;               //!!从LinkFriend界面获取 0:默认从group查询简介进入 显示删除button 
	                                    //1:从融合连接界面进入 显示融合接触融合button
	AsyImageView *headImageView;      //头像
	UILabel     *lbName;                //名称
	UIImageView *imgVStatues;           //状态
	BOOL         isShowLinkCell;        //是否显示选择融合联系人cell
	BOOL		 bAddtoFavoriteOrNot;	//是否收藏好友
	MBProgressHUD * S_MBProgreeHuD;
	NSTimer *bindTimer;
	UITableView *tableView;
	NSMutableArray *allKeys;
	NSMutableArray *allValues;
	UIButton *AddtoFavoriteButton;
	UIView *headView;
	UIAlertView  *tfAlertView;
	BOOL flag;
    id <CABDisplayNameChangeDelegate>displayNameChangedelegate;//代理指针  zhengxiaohe 2012-12-12 add
    BOOL  bAlertDleteFriend;
}
- (void)SendMessageButtonClicked:(id)sender;
- (void)SeeNewsFeedButtonClicked:(id)sender;
- (void)AddtoFavoriteButtonClicked:(id)sender; 

@property (nonatomic,retain) BaseFriend *TFFriend;
@property (nonatomic,assign) NSInteger  thirdPartyType;
@property (nonatomic,assign) NSInteger  fromType;
@property (nonatomic,retain) Contact    *curContact;
@property (nonatomic,retain) UIButton *AddtofavoriteButton;
@property (nonatomic,assign) BOOL       bAddtoFavoriteOrNot;
@property (nonatomic,assign) id <CABDisplayNameChangeDelegate>displayNameChangedelegate;//代理指针  zhengxiaohe 2012-12-12 add

//判断两个好友是否是同一个好友
- (BOOL)baseFriend:(BaseFriend *)friendOne isTheSameFriendWith:(BaseFriend *)friendTwo;
- (void)refreshProfileData;
- (void)requestDetailData;
- (void)getThirdParityFriendProfile;
- (void)displayNameChange;
@end
