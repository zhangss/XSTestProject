//
//  MultiChatViewCtl.h
//  Megafon
//
//  Created by  sunliang on 12-2-13.
//  Copyright 2012 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "IMandSMSCheck.h"
#import "AddReceiverContactView.h"
#import "MixConversationViewController.h"
#import "MessageCell.h"
#import "MixSendLocation.h"
#import "SendOnTimeViewCtl.h"
#import "MixSendView.h"
#import "ChatImageView.h"
#import "VCardView.h"
#include "vCard.h"
#import "RosyWriterVideoProcessor.h"


@interface HeadLoadViewForMulti : UIView
{
	UIActivityIndicatorView *activityView;
	UIButton *cloudBtn;
	id _parent;
	SEL callFunction;
}


- (id)initWithFrame:(CGRect)frame;
- (void)refreshCurrentView:(BOOL)isCloud;
- (void)addSelector:(SEL)select andParent:(id)parent;
@end


@class MessageCell;
@class SessionMessage;
@class RCSAccount;
@class RosyWriterVideoProcessor;

@interface MultiChatViewCtl : BaseController
<UITableViewDelegate,
UITableViewDataSource,
UIActionSheetDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
IMandSMSCheckDelegate,
MessageCellDelegate,
SelectContactPhoneCtlDelegate,
MessageCellDelegate,
ShareLocationDelegate,
SendOnTimeViewDelegate,
MixSendViewDelegate,
CABListSelectDelegate,
RosyWriterVideoProcessorDelegate,
UIDocumentInteractionControllerDelegate>
{
	NSMutableArray *showMsgs;
	SessionModel *sendSessionModel;
	UITableView  * _tableView;
	//编辑状态下 下面的视图
	UIImageView *buttonBgView;
    UIButton* deleteButton_;
    UIButton* forwardButton_;
	UIImageView *deleteMaskView;
	UIImageView *forwardMaskView;
    
	//上方 发送人选择视图
	AddReceiverContactView *AddReceiverView;	/*1.键盘弹起时,先把它置为隐藏状态
												 2.如果它将要展开,首先要把键盘收起*/
	//下方 发送视图
    MixSendView * m_sendView;
	
	UIButton *hideKeyboardBtn;					//当键盘弹起时为了收起键盘 增加的一个隐藏按键
	
	MessageCell *calCellH;						//为了计算CELL的高度
	
	CGSize keyBoardSize;						//保存键盘大小 适应IOS 5.0
	
	NSInteger curService;
	NSInteger curServiceStatus;
	NSMutableString * MutilMessageName ;
	NSMutableString * MutilMessageDetailName;
		
    
    
	//add by dyf
	HeadLoadViewForMulti *_headView;
	BOOL isEdit_;								//标识是否处在编辑状态下
	NSMutableArray *selectIndexs;				//保存处于编辑状态下选择的CELL
	BOOL isLoadingSessionMessage;               //是否正在拉取消息
	BOOL isKeyBoardShow;						//标识键盘是否弹起
	BOOL isClickBackBtn;
	UIImagePickerController *imagePickerController;
	//add end
    
    BOOL m_bIsShowReportStatus;  //是否展示状态报告
	
	
	//定时发送时的视图
	UIButton *bgBtn;							//定时发送时的灰色背景
	SendOnTimeViewCtl *clockView;				//选择时间的视图
	NSDate *sendDate;							//保存定时发送的时间
    //***BEGIN*** 修改发送消息 风火轮动画2,4秒
    NSMutableDictionary * m_animalSendingMsg;
    RosyWriterVideoProcessor *videoProcessor;
    
    //***Begin*** [MIX 播放视频] add by zhangss 2013-6-9
    MPMoviePlayerViewController *moviePlayerViewController;
    //***End*** [MIX 播放视频] add by zhangss 2013-6-9
    
    NSMutableArray * AllMessageArr;
    NSUInteger m_currentPage;
     BOOL isTextSendBySMS;    //文本消息是否当做短信发送
    UIAlertView *alertViewArrearageErrTip;
    BOOL isAlertShow;
    BOOL isVisible;
}

@property (nonatomic ,assign) BOOL isAlertShow;
@property (nonatomic ,retain) NSDate *sendDate;
@property (nonatomic ,retain) NSMutableArray *showMsgs;
@property (nonatomic ,retain) SessionModel *sendSessionModel;
@property (nonatomic, copy) NSMutableString * MutilMessageName ;
@property (nonatomic, copy) NSMutableString * MutilMessageDetailName;
@property (nonatomic ,retain) UIImagePickerController *imagePickerController;
@property (nonatomic ,retain) UIImage *mySelfHeadImage;					//自己的头像
@property (nonatomic, assign) BOOL isPopPreviousVC;

-(id)initWithSessionModel:(SessionModel *)sModel;
- (void)initAddReceiverView;
- (void)initSendOperatorView;
- (void)initTitleView;
- (void)camera;
//视频录制
- (void)cameraForVideo;
- (void)libraryPhoto;
- (CGSize)makeSizeWithImage:(UIImage *)theImage;
- (void)errorInput:(NSString *)msg;

- (void)showVideoAfterSelect:(NSString*)filePath;

- (void)refreshTableViewFrame:(BOOL)isEdit;

- (SessionMessage *)createSessionMessage:(NSString *)modelID;
- (void)insertOneCellAfterSendMsg:(SessionMessage *)msg;
- (void)addKeyBoardNotification;

- (void)sendLocation;

- (void)initDeleteOrForwardView;
- (void)refreshCheckCount:(NSInteger)allSelectNum;

- (void)loadLocalHistoryMessage;
- (void)selectOneCell:(NSIndexPath *)index;
- (void)refreshTableHeadView:(BOOL)hasNext;
- (BOOL)isOperateButtonEnable;
- (void)initMySelfHeadImage;
- (void)clockBtnPressed;
- (void)switchBtnPressed;

- (void) updateMIXUnReadCountNotification;


-(void)deleteMsgDealDatabase:(NSArray*)msgArr;
- (BOOL)checkMyServerIsLoginOn:(NSNumber *)aServer;
//根据文件路径获取该文件的UTI
- (NSString *)UTIForURL:(NSURL *)url;
//提示没有app可以打开的错误
- (void)showNoAppErr;
@end
