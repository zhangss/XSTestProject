//
//  CABMainViewController.h
//  Megafon
//
//  Created by li yipeng on 12-4-6.
//  Copyright (c) 2012年 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "CustomSearchBarView.h"
#import "FavoritesSectionHeaderView.h"
#import "CABMainCell.h"
#import "TypeDef.h"
#import "ContactInfoForMix.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "MBProgressHUD.h"
#import "ThirdPartyFriendProfileViewController.h"
#import <CoreData/CoreData.h>

#import "CABSortedData.h"

@class SortedIndexDictionaryWrapper;
@class Contact;

@protocol CABListSelectDelegate
@optional
- (void)didSelectReceive:(id)reveive andToAccount:(NSString*)account;
- (void)didAddEmailOrPhone:(NSString*)aString toContact:(Contact*)aContact;
- (void)didSelectContact:(Contact*)aContact;
- (void)didSelectOnePhone:(NSString *)aPhone;
@end
@interface CABMainViewController : BaseController
<UITableViewDelegate, 
UITableViewDataSource,
ABNewPersonViewControllerDelegate,
CustomSearchBarDelegate,
UITextFieldDelegate,
SectionHeaderViewDelegate, 
ContactInfoDelegate,
MBProgressHUDDelegate,
UIScrollViewDelegate,
UIActionSheetDelegate,
CABDisplayNameChangeDelegate,
CABSortedDataDelegate,
NSFetchedResultsControllerDelegate>
{
    UITableView     *contactsTableView;
   
    BOOL            isFavotiesExpand;
    BOOL            isSearching;
    BOOL            isUsedSearchData;
	BOOL			isUpdatingCnts;
    
    BOOL             needFavSection;
    
    CABSortedData * m_mainFavorites;//favorites联系人
    
    CABSortedData * m_mainSortData;
    
    CABSortedData * m_searchSortData;
    
    int searchID;
    CustomSearchBarView *searchBarView;
    UIButton            *searchBackView;
    CABContactListType  contactListType;
    ThirdFriendType     trdFriendType;      //用来过滤掉已经关联了该类型的好友的联系人,
                                            //CABContactListType==kCABContactListTypeLink
                                            //时，该字段必须赋值
    UIViewController<CABListSelectDelegate>       *selectDelegate;

    NSString            *aNewEmailOrPhone;
    BOOL                hasShowFavoriteTip;  //是否已经显示过favorite气泡提示
	UIButton				 *syncAllIMAndSNSBtn;
	UIActivityIndicatorView  *syncAllLoadingicon;
    
	MBProgressHUD        *updatingCntsHUD;
    
    NSMutableArray * fetchArray;
    NSMutableArray * allObjects;
    NSMutableArray * cacheObjects;
    NSMutableArray * changeCacheObject;

    BOOL isNeedReloadTable;
    BOOL isVisible;
    
    UIImageView * addressbookLabel;
    
    //BOOL isLoad;
    
    BOOL isShowAddressbookAlert;
    
}
@property (nonatomic, retain) UITableView *contactsTableView;

@property CABContactListType    contactListType;
@property ThirdFriendType       trdFriendType;
@property (nonatomic, assign) UIViewController<CABListSelectDelegate> *selectDelegate;
@property (nonatomic, copy) NSString *aNewEmailOrPhone;
- (id)initWithCABContactListType:(CABContactListType)aType;
@end
