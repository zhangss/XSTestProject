//
//  PersonalPrivacyViewController.h
//  Megafon
//
//  Created by 张永亮 on 13-3-25.
//  Copyright 2013 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "RCSAccount.h"

typedef enum
{
    addressBookStatus = 1000,
    googleAnalytics,
    readReceiptStatus,
    isTypingStatus,
    registrationNotificationStatus
}PPStatus;

@interface PersonalPrivacyViewController : BaseController<UITableViewDelegate,UITableViewDataSource> {
    UITableView          *ppTableView;
    NSMutableDictionary  *ppDictionary;
    NSMutableDictionary  *ppDetailDictionary;
    RCSAccount           *rcsAccount;
}

@end
