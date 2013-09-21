//
//  ConnectionServerViewController.h
//  Megafon
//  manage by  zhengxiaohe on 11-10-31
//  Created by Miaohz on 11-10-1.
//  Copyright 2011 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "MBProgressHUD.h"
#import "ReturnCodeModel.h"
#import "PickerView.h"
#import "DatePickerView.h"
#import "ImProfileHeadView.h"

@class CustomStatusCell;
@class RCSAccount;
@class ThirdAccountInfo;
@interface ConnectionServerViewController : BaseController<UITableViewDelegate,
UITableViewDataSource,UITextFieldDelegate,UIAlertViewDelegate,MBProgressHUDDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,PickerViewDelegate,DatePickerViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,ChageImageBtnDelegate> {
	UITableView *ServerTable;
	NSString *serverTitle;
	UILabel *accountLabel;
	UISwitch *swConnect;
	BOOL swCnState;  //点击swConnect之前它的value
	UISwitch *swAutoLogin;
	RCSAccount *currentAccount;
	MBProgressHUD * S_MBProgreeHuD;
	ReturnCodeModel	*returnCodeModel;
	NSTimer *loginTimer;
    NSTimer *publishProfileTime;
	
	NSInteger imType;    // type名字有歧义修改  0 gtalk, 4 vk, 5 od, 6 multifon, 7 marilru zhengxiaohe
	BOOL   saveloginfailedBool;
	UIAlertView  *alertview;
	UIButton *deleteButton;
	CustomStatusCell *stateCell;
	UIButton      *changeImageButton;    //换头像button
	UILabel       *changeImageLabel;     //标签
	UIImageView   *imgVStatues;         //状态 暂留
    UILabel       *lbStatus;
	NSString      *portraitStr;
	NSNumber      *tempStatus;  
	BOOL          isEdit;
	UILabel       *nickNameLabel;
	UITextField   *moodFiled;
	ThirdAccountInfo *tdIMAccount;    //保存第三方帐号
    UIImageView *thirdPartyIcon ;
    UIImagePickerController *imgPickerController;
    NSMutableArray *imProfileInfoArray;
    NSMutableArray *imProfileTitleNameArray;
    BOOL isIcqCellEdit;
    BOOL  isCheckPick; //是否弹出国家选择器 
    NSDate         *birthdayDate;
    UITextField    *icqFriendlyNameField;
    UITextField    *icqFirstNameField;
    UITextField    *icqLastNameField;
    UITextField    *icqAboutMeField;
    UITextField    *icqCountryField;
    UITextField    *icqStateField;
    UITextField    *icqWebSiteField;
    UITextField    *icqBirthdayField;
    UITextField    *icqCityField;
    UILabel        *icqGenderNamelabel;
    NSNumber       *genderNumber;
    UIView         *backView;
    NSMutableArray *editableKeys;
	NSMutableArray *editableValues;
    NSMutableArray *editablesection1Keys;
	NSMutableArray *editablesection1Values;
    NSMutableArray *editablesection2Keys;
	NSMutableArray *editablesection2Values;
    NSMutableArray *imProfile1tableKeys;
	NSMutableArray *imProfile1tableValues;
    NSMutableArray *imProfile2tableKeys;
	NSMutableArray *imProfile2tableValues;
    NSMutableArray *imProfile3tableKeys;
	NSMutableArray *imProfile3tableValues;
    DatePickerView *datePickView;
    NSString       *m_StartCountryStr;//国家pickview选择项
    NSString       *m_CoreDateCountryStr;//上传服务器国家参数
    UIView         *m_SelectView;        //国家pickview背景
    UIPickerView   *m_CountryPickView;   //国家选择器
    NSString       *m_LastLanguage;     //系统语言环境
    NSMutableDictionary *m_CountryList;      //国家列表字典
    UIView         *m_SelectBirthdayView;        //生日pickview背景
    UIActivityIndicatorView  *m_SwitchConnectorToServer;//开关调用服务器风火轮添加
    ImProfileHeadView *m_ImProfileHeadView;
    BOOL            bAlertUnbind;
}
@property (nonatomic, retain) NSString *serverTitle;
@property (nonatomic, retain) UITableView *ServerTable;
@property (nonatomic, assign) NSInteger imType;//名称有歧义修改
@property (assign) BOOL   saveloginfailedBool;
//profile
@property (nonatomic,retain) UISwitch         *swConnect;
@property (nonatomic,retain) NSMutableArray   *imProfileInfoArray;
@property (nonatomic,retain) NSMutableArray  *imProfileTitleNameArray;
@property (nonatomic,retain) ThirdAccountInfo *tdIMAccount; 
@property (nonatomic,retain) NSMutableArray  *editableKeys;
@property (nonatomic,retain) NSMutableArray  *editableValues;
@property (nonatomic,retain) NSMutableArray  *editablesection1Keys;
@property (nonatomic,retain) NSMutableArray  *editablesection1Values;
@property (nonatomic,retain) NSMutableArray  *editablesection2Keys;
@property (nonatomic,retain) NSMutableArray  *editablesection2Values;

@property (nonatomic,retain) NSMutableArray  *imProfile1tableKeys;
@property (nonatomic,retain) NSMutableArray  *imProfile1tableValues;
@property (nonatomic,retain) NSMutableArray  *imProfile2tableKeys;
@property (nonatomic,retain) NSMutableArray  *imProfile2tableValues;
@property (nonatomic,retain) NSMutableArray  *imProfile3tableKeys;
@property (nonatomic,retain) NSMutableArray  *imProfile3tableValues;
@property (nonatomic,copy)   NSDate          *birthdayDate;

@property (nonatomic,retain) UITextField     *icqAboutMeField;
@property (nonatomic,retain) UITextField     *icqCountryField;
@property (nonatomic,retain) UITextField     *icqStateField;
@property (nonatomic,retain) UITextField     *icqCityField;
@property (nonatomic,retain) UITextField     *icqWebSiteField;
@property (nonatomic,retain) UITextField     *icqFriendlyNameField;
@property (nonatomic,retain) UITextField     *icqFirstNameField;
@property (nonatomic,retain) UITextField     *icqLastNameField;

@property (nonatomic,retain) UIPickerView   *countryPickView;
@property (nonatomic, copy)  NSString       *startCountryStr;
@property (nonatomic, copy)  NSString       *coreDateCountryStr;
@property (nonatomic, copy)  NSString       *lastLanguage;
@property (nonatomic,retain) NSMutableDictionary *countryList;
@property (nonatomic, retain)  UIActivityIndicatorView  *switchConnectorToServer;//开关调用服务器风火轮属性添加
- (id)initImType:(NSInteger)imType;//函数命名有歧义
- (void)initHeadView;
- (void)initPickerView;
- (void)keyboardNotificaton;
- (void)selectImageFromLibrary;
- (void)selectImageFromCamera;
- (void)initThidIconImage;
- (void)referashMyInfoCell;
- (void)refreshDataSource;
- (void)getDownOptionCountry:(NSInteger)row;//pickview上选择的国家
- (void)setLonginSwitch;//控制开关函数
@end
