//
//  NewSNSViewController.h
//  Megafon
//
//  Created by zhangss on 11-10-10.
//  Copyright 2011 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "TopBar.h"
#import "SNSCheck.h"
#import "ChooseReceiverController.h"
#import "SNSDefs.h"

@class SNSCheck;

@interface NewSNSViewController : BaseController
<UITextViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,
UIImagePickerControllerDelegate,SNSCheckDelegate,UIAlertViewDelegate>
{
	TopBar          *m_topBar;         //状态栏上的发送状态
	
	//假的导航栏及其button
	UIView          * _hView;
	UIButton        * _Cancel;
	UIButton        * _Send;
	
	//主视图控件
	NSString        *m_title;          //Title
	UIScrollView    *bgView;           //主View
	UITextView      *newText;          //TextView 输入控件
	UIView          *operateView;      //除去输入控件 剩余的部分   
	
	//包含在OperateView的控件
	UIButton        *addBtn;           //"+"Button
	SNSCheck        *oneSNS;           //单个的第三发图标Button
	UIView          *logoBtnView;      //承载“+”及第三方图标的View
	UIImageView     *operaBarImageView;//背景View 整个操作条
	
	//图片相关
	UIImageView     *selectResult;     //选择图片或者视频之后显示的图片
	UIButton        *btnselect;        //缩略图的边框
	UIButton        *layerBtn;         //点击图片响应时间的button
	NSString        *fileUrl;          //待发送的图片路径
	NSMutableDictionary *m_videoDic;   //发送视频的信息词典
	FEED_SHARE_PRIVACY  _sharePrivacy; //发送文本Feed FB权限参数	
	
	//字数 计数相关
	UILabel         *contentNumLB;     //Label
    NSInteger       nMaxTextLength;    //最大字数长度
	
	id              _object;           //父视图
	NSInteger       receiveCount;      //判断发送feeds的时候是否全部返回 每返回一个自减1
	NSMutableArray  *sendTypeArray;    //缓存记录发送的类型 做失败提示使用

	//关于分享状态相关
	NSMutableArray      *bindedSNS;    //选择的第三方数组
    BOOL                m_hasTwitter;  //是否绑定TW 用于@判断
	BOOL                m_isTWSelected;//是否选择TW      
	BOOL                m_isFBSelected;//是否选择了FB
	BOOL                m_isFBPublic;  //选择FB分享到所有人
	BOOL                m_isVKSelected;//是否选择VK
	BOOL                m_isODSelected;//是否选择OD
    
    TwitterFriend       *atPerson;
    BOOL                isPortraitKey;
    CGSize              keyBoardSize;
}

@property (nonatomic, retain) TopBar    *m_topBar;//add by jia_wenbo
@property (nonatomic, assign) NSInteger nMaxTextLength;
@property (nonatomic, assign) SNSCheck  *oneSNS;
@property (nonatomic, retain) TwitterFriend *atPerson;//add by wangchao 2012/3/17

- (void)initObject:(id)object;
- (id)initNewFeedWithTitle:(NSString *)titleStr;//add by jia_wb 4-10
// “@” 选择好友界面需要调用
- (void)getTwitterPersonDisplayName;
//SNSCheck需要
- (void)onCheckTypeChanged:(NSInteger)curType isSelected:(BOOL)isSelected;
//横竖屏切换
- (void)changeSelfFrame:(BOOL)isPortrait;
@end
