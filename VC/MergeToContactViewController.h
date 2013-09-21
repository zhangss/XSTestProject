//
//  MergeToContactViewController.h
//  Megafon
//
//  Created by gzw on 12-6-7.
//  Copyright 2012 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"
#import "ContactManager.h"
#import "CABMainViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@class BaseFriend;

@interface MergeToContactViewController : BaseController 
<UITableViewDelegate,
UITableViewDataSource,
CABListSelectDelegate,
ABNewPersonViewControllerDelegate>
{
	BaseFriend  *aFriend;               //接受上级传递的 好友
	ContactManager   *contactManager;
    UITableView      *mergeTableView;  //整个界面（除最上面包含导航条的那一栏）	
	UIView           *headerView;
    NSString *      luid;
}
@property(nonatomic,retain) BaseFriend *aFriend;
- (void)initFriend:(BaseFriend *)friendIn;
@end
