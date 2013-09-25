//
//  ContactDetailforContactRefViewController.h
//  Megafon
//
//  Created by 张 全 on 13-3-10.
//  Copyright (c) 2013年 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "BusinessManager.h"
#import "CABMainViewController.h"

//用于Section排序
#define kPhoneSection    @"aPhoneSection"
#define kEmailSection    @"bEmailSection"
#define kHomepageSection @"cHomepageSection"
#define kAddressSection  @"dAddressSection"
#define kBirthdaySection @"eBirthdaySection"
#define kNotesSection    @"fNotesSectio"

@interface ContactDetailforContactRefViewController : BaseController<UITableViewDelegate,
UITableViewDataSource,
ABNewPersonViewControllerDelegate,
CABListSelectDelegate>
{
    ABRecordRef		    m_contactRef;
    NSString            *m_vCardPath;
    NSMutableDictionary *m_tableDataSource;   //tableV的数据源
    UIView              *m_headerView;
    UITableView         *m_profileTableView;
    UIView              *m_footerView;
    NSString            *oldContactLuid;
}

@property (nonatomic,readwrite) ABRecordRef           contactRef;//重写了set方法 by wangxuefeng
@property (nonatomic,retain) NSString                 *vCardPath;
@property (nonatomic,retain) NSMutableDictionary      *tableDataSource;
@property (nonatomic,retain) UIView                   *headerView;
@property (nonatomic,retain) UITableView              *profileTableView;
@property (nonatomic,retain) UIView                   *footerView;
@property (nonatomic,retain) NSString                 *oldContactLuid;

@end
