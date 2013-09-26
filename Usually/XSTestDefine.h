//
//  XSTestDefine.h
//  XSTestProject
//
//  Created by 张松松 on 12-2-28.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

/*
 项目各种配置的宏定义
 */
/*
 *  XSTestDefine.h
 *  XSTest
 *
 */

#pragma mark -
#pragma mark UIView-->UIImage
/*
 查看大图 模式
 0:ViewController
 1:View
 ViewController支持旋转比较好
 */

#define SHOW_BINIMAGE_ANIMATION_VIEW 0 

/*
 双击放大显示的样式
 0:点击哪里 放大哪里
 1:点击哪里 都是以图片中心放大
 */
#define ZOOM_STYLE 0

/*
 双击事件的触发方式
 0:touchBegin 延迟响应
 1:手势
 */
#define DOUBLE_CLICK 0

/*
 当前版本信息
 */
#define RCS_VERSION  @"1.1.4"
#define RCS_BUILD    @"20110924"

#define HTTP_REQUEST_TIMEOUT  30

#define HTTP_TEST_URL [NSURL URLWithString:@"www.baidu.com"]

#define EMAIL_NOTIFY_NUMBER  @"10086"
#define UMS_EVENT_EMAIL      @"Administrator@megafon.com"



/*
 服务器相关请求的URL地址
 */
#define LOGIN_URL        @"/tellin/login.do"
#define MODPWD_URL       @"/tellin/pcmodifyPWD.do"
#define LOGOUT_URL       @"/tellin/logout.do"
#define REFRESHTOKEN_URL @"/tellin/authTokenRefresh.do"
#define HEARTBEAT_URL    @"/tellin/reportStatus.do"
#define CREATEUSER_URL   @"/rcs/createuser"
#define UPDATE_URL       @"/rcsPortal/cab/update.do?cversion="

//modify by cxb 2012-2-11
#define RCS_IM_DOMAIN @"megafon.ru" 
//#define RCS_IM_DOMAIN @"im.wo.com.cn"
//------
#define IM_CONNECTOR_DOMAIN @"im-connector.com"
#define MSN_IM_DOMAIN @"hotmail.com"
#define GTALK_IM_DOMAIN @"gmail.com"



/*
 RCS加好友授权状态
 */
#define FRIEND_STATUS_PENDING     "pending"
#define FRIEND_STATUS_ACTIVE      "active"
#define FRIEND_STATUS_TERMINATED  "terminated"

#define FRIEND_EVENT_REJECT       "rejected"
#define FRIEND_EVENT_APPROVED     "approved"
#define FRIEND_EVENT_SUBSCRIBE    "subscribe"
#define FRIEND_EVENT_TIMEOUT      "timeout"
#define FRIEND_EVENT_DEACTIVATED  "deactivated"

/*
 是否开启注册功能
 */
#define REGISTER_ENABLE 1        // 0:关闭  1:开启

/*
 Message扩展类型
 */
//公共的headerValue
#define HEADER_VALUE_IM_CLIENT                     @"im"
#define HEADER_VALUE_TEXT_PLAIN                    @"text/plain"

//message模块用到的headerName-----start
#define HEADER_NAME_P_ASSERTED_IDENTITY            @"P-Asserted-Identity"
#define HEADER_NAME_REQUIRE                        @"Require"      
#define HEADER_NAME_CONTENT_DISPOSITION            @"Content-Disposition"
#define HEADER_NAME_ACCEPT_CONTACT                 @"Accept-Contact"
#define HEADER_NAME_APP_TYPE                       @"APP_Type"
#define HEADER_NAME_SERVER                         @"Server"

#define HEADER_NAME_MSGEXT_MSGTYPE                 @"MsgExt.msgType"
#define HEADER_NAME_MSGEXT_MSGREPORT               @"MsgExt.msgReport"
#define HEADER_NAME_MSGEXT_LOCALMSGID              @"MsgExt.localMsgID"
#define HEADER_NAME_MSGEXT_REPORTTYPE              @"MsgExt.reportType"
#define HEADER_NAME_MSGEXT_REPORTID                @"MsgExt.reportID"
#define HEADER_NAME_MSGEXT_DONETIME                @"MsgExt.doneTime"
#define HEADER_NAME_MSGEXT_HASATTACHMENT           @"MsgExt.hasAttachment"
#define HEADER_NAME_MSGEXT_HISTORYMSGNOTIFY        @"MsgExt.historyMsgNotify"
#define HEADER_NAME_MSGEXT_OPTYPE                  @"MsgExt.OpType"
#define HEADER_NAME_MSGEXT_ANONMSG                 @"MsgExt.anonMsg"
#define HEADER_NAME_MSGEXT_ERRORCODE               @"MsgExt.errorCode"
#define HEADER_NAME_MSGEXT_IMDN_MESSAGE_ID         @"imdn.Message-ID"
#define HEADER_NAME_MSGEXT_IMDN_DISPOSITION_NOTIFICATION    @"imdn.Disposition-Notification"
//message模块用到的headerName-----end

