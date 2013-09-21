//
//  NewChatViewCtl.h
//  Megafon
//
//  Created by  sunliang on 12-2-13.
//  Copyright 2012 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "HPGrowingTextView.h"
#import "IMandSMSCheck.h"
#import "AddReceiverContactView.h"
#import "SendOnTimeViewCtl.h"
#import "MixSendLocation.h"
#import "VCardView.h"
#import "vCard.h"
#import "MixSendView.h"
#import "RosyWriterVideoProcessor.h"


#define LimitSMSOrMMS 280
@class MessageCell;
@class SessionMessage;
@class RCSAccount;
@class RosyWriterVideoProcessor;
@interface NewChatViewCtl : BaseController
<UITableViewDelegate,
UITableViewDataSource, 
UITextFieldDelegate,
UIActionSheetDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
IMandSMSCheckDelegate,
SelectContactPhoneCtlDelegate,
CABListSelectDelegate,
SendOnTimeViewDelegate,
ShareLocationDelegate,
MixSendViewDelegate,
RosyWriterVideoProcessorDelegate>
{
	//上方 发送人选择视图
	AddReceiverContactView *AddReceiverView;
	NSArray *sendContactForMemoryWarning;
	//输入框内模糊匹配的联系人列表
	NSArray *allContacts;
    NSArray *searchResults;
	UITableView  *_tableView;
	
    //下方 发送视图
    MixSendView *m_sendView;
	NSString *shareLocationURL;//保存ShareLocation路径
    
//    NSString * vcardPath;
//    NSString * name;
//    NSString *headViewPath;
//    NSString *sendVideoPath;
    Contact *Vcardcontact;
	
	//定时发送时的视图
	UIButton *bgBtn;						//定时发送时的灰色背景
	SendOnTimeViewCtl *clockView;				//选择时间的视图
	NSDate *sendDate;							//保存定时发送的时间
	
//	NSString *outInputString;
//	NSString *outInputFilePath;
	BOOL isSendShareLocation;
	NSString *shareLocationMsgBody;//转发位置分享，将位置分享的经纬度及描述信息保存在该字符串中。
	
	UIImagePickerController *imagePickerController;
    
    BOOL isFirstLoad;

    RosyWriterVideoProcessor *videoProcessor;
    
    CGSize keyBoardSize;

    BOOL isTextSendBySMS;    //文本消息是否当做短信发送
    
}

@property (nonatomic ,assign) BOOL isBackBtnClicked;
//@property (nonatomic) BOOL bIsForwardMessage;
//@property (nonatomic, copy)	NSString *outInputString;
//@property (nonatomic, copy) NSString *outInputFilePath;
@property (nonatomic ,retain) NSArray *searchResults;
@property (nonatomic, retain) NSArray *allContacts;
@property (nonatomic, retain) NSDate *sendDate;
@property (nonatomic ,retain) NSArray *sendContactForMemoryWarning;
//@property (nonatomic) BOOL isSendShareLocation;
//@property (nonatomic, copy) NSString *shareLocationMsgBody;
@property (nonatomic ,retain) UIImagePickerController *imagePickerController;
// 上一层界面的navgationControllerPre
@property (nonatomic, assign) UINavigationController *navgationControllerPre;

//@property (nonatomic, copy)NSString * vcardPath;
//@property (nonatomic ,retain) NSString * name;
//@property (nonatomic ,retain) NSString *headViewPath;
//@property (nonatomic ,retain) NSString *sendVideoPath;

@property (nonatomic ,retain) Contact *Vcardcontact;

@property (nonatomic ,retain) SessionMessage * forwardMessage;

- (void)initAddReceiverView;
- (void)initSendOperatorView;
- (void)initTitleView;
- (void)camera;
//视频录制
- (void)cameraForVideo;
- (void)libraryPhoto;
- (CGSize)makeSizeWithImage:(UIImage *)theImage;

- (BOOL)isFormatNumber:(NSString *)str;

- (SessionModel *)getSessionModelForSendMsg;
- (void)pushToNextViewCtlAfterSendMsg:(SessionModel *)sm;
- (void)addKeyBoardNotification;

- (void)refreshViewWithoutInputFilePath;

- (void)clockBtnPressed;
- (void)sendLocation;
- (void)updateTheme:(id)notification;
- (void)sendVcard;

- (void)switchBtnPressed;


- (BOOL)checkMyServerIsLoginOn:(NSNumber *)aServer;//added by sunliang for 检测第三方是否在线
@end
