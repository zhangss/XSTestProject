//
//  ContactsDetailViewController.h
//  Megafon
//  联系人详情展示界面；不更改联系人数据信息；数据从COREDATA获取
//
//  Created by gzw on 12-4-3.
//  Copyright 2012 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Contact.h"
#import "ContactManager.h"
#import "RCSLinkTFManager.h"
#import "CABCustomCell.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface ContactsDetailViewController : BaseController 
<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIAlertViewDelegate,
ABNewPersonViewControllerDelegate,UINavigationControllerDelegate>
{
	Contact          *contact;
	ContactManager   *contactManager;
	RCSLinkTFManager *rcsLinkTFManager;
    UITableView      *detailTableView;  //整个界面（除最上面包含导航条的那一栏）
	UIView           *headerView;          
	NSData           *headImageData;    //头像数据
	NSMutableDictionary *tableDataSource;   //tableV的数据源 //普通状态下的
	NSInteger           tfFriendCount;      //已经绑定的第三方好友的个数
	UIButton         *inviteToUMSButton;
	UIButton         *favouriteButton;
	UIButton         *sendMessageButton;
	UIButton         *seeNewsFeedButton;
	UIButton         *setDefaultAvatarButton;
    UIButton         *shareContactButton;
	UIAlertView      *deleteAlert;
    UIAlertView      *deleteAlert2;
	UIView           *footerView;       //编辑状态下 删除联系人
	NSMutableArray   *numActionSheetData;   //用来动态填充actionsheet的button项
	NSMutableArray   *mixActionSheetData;   //用来动态填充actionsheet的button项
	NSMutableArray   *mixDataSource;        //用作MIX actionsheet响应点击的数据来源
	ABRecordRef		 personRecord;
    BOOL             bIsFromMixConversation;//是否来自于mixconversation
}
@property(nonatomic,retain) Contact *contact;
@property (nonatomic)BOOL bIsFromMixConversation;
- (void)initContact:(Contact *)contactIn;
@end