//message模块用到的headerValue--------start
#define HEADER_VALUE_RECIPIENT_LIST_MESSAGE           @"recipient-list-message"
#define HEADER_VALUE_MULTIPART_MIXED                  @"multipart/mixed"
#define HEADER_VALUE_RENDER                           @"render"
#define HEADER_VALUE_APPLICATION_RESOURCE_LISTS_XML   @"application/resource-lists+xml"
#define HEADER_VALUE_RECIPIENT_LIST                   @"recipient-list"
#define HEADER_VALUE_ACCEPT_CONTACT                   @"*;+g.oma.sip-im"              
#define HEADER_VALUE_SERVER                           @"IM-client/OMA1.0"
#define HEADER_VALUE_APP_TYPE                         @"IMS messaging/Page-mode/CHINA UNICOM"
#define HEADER_VALUE_Message_CPIM                     @"Message/CPIM"
#define HEADER_VALUE_MESSAGE_GROUP_INVITE             @"message/group-invite"
#define HEADER_VALUE_MESSAGE_GROUP_INVITE_NOTIFY      @"message/group-invite-notify"
#define HEADER_VALUE_MESSAGE_GROUP_JOIN               @"message/group-join"
#define HEADER_VALUE_MESSAGE_GROUP_JOIN_NOTIFY        @"message/group-join-notify"
//message模块用到的headerValue--------end

//扩展字段MsgExt.msgType的取值
#define MSGEXT_MSGTYPE_IM                             @"IM"
#define MSGEXT_MSGTYPE_IM_G                           @"IM-G"
#define MSGEXT_MSGTYPE_IM_FB                          @"IM-FB"
#define MSGEXT_MSGTYPE_IM_SM                          @"IM-SM"
#define MSGEXT_MSGTYPE_IM_MM                          @"IM-MM"
#define MSGEXT_MSGTYPE_IM_EMAILNOTIFICATION           @"IM-EMAILNOTIFICATION"
#define MSGEXT_MSGTYPE_SYSTEM                         @"SYSTEM"
#define MSGEXT_MSGTYPE_REPORT                         @"REPORT"
#define MSGEXT_MSGTYPE_DISPLAY_REPORT                 @"DISPLAY-REPORT"
#define MSGEXT_MSGTYPE_SM                             @"SM"
#define MSGEXT_MSGTYPE_MM                             @"MM"
#define MSGEXT_MSGTYPE_FT                             @"FT"
#define MSGEXT_MSGTYPE_IM_GB                          @"IM-GB"

//换肤的通知
#define kThemeDidChangeNotification @"kThemeDidChangeNotification"

//默认皮肤
#define DEFAULT_NAVIGATION_COLOR [UIColor colorWithRed:0.3 green:0.65 blue:0.21 alpha:0.5]
#define DEFAULT_NAVIGATION_BG @"navigationbarBg03.png"
#define DEFAULT_NEXTBUTTON_BG @"nextBtn.png"
#define DEFAULT_PREVIOUSBUTTON_BG @"previousBtn.png"
#define DEFAULT_LOGINBACKGROUND @"login_bg03.png"
#define DEFAULT_LOGINBUTTON @"login03.png"
#define DEFAULT_FADEBUTTON @"register03.png"
#define DEFAULT_LOGINLOGO @"logoRCS03.png"
#define DEFAULT_SETTING_BG @"setting_background.png"

#define ISNULL(value) value == nil ? @"":value
#define INTVALUE(value) [value length] < 1 ? 0:[value intValue]

#pragma mark -
#pragma mark 项目字体
//常规字体
#define TEXT_FONT_REGULAR   @"Helvetica"
//粗体
#define TEXT_FONT_BOLD      @"Helvetica-Bold"
//斜体
#define TEXT_FONT_OBLIQUE   @"Helvetica-Oblique"

#pragma mark -
#pragma mark 功能开关
//监测双击时间方法
//两个方法:0,1
#define Double_Click_Value 0

#pragma mark - 
#pragma mark 界面UI相关
//控件之间的间隔~
#define VIEW_INTERVAL 10
