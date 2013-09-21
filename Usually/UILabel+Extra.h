//
//  UILabel+Extra.h
//  XSTestProject
//
//  Created by 张松松 on 12-2-28.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/*2012-2-27 UIUE问题要能够适应需求的迅速变更
 *此处规定整个工程中的文字字体及颜色 应该做详细的模块划分*
 0.主体部分.导航栏.工具栏.
 1.注册.登陆.引导流程
 2.Contact联系人
 3.Mix,onebox部分
 4.SNS第三方Feed部分
 5.More部分
 *要统一一部分主题的颜色字体，更换的时候能改变大部分的界面 如名字.内容.cell的文字
 */

typedef enum{
	//**********常规使用
	kNavigationButton,      //导航栏按钮
	kNavigationTitle,       //导航栏标题 
	
	
	
	kLabelName1,            //菜单名字1  17 黑色
	kLabelName2,            //菜单名字2  17 灰色
	kLabelName3,            //菜单名字3  14 黑色
	kLabelName4,            //菜单名字4  11 灰色 
	kInput,                 //输入的文字  17
	kTime,                  //邮件中时间
	kSystemTips,            //系统提示框
	kCustomButton,          //自定义按钮  大小11
	kCustomButton2,         //自定义按钮2 大小12
	kActionSheetTitle,      //系统actionSheet标题
	kVoipNavigationSubtitle,//Voip界面导航栏小标题
	kMenuContent,           //菜单内容
	kMenuTips,              //菜单提示文字
	kDescription,           //说明文字
	
	//**********AAS 登陆及注册部分
	ktipContent,            //背景浅绿色的提示内容 
	kInputTips,             //输入框内提示文字 
	kSectionHeaderTitle,    //TableView的组名（注册） 
	kTipsUserAccount,       //提示中显示的用户账号
	kPackagePriceNumber,    //套餐价格数字 
	kPriceUnit,             //货币的单位 
	kTimeUnit,              //时间单位（套餐中的） 
	kPackageName,           //套餐名称 
	
	//**********CAB 联系人部分
	kSegementTitle,         //分段控制器标题 
	kTabBarTitle,           //TabbarController 的菜单按钮
	kContactName,           //联系人名字 
	kSignatureOrNumber,     //联系人签名或者电话号码 
	kContactGroupName,      //联系人分组显示 组名 
	kBigButtonTitle,        //大按钮的标题 （大小300） 
	kChangePhotoTips,       //更换头像的提示文字 
	
	//*********Onebox部分 名字参考kContactName,
	kTipsNumber,            //cell提示的更新之类的数字
	kMailBoxTitle,          //MailBox的标题 
	kOneboxContent,         //cell的内容预览
	kReadMark,              //cell绿色的已读标记
	kTimeMark,              //cell时间标签
	kMainContent,           //cell主内容
	kMailTitle,             //Inbox中的邮件标题
	kMailTime,              //Inbox中的时间标签
	kOneBoxTime,
    kOneBoxSub,
	
	//*********IM聊天
	kChatContent,           //聊天的文字
	kChatTimeMark,          //聊天中的时间
	kChatTips,              //聊天界面的提示
	
	//*********SNS菜单选项
	kMenuItems,
	
    //*********zhengxiaohe new add
    kOneBoxTimeMark,        //时间标签 add by zhengxiaohe 2012-2-24
    kTitleContentMark,      //onebox 标题标签
    kOneBoxButtonMark,      //onebox 标题button标签
    kDetailContactMark,     //detail of contact name 标签
    kNameInfoMark,          //detail of contact name 信息标签
    kNameMark,              //detail of contact name
    kNameSignatureMark,      //detail of contact name 签名标签
    kContactNameMark,        //contact name标题文字标签
    kEmailSettingMark,     //emailSetting cel文字标签
    kButtonTitleMark,      //button  字体显示验颜色
}LabelType;

@interface UILabel (Extra) 

//统一控制显示的字体和颜色
- (void)labelWithType:(LabelType)type;

@end
