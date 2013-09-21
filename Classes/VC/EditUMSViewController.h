//
//  EditUMSViewController.h
//  Megafon
//
//  Created by lifuzhen on 12-4-11.
//  Copyright (c) 2012年 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "RCSAccount.h"
#import "PickerView.h"
#import "BaseController.h"
#import "DatePickerView.h"

@interface EditUMSViewController : BaseController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,
UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UIActionSheetDelegate,PickerViewDelegate,DatePickerViewDelegate>{
    
    UITableView *editTableView;
    RCSAccount *rcsAccount;
    
    UIImage *iconImage;
    NSString *displayName;
    NSNumber *sexNumber;
    NSString *signature;
    NSData *imageData;
    
    UIView *backView;
        
	UIImagePickerController *imgPickerController;
    
    BOOL isTableViewUp;
    
    DatePickerView *m_DatePickView;              //datepickview实例添加 zhengxiaohe 2012-09-14 add
    UIView         *m_SelectBirthdayView;        //生日pickview背景 zhengxiaohe 2012-09-14 add
    NSDate         *m_tmpBirthdayData;          //临时birthday数据存储 zhengxiaohe 2012-09-14 add
    NSString       *m_tmpPortrait;
    NSString       *m_tmpDisplayName;
    NSNumber       *m_tmpGender;
    NSString       *m_tmpSignature;
}
@property (nonatomic, copy) NSDate   *tmpBirthdayData; //临时birthday数据存储 zhengxiaohe 2012-09-14 add
@property (nonatomic, copy) NSString *tmpPortrait;
@property (nonatomic, copy) NSString *tmpDisplayName;
@property (nonatomic, retain) NSNumber *tmpGender;
@property (nonatomic, copy) NSString *tmpSignature;
@end
