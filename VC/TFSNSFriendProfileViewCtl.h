//
//  TFSNSFriendProfileViewCtl.h
//  Megafon
//
//  Created by  yafeng on 11-10-25.
//  Copyright 2011 广州市易杰数码科技有限公司. All rights reserved.
//
//  Management zhangss


#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "AsyImageView.h"
#import "ReturnCodeModel.h"
#import "ThirdAccountInfo.h"

@interface TFSNSFriendProfileViewCtl : BaseController
<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIAlertViewDelegate>
{

	UITableView    *table;
	AsyImageView   *myHeadImage;
	UILabel        *showName;
    UIImageView    *thirdPartyIcon;
	NSInteger      tfType;        /*10.facebook 11.twitter 12.VK 13.OD*/
	
    ThirdAccountInfo *thirdPerson;
	BOOL           isLoad;        //已经请求自己Profile成功
	BOOL           isEdit;
	
	NSMutableArray *editableKeys;
	NSMutableArray *editableValues;
	NSMutableDictionary *unEditableDic;
	UISwitch       *swConnect;     //facebook的im登录	
	UISwitch       *autoLogin;     //facebook的自动登录设置

	int            retaincount;
	int            lastCount;

    BOOL                     isFromSNSHideSwith;        //NO:FB IM需要显示登陆的Switch YES:FB SNS 要隐藏
    UIActivityIndicatorView  *m_SwitchConnectorToServer;//开关调用服务器风火轮添加 zhengxiaohe 2012-10-09 add
    ReturnCodeModel	         *m_ReturnCodeModel;        //绑定结果返回对象 zhengxiaohe 2012-11-14 add
    BOOL                     m_TempSwitchStatue;        //控制登录开关状态变量 zhengxiaohe 2012-12-06 add
    BOOL                     m_isDeleteBinding;  //控制解绑（界面卡时，可能出现多次点击解绑按钮，多次弹出解绑提示，发送多次解绑请求）
}

@property (nonatomic, retain) UIImageView *thirdPartyIcon;
@property (nonatomic, assign) BOOL        isFromSNSHideSwith;
@property (nonatomic, retain) UIActivityIndicatorView *switchConnectorToServer;//开关调用服务器风火轮属性添加 zhengxiaohe 2012-10-09 add
@property (nonatomic, retain) ThirdAccountInfo *thirdPerson;
@property (nonatomic, retain) ReturnCodeModel  *returnCodeModel;//绑定结果返回对象 zhengxiaohe 2012-11-14 add
@property (nonatomic, assign) BOOL             tempSwitchStatue;//控制登录开关状态变量 zhengxiaohe 2012-12-06 add

- (id)initMyProfileSNSType:(NSInteger)snsType;
- (NSString *)getBirthday:(NSDate *)birthday;

@end
