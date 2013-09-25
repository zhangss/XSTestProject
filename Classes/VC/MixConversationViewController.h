//
//  
//  RCS
//
//  Created by sunliang on 11-7-7.
//  Copyright 2011 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "Constants.h"
#import "MBProgressHUD.h"

#import "MessageCell.h"
#import "BaseFriend.h"
#import "OneBoxDefine.h"
#import "ContactManager.h"
#import "CABMainViewController.h"

//定时发送
#import "SendOnTimeViewCtl.h"
#import "TypeDef.h"
#import "IMandSMScheck.h"

#import "MixSendLocation.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "BlackList.h"
#import "BlackListAccessor.h"
#import "EGORefreshTableHeaderView.h"
#import "MixSendView.h"
#import "VCardView.h"
#import "RosyWriterVideoProcessor.h"

@class SessionModel;
@class RosyWriterVideoProcessor;
#define Tag_ForJustSMSOrMMS 9991
#define Tag_ForCallPhoneNumber_more 9997
#define Tag_ForCheckButtonCall 9998
#define Tag_ForSelectNumberForCloud 9999
#define Tag_ForContactDelete 10000
#define Tag_ForAddStrangerNumber 10001
#define Tag_ForAddBlackList 10002
#define Tag_ForAddBlackListTip 10003
#define Tag_ForDeleteMultiAttachmentMsg 10004
#define Tag_ForNOMoneyTip 10005
#define kMixActBlackList   2005


typedef enum{
    kContactType_Default = -1,  // 默认类型
    kContactType_Stranger = 0,  // 陌生人
    kContactType_Third,         // 第三方
    kContactType_Contacter,     // 有号码的联系人
    kContactType_Contacter_0,   // 无号码的联系人
}ContactType;



@interface PhoneNumber : NSObject {
}
@property (nonatomic, copy)NSString *number;    // 电话号码
@property (nonatomic, copy)NSString *name;      // 家庭的号码、移动号码。。。。
@property (nonatomic, assign)BOOL isSelected;   // 该号码是否被选中
@property (nonatomic ,assign) BOOL isNumberBlack;//标识号码是否已经被拉黑
- (id)initWithNumber:(NSString *)_number _name:(NSString *)_name;

@end


@interface HeadLoadView : UIView
{
	UIActivityIndicatorView *activityView;
	id _parent;
    UIButton *buttonCall;
    UIButton *buttonContact;
    UIActivityIndicatorView *blackActivity;
    UIButton *m_buttonBlackList;//拉黑按钮
    UIButton *buttonHistory;
}

@property (nonatomic, retain) UIButton *buttonCall;
@property (nonatomic, retain) UIButton *buttonContact;
@property (nonatomic, retain) UIButton *m_buttonBlackList;
@property (nonatomic, assign) CGRect frameOfHeadView;   //有按钮时headview的frame
@property (nonatomic, retain) UIButton *buttonHistory;


- (id)initWithFrame:(CGRect)frame andParent:(id)theParent;

- (void)refreshViewWhileBlackOneNumber;
- (void)refreshViewWithContactType:(ContactType)_type;

- (void)call:(id)sender;
- (void)contact:(id)sender;
- (void)btnSetBlackList:(id)sender;
- (void)changeButtonStatus:(BOOL)isHidden; // 是否显示button，当有历史数据可以加载的时候隐藏
@end

