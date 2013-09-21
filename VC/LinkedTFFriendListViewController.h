//
//  LinkedTFFriendListViewController.h
//  Megafon
//
//  Created by zhangss on 11-11-23.
//  Copyright 2011 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "Contact.h"
#import "RCSLinkTFManager.h"

typedef enum
{
	kViewNewContact     = 1, //从新建联系人界面
	kViewProfileContact = 2  //从联系人详情界面 
}FromViewType;

@protocol ContactLinkToFriendDelegate<NSObject>
@optional
- (void)addFriendToLink:(BaseFriend *)baseFriend;
@end

//实现这个委托方法获取选择融合的好友
@protocol selectFriendsToLinkDelegate<NSObject>
@optional
- (void)getSelectedFriendsToLink:(NSArray *)friends;
@end

@interface LinkedTFFriendListViewController : BaseController <UITableViewDelegate, UITableViewDataSource,
UIAlertViewDelegate, ContactLinkToFriendDelegate> {
	
	Contact          *contact;            //当前联系人
	
	UITableView      *tfFriendTable;
	NSMutableArray   *tfFriendArray;      //绑定的好友数组
	RCSLinkTFManager *rcsLinkTFManager;
	NSInteger        selectedRow;        //选中的好友
	
	id<selectFriendsToLinkDelegate> selectedFriendsDelegate;
	NSInteger        fromType;           //上级界面类型
}

@property (nonatomic,retain) Contact *contact;
@property (nonatomic,assign) id<selectFriendsToLinkDelegate> selectedFriendsDelegate;
@property (nonatomic,assign) NSInteger fromType;

@end
