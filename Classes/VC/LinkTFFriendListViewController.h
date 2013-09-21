//
//  LinkTFFriendListViewController.h
//  Megafon
//
//  Created by zhangss on 11-11-24.
//  Copyright 2011 广州市易杰数码科技有限公司. All rights reserved.
//

///////////////////////////////////////
/////////////融合好友的列表//////////////
//////////////////////////////////////

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "Contact.h"
#import "BaseFriend.h"
#import "LinkedTFFriendListViewController.h"
#import "MixSearchMessageView.h"

@interface LinkTFFriendListViewController : BaseController <UITableViewDelegate,UITableViewDataSource,MixSearchMessageDelegate,UITextFieldDelegate> {
	                                  //需要和传入的参数
	NSString     *titleString;        //Title
	Contact      *curContact;         
	NSInteger    thirdPartyType;      //第三方好友类型 //SNS:FB,TW,VK,OD:10,11,12,13 IM:GT,VK,OD:2,4,5
	
	NSArray      *tfFrinedList;        //联系人列表
	BaseFriend   *linkedTF;            //已经融合的好友
	BaseFriend   *TFFriend;            //选择的好友
	
	UITableView  *friendTableView;
	NSIndexPath  *lastIndexPath;       //选中的行
	BOOL         isSelected;
	
	NSInteger    fromType;             //
	id<ContactLinkToFriendDelegate> conLinkFriendDelegate;
    //***BEGIN*** [添加了搜索框，纪录搜索到的好友信息] 肖夕东 2012/10/27 add
    NSMutableArray      *filterFriendList;      //搜索过滤好友列表
    MixSearchMessageView *mySearchBar;          //搜索框
    BOOL        isSearching;                    //搜索标记
    UIButton    *searchBackView;                //点击空白处取消搜索按钮
    //***END*** [添加了搜索框，纪录搜索到的好友信息] 肖夕东 2012/10/27 add
}

@property (nonatomic,retain) NSString *titleString;
@property (nonatomic,retain) NSIndexPath *lastIndexPath;
@property (nonatomic,assign) NSInteger fromType;

//***BEGIN*** 代理属性使用规范 wangxuefeng 2012/10/29 modify
@property (nonatomic,assign) id<ContactLinkToFriendDelegate> conLinkFriendDelegate;
//***END*** 代理属性使用规范 wangxuefeng 2012/10/29 modify

//***BEGIN*** [Bug-memory leaks] zhouhui 20120830 add
@property (nonatomic,retain) NSArray      *tfFrinedList; 
//****END**** [Bug-memory leaks] zhouhui 20120830 add

- (void)initContact:(Contact *)contact andThirdPartyType:(NSInteger)type;
- (BOOL)baseFriend:(BaseFriend *)friendOne isTheSameFriendWith:(BaseFriend *)friendTwo;
- (void)LinktoThirdFriend;
//***BEGIN*** [根据key搜索好友信息] 肖夕东 2012/10/27 add
- (void)searchFriendModels:(NSString *)key;
//***END*** [根据key搜索好友信息] 肖夕东 2012/10/27 add
//***BEGIN*** [清空搜索框] 肖夕东 2012/10/27 add
- (void)hideSearchView;
//***END*** [清空搜索框] 肖夕东 2012/10/27 add

- (void)addNotification;  //[曾加键盘通知] add by zhangss 2012-10-29

@end