@interface MixConversationViewController : BaseController
<UITableViewDelegate,
UITableViewDataSource,
UIActionSheetDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
SendOnTimeViewDelegate,
UIScrollViewDelegate,
IMandSMSCheckDelegate,
MessageCellDelegate,
ShareLocationDelegate,
ABNewPersonViewControllerDelegate,
EGORefreshTableHeaderDelegate,
CABListSelectDelegate,
MixSendViewDelegate,
RosyWriterVideoProcessorDelegate,
UIDocumentInteractionControllerDelegate>
{
    
    
    UIView * hview;
    UIView * vview;
    NSUInteger CurrentOrientation;
    UITableView* _tableView;
    HeadLoadView *_headView;
	
	//编辑状态下 下面的视图
	UIImageView *buttonBgView;
    UIButton* deleteButton_;
    UIButton* forwardButton_;
	UIImageView *deleteMaskView;
	UIImageView *forwardMaskView;
    
    MixSendView * m_sendView;
    
	UIButton *hideKeyboardBtn;					//当键盘弹起时为了收起键盘 增加的一个隐藏按键
	EGORefreshTableHeaderView *m_refreshHeaderView; //刷新
	
	//定时发送时的视图
	UIButton *bgBtn;							//定时发送时的灰色背景
	SendOnTimeViewCtl *clockView;				//选择时间的视图
	NSDate *sendDate;							//保存定时发送的时间
	
	MessageCell *calCellH;						//为了计算CELL的高度
	
	NSMutableArray *showMsgs;					//标识当前显示的每一个CELL的消息  可能有重复(MMS)
	NSMutableArray *selectIndexs;				//保存处于编辑状态下选择的CELL
	
    
    CGSize keyBoardSize;						//保存键盘大小 适应IOS 5.0
	SessionModel *_sessionModel;				//当前会话Model
	NSString *_sendAccount;						//保存接收者的帐号
    
	UIImage *chatObjectHeadImage;				//当前聊天对象的头像
	UIImage *mySelfHeadImage;					//自己的头像
    
	NSString *outInputString;					//外部传入的文本
	NSString *outInputFilePath;					//外部传入的图片路径
	NSString *outInputReveiver;					//外部传入的接收者
	
	BOOL isClickBackBtn;						//是否点击了BACK按钮
	BOOL isLoadingSessionMessage;               //是否正在拉取消息
    BOOL isEdit_;								//标识是否处于编辑状态
    BOOL isPopPreviousVC;                       //是否跳转前一个页面
    BOOL isUMSSuper;
    BOOL bIsShowCloudMessage;                   //是否在展示云端消息
	
	CurrentServer curServer;					//标识当前的服务状态
	
	// add by gengjf 2012-04-09
    ContactType contactType;					//为了调整最顶部的三个按钮,可能有变化
    NSMutableArray *arrayPhoneNumber;			// 联系人的电话号码
    IMandSMSCheck *senderAccountChooseView;
    UIImagePickerController *imagePickerController; // 调用的相册、摄像头
	CGRect rectOfTitleView;
	
	BOOL isAddStrangerAlertShow;
	
	BOOL currentChatContactDeleted;
	BOOL m_bIsLoadingData;       //是否拉取云端数据
    BOOL isTextSendBySMS;    //文本消息是否当做短信发送
	NSMutableArray *m_tempCloudeMsgList;//临时存放云端消息

    //修改发送消息 风火轮动画2,4秒 
    NSMutableDictionary * m_animalSendingMsg;
       
    
    NSMutableDictionary * heightDic;
    NSMutableDictionary *tempMessageDic;
    BOOL                  isTypingSend;     // 是否已发送了istyping
    RosyWriterVideoProcessor *videoProcessor;


    UIImageView *backgroundView;
    
    //为聊天界面增加阴影
    UIImageView *bgshadow;
    UIView *tmpView;
    
    BOOL  isUMSFriend;      // 是否是UMS好友
    BOOL  isReused;
    BOOL  needReloadAllMessage;
    BOOL  bIsScrollToBottom;  //是否滚到底部
    NSUInteger m_currentPage;
    //MIX 播放视频 
    MPMoviePlayerViewController *moviePlayerViewController;
    
    NSMutableArray * AllMessageArr;

    UIAlertView *alertViewArrearageErrTip;
    BOOL isAlertShow;
    BOOL isVisible;    

}

@property (nonatomic ,assign) BOOL isAlertShow;
//@property (nonatomic, retain) NSMutableArray *multiAttachmentsMsgIDArray;
@property (nonatomic, copy) NSString *outInputString;
@property (nonatomic, copy) NSString *outInputFilePath;
@property (nonatomic, copy) NSString *outInputReveiver;
@property (nonatomic ,copy) UIImage *chatObjectHeadImage;				//当前聊天对象的头像
@property (nonatomic ,copy) UIImage *mySelfHeadImage;					//自己的头像
@property (nonatomic, retain) NSDate *sendDate;
@property (nonatomic ,assign) CGRect rectOfTitleView;
@property (nonatomic, retain) UIImagePickerController *imagePickerController;
@property (nonatomic, assign) BOOL isPopPreviousVC;
@property (nonatomic, assign) BOOL isUMSSuper;
@property (nonatomic, assign,getter = currentSessionModel)SessionModel *_sessionModel;

