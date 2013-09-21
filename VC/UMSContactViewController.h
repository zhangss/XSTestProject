//
//  UMSContactViewController.h
//  Megafon
//
//  Created by 肖 夕东 on 13-3-7.
//  Copyright (c) 2013年 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactMessageCell.h"
#import "SessionModel.h"
#import "UMSPhone.h"
#import <AddressBookUI/AddressBookUI.h>
#import "BaseController.h"

@interface UMSContactViewController : BaseController<ContactMessageCellDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,ABNewPersonViewControllerDelegate>
{
    UITableView         *m_tabView;
    NSMutableArray      *m_UMSContactsArr;
    SessionModel        *m_currentUMSModel;
    UMSPhone            *m_currentPhone;

    NSMutableArray             *m_unReadArr;

}

- (id)initWithSessionModel:(SessionModel *)sModel;

- (void)showContactOrFriendOrStrangerDetail:(UMSPhone *)phone;

- (void)hiddenUMSModelAfter;


@end