@property (nonatomic ,retain) NSMutableArray *arrayPhoneNumber;
@property (nonatomic,retain) NSString   *dynamic;
@property (nonatomic,assign) BOOL  isReused;
@property (nonatomic,assign) BOOL  needReloadAllMessage;
@property (nonatomic,assign) BOOL  bIsScrollToBottom;
@property (nonatomic,assign) BOOL  bIsShowCloudMessage;
@property (nonatomic,retain) UIView * hview;
@property (nonatomic,retain) UIView * vview;

+(id)getMixConverSationVC:(SessionModel *)model; //
- (id)initWithSessionModel:(SessionModel *)aModel;
- (void)initTitleView;
- (void)initSendOperatorView;
- (void)initLeftRightButtonView;
- (void)initDeleteOrForwardView;
- (void)initSenderAccountChooseView;
- (void)sendLocation;
- (void)errorInput:(NSString *)msg;

- (UIImage*)getMyThirdHeadImage;
- (void)createCurrentServer;
- (void)SMSOrMMSServer;
- (void)VKServer;
- (void)ODServer;
- (void)ICQServer;
- (void)GTalkServer;
- (void)FBServer;
- (void)MrimServer;
- (void)randomServer;
- (NSString *)thirdFriendJIDByType:(ThirdFriendType)friendType;

- (UITableView *)curTableView;
- (void)backButtonClicked;
- (void)editButtonClicked;
- (void)selectOneCell:(NSIndexPath *)index;
- (void)refreshCheckCount:(NSInteger)allSelectNum;
- (void) updateMIXUnReadCountNotification;
- (void)camera;
//视频
- (void)cameraForVideo;
- (void)libraryPhoto;
- (void)sendLocation;
- (void)refreshSendViewWithType:(MsgBodyType)type filePath:(NSString*)filePath;
- (CGSize)makeSizeWithImage:(UIImage *)theImage;

- (void)insertOneCellAfterSendMsg:(SessionMessage *)msg;

- (void)insertOneCellAfterReceiveMsg:(SessionMessage *)msg;

- (void)addNotificationForModel;

- (void)clockBtnPressed;
- (void)switchBtnPressed;
- (void)sendVcard;
- (BOOL)addPictureOrVideo;

- (void)scrollToBottomCell:(BOOL)isNeedScroll;

- (void)initChatObjectHeadImage;
- (void)initMySelfHeadImage;
- (void)showContactOrFriendOrStrangerDetail;
- (void)refreshTableHeadView:(BOOL)hasNext;
- (void)loadLocalHistoryMessage:(BOOL)isneedScroll;

//失败消息重发
- (void)retryToSendMsg:(SessionMessage *)message;


//向输入框填充文本信息
- (void)refreshViewWithOutInputString;
//向输入框填充图片
- (void)refreshViewWithoutInputFilePath;

- (NSArray *)contactLinkedIMFriends:(NSArray *)friendArray;

-(void)contactDeleteOnMain;

//删除服务器发件箱消息，本地数据库要做的处理
//-(void)deleteMsgDealDatabase:(NSArray*)msgArr;
//创建刷新的头view
- (void)createHeadRefreshView;
//开始加载
- (void)startLoadingUp;
//请求云端消息
-(void)requestCloudMessageData;

//***begin [取出第三方账号类型]zhengxiaohe 2012-12-10 add
- (NSUInteger)imTypeReplaceCurrServer:(CurrentServer)currSer;
//***end [取出第三方账号类型]zhengxiaohe 2012-12-10 add
- (void)dealDeleteAction;

//根据文件路径获取该文件的UTI
- (NSString *)UTIForURL:(NSURL *)url;
//提示没有app能够打开错误
- (void)showNoAppErr;


- (void)LoadAllView;
- (void)reloadDataSource;
- (void)loadDataSource;
-(void)loadMoreLocalMessageForDisplay;
@end



