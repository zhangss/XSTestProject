    //
//  UILabel+Extra.m
//  XSTestProject
//
//  Created by 张松松 on 12-2-28.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "UILabel+Extra.h"

//常规使用的字体
//#define kRegularFont @"Verdana"           //常规
//#define kRegularBoldFont @"Verdana-Bold"  //加粗

//begin [工程字体格式修改] zhengxiaohe 2012-2-24 modify
//#define kRegularFont @"ArialMT"               //常规
//#define kRegularBoldFont @"Arial-BoldMT"      //加粗
//#define kNavTitleBoldFont @"Helvetica-Bold" 

#define kRegularFont @"Helvetica"               //常规
#define kRegularBoldFont @"HelveticaNeue-Bold"      //加粗
#define kNavTitleBoldFont @"HelveticaNeue-Bold" 
//end

//常规使用的颜色 
//1.深灰色 用于提示性的文字内容 如输入时提示的文字 及邮件中的时间
#define kColorDeepGray [UIColor colorWithRed:204.0/255.0f green:204.0/255.0f blue:204.0/255.0f alpha:1.0f]
//2.中灰色 用于常规显示的灰色字体
#define kColorRegularGray [UIColor colorWithRed:179.0/255.0f green:179.0/255.0f blue:179.0/255.0f alpha:1.0f]
//3.常规灰色 用于心情/签名/副标题等
#define kColorLightGray [UIColor colorWithRed:153.0/255.0f green:153.0/255.0f blue:153.0/255.0f alpha:1.0f]
//4.深黑色 用于主标题 名字等 聊天中的文字
#define kColorDeepBlack [UIColor colorWithRed:51.0/255.0f green:51.0/255.0f blue:51.0/255.0f alpha:1.0f]
#define kColorOneBoxSub [UIColor colorWithRed:136.0/255.0f green:136.0/255.0f blue:136.0/255.0f alpha:1.0f]
//5.中黑色 用于常规像是的黑色字体  modify by zhengxiaohe
//#define kColorRegularBlack [UIColor colorWithRed:85.0/255.0f green:85.0/255.0f blue:85.0/255.0f alpha:1.0f]
#define kColorRegularBlack [UIColor colorWithRed:128.0/255.0f green:128.0/255.0f blue:128.0/255.0f alpha:1.0f]

//6.轻度的黑色 主要用于TableView的分段Title 如注册部分提示的文字、A-Z和分组中的名字Titile
#define kColorLightBlack [UIColor colorWithRed:102.0/255.0f green:102.0/255.0f blue:102.0/255.0f alpha:1.0f]

//7.Inbox中的绿色的时间标签 
#define kColorBlueTimeMark [UIColor colorWithRed:101.0/255.0f green:170.0/255.0f blue:227.0/255.0f alpha:1.0f]
#define kColorBlueTimeMark1 [UIColor colorWithRed:151.0/255.0f green:197.0/255.0f blue:0.0/255.0f alpha:1.0f]
//8.OneBox主界面的read标签
#define kColorGreenReadMark [UIColor colorWithRed:73.0/255.0f green:267.0/255.0f blue:57.0/255.0f alpha:1.0f]
//9.注册部分套餐的价格颜色
#define kColorPackagePrice [UIColor colorWithRed:56.0/255.0f green:156.0/255.0f blue:57.0/255.0f alpha:1.0f]
//10.联系人及自己简介的changPhoto
#define kColorChangePhoto [UIColor colorWithRed:191.0/255.0f green:142.0/255.0f blue:210.0/255.0f alpha:1.0f]

#define kColorblueLight [UIColor colorWithRed:166.0/255.0f green:196.0/255.0f blue:48.0/255.0f alpha:1.0f]

#define kTimeLightBlue [UIColor colorWithRed:147.0/255.0f green:184.0/255.0f blue:0.0/255.0f alpha:1.0f]
#define kDetailNameBlueColor [UIColor colorWithRed:130.0/255.0f green:149.0/255.0f blue:113.0/255.0f alpha:1.0f]
#define kMoreEmailSetting [UIColor colorWithRed:99.0/255.0f green:99.0/255.0f blue:99.0/255.0f alpha:1.0f]
#define kLoginInColor [UIColor colorWithRed:225.0/255.0f green:225.0/255.0f blue:225.0/255.0f alpha:1.0f]


@implementation UILabel (Extra)

- (void)labelWithType:(LabelType)type {
	switch (type) {
			//**********常规使用的
		case kNavigationButton://导航栏按钮
		{
			self.font = [UIFont fontWithName:kRegularFont size:13.0f];
			self.textColor = [UIColor whiteColor];
		}
			break;
		case kNavigationTitle://导航栏标题
		{
			self.font = [UIFont fontWithName:kNavTitleBoldFont size:20.0f];
			self.textColor = [UIColor whiteColor];
		}
			break;
		case kBigButtonTitle://大按钮的标题 宽度300
		{
			self.textColor = [UIColor whiteColor];
			self.font = [UIFont fontWithName:kRegularFont size:18.0f];
		}
			break;
		case kLabelName1://菜单名字1 17黑色
		{
			self.textColor = kColorRegularBlack;
			self.font = [UIFont fontWithName:kRegularFont size:18.0f];
		}
			break;
		case kLabelName2://菜单名字2 17灰色
		{
			self.textColor = kColorRegularGray;
			self.font = [UIFont fontWithName:kRegularFont size:19.0f];
		}
			break;
		case kLabelName3://菜单名字3 14黑色
		{
			self.textColor = kColorRegularBlack;
			self.font = [UIFont fontWithName:kRegularFont size:16.0f];
		}
			break;
		case kLabelName4://菜单名字4 11灰色
		{
			self.textColor = kColorRegularBlack;
			self.font = [UIFont fontWithName:kRegularFont size:13.0f];
		}
			break;
		case kInput://输入的文字
		{
			self.textColor = kColorRegularBlack;
			self.font = [UIFont fontWithName:kRegularFont size:18.0f];
		}
			break;
		case kTime://邮件中时间
		{
			self.font = [UIFont fontWithName:kRegularFont size:12.0f];
			self.textColor = kColorLightGray;
		}			
			break;
		case kSystemTips://系统提示框
		{
			self.font = [UIFont fontWithName:kRegularFont size:21.0f];
			self.textColor = [UIColor whiteColor];
		}
			break;
		case kCustomButton://自定义按钮
		{
			self.font = [UIFont fontWithName:kRegularFont size:13.0f];
			self.textColor = kColorLightBlack;
			//			self.textColor = [UIColor colorWithRed:64.0/255.0f green:71.0/255.0f blue:98.0/255.0f alpha:1.0f];
			//			self.shadowColor = [UIColor blackColor];
			//			self.shadowOffset = CGSizeMake(0, -1);
		}
			break;
		case kCustomButton2://自定义按钮 12
		{
			self.font = [UIFont fontWithName:kRegularFont size:14.0f];
			self.textColor = kColorLightBlack;
		}
			break;
		case kActionSheetTitle://系统actionSheet标题
		{
			self.font = [UIFont fontWithName:kRegularFont size:19.0f];
			self.textColor = [UIColor whiteColor];
			self.textAlignment = UITextAlignmentCenter;
			self.shadowColor = [UIColor blackColor];
			self.shadowOffset = CGSizeMake(0, -1);
		}
			break; 
		case kVoipNavigationSubtitle://Voip界面导航栏小标题
		{
			self.font = [UIFont fontWithName:kRegularBoldFont size:18.0f];
			self.textColor = [UIColor whiteColor];
			self.textAlignment = UITextAlignmentCenter;
		}
			break;
		case kMenuContent://菜单内容
		{
			self.font = [UIFont fontWithName:kRegularFont size:17.0f];
			self.textColor = [UIColor colorWithRed:28.0/255.0f green:100.0/255.0f blue:180.0/255.0f alpha:1.0f];
		}
			break;
		case kMenuTips://菜单提示文字
		{
			self.font = [UIFont fontWithName:kRegularFont size:17.0f];
			self.textColor = kColorLightGray;
		}
			break;
		case kDescription://说明文字
		{
			self.font = [UIFont fontWithName:kRegularFont size:17.0f];
			self.textColor = [UIColor colorWithRed:71.0/255.0f green:87.0/255.0f blue:111.0/255.0f alpha:1.0f];
			self.shadowColor = [UIColor whiteColor];
			self.shadowOffset = CGSizeMake(0, -1);
		}			
			break;
			//**********AAS 登陆及注册部分
		case ktipContent://提示内容  如注册部分的提示内容
		{
			self.textColor = kColorLightBlack;
			self.font = [UIFont fontWithName:kRegularFont size:16.0f];
		}
			break;
		case kInputTips://输入框内提示文字
		{
			self.textColor = kColorDeepGray;
			self.font = [UIFont fontWithName:kRegularFont size:21.0f];
		}
			break;
		case kSectionHeaderTitle://TableView的组名（注册）//oneBox 字体
		{
			self.textColor = kColorLightBlack;
			self.font = [UIFont fontWithName:kRegularFont size:19.0f];
		}
			break;
		case kTipsUserAccount://提示中显示的用户账号
		{
			self.textColor = kColorPackagePrice;
			self.font = [UIFont fontWithName:kRegularBoldFont size:16.0f];
		}
			break;
		case kPackagePriceNumber://套餐价格数字
		{
			self.textColor = kColorPackagePrice;
			self.font = [UIFont fontWithName:kRegularFont size:38.0f];
		}
			break;
		case kPriceUnit://货币的单位
		{
			self.textColor = kColorPackagePrice;
			self.font = [UIFont fontWithName:kRegularFont size:24.0f];
		}
			break;
		case kTimeUnit://时间单位（套餐中的） 
		{
			self.textColor = kColorLightGray;
			self.font = [UIFont fontWithName:kRegularFont size:16.0f];
		}
			break;
		case kPackageName://套餐名称 
		{
			self.textColor = kColorRegularBlack;
			self.font = [UIFont fontWithName:kRegularFont size:16.0f];
		}
			break;
			//**********Contact 部分
		case kSegementTitle://分段控制器标题
		{
			self.textColor = [UIColor whiteColor];
			self.font = [UIFont fontWithName:kRegularFont size:14.0f];
		}
			break;
		case kTabBarTitle://分段控制器标题
		{
			self.textColor = [UIColor grayColor];
			self.font = [UIFont fontWithName:kRegularBoldFont size:10.0f];
		}
			break;
		case kContactName://联系人名字 
		{
			self.textColor = kColorDeepBlack;
			self.font = [UIFont fontWithName:kRegularBoldFont size:16.0f];
		}
			break;
		case kSignatureOrNumber://联系人签名或者电话号码
		{
			self.textColor = kColorLightGray;
			self.font = [UIFont fontWithName:kRegularFont size:14.0f];
		}
			break;		
		case kContactGroupName://联系人分组显示 组名
		{
			self.textColor = kColorLightBlack;
			self.font = [UIFont fontWithName:kRegularBoldFont size:15.0f];
		}
			break;
		case kChangePhotoTips://更换头像的提示文字
		{
			self.textColor = kColorChangePhoto;
			self.font = [UIFont fontWithName:kRegularFont size:14.0f];
		}
			break;
			//*********Onebox部分 名字参考kContactName,
		case kTipsNumber://cell提示的更新之类的数字
		{
			self.textColor = [UIColor whiteColor];
			self.font = [UIFont fontWithName:kRegularFont size:14.0f];
		}
			break;
			//begin [AR-FUNC ONEBOX 界面标题字体] 2012/02/13   
        case kOneBoxSub://begin [AR - FUC onebox主界面内容颜色] zhengxiahe 2012/02/13 add
		{
			self.font = [UIFont fontWithName:kRegularFont size:15.0f];
			self.textColor = kColorOneBoxSub;
		}
			break;
            //end
		case kMailBoxTitle://MailBox 标题
		{
			self.textColor = kColorRegularBlack;
			self.font = [UIFont fontWithName:kRegularBoldFont size:16.0f];
		}
			break;
		case kReadMark://cell绿色的已读标记
		{
			self.textColor = kColorGreenReadMark;
			self.font = [UIFont fontWithName:kRegularFont size:13.0f];
		}
			break;
		case kTimeMark://cell时间标签
		{
			self.textColor = kColorDeepGray;
			self.font = [UIFont fontWithName:kRegularFont size:16.0f];
		}
			break;
		case kOneboxContent://OneBox内容的预览
		{
			self.textColor = kColorRegularBlack;
			self.font = [UIFont fontWithName:kRegularFont size:14.0f];
		}
			break;	
		case kMainContent://cell主内容
		{
			self.textColor = kColorLightGray;
			self.font = [UIFont fontWithName:kRegularFont size:13.0f];
		}
			break;
		case kMailTitle://Inbox中的邮件标题
		{
			self.textColor = kColorRegularBlack;
			self.font = [UIFont fontWithName:kRegularFont size:13.0f];
		}
			break;
		case kMailTime://Inbox中的时间标签
		{
			self.textColor = kColorBlueTimeMark;
			self.font = [UIFont fontWithName:kRegularFont size:14.0f];
		}
			break;
        case kOneBoxTime://Inbox中的时间标签
		{
			self.textColor = kColorBlueTimeMark1;
			self.font = [UIFont fontWithName:kRegularFont size:12.0f];
		}
			break;
			//***********IM聊天
		case kChatContent://聊天的文字
		{
			self.textColor = kColorDeepBlack;
			self.font = [UIFont fontWithName:kRegularFont size:13.0f];
		}
			break;
		case kChatTimeMark://聊天中的时间
		{
			self.textColor = kColorLightBlack;
			self.font = [UIFont fontWithName:kRegularFont size:11.0f];
		}
			break;
		case kChatTips://聊天界面的提示
		{
			self.textColor = kColorRegularGray;
			self.font = [UIFont fontWithName:kRegularFont size:11.0f];
		}
			break;
		case kMenuItems://SNS菜单选项
		{
			self.textColor = [UIColor whiteColor];
			self.font = [UIFont fontWithName:kRegularBoldFont size:21.0f];
		}
			break;
			//begin [字体颜色调整]zhengxiaohe 2012-2-24 add    
        case  kOneBoxTimeMark:
        {
			self.textColor = kTimeLightBlue;
			self.font = [UIFont fontWithName:kRegularFont size:12.0f];
		}
			break;
		case kTitleContentMark:
        {
			self.textColor = [UIColor blackColor];
			self.font = [UIFont fontWithName:kRegularBoldFont size:16.0f];
		}
            break;
        case kOneBoxButtonMark:
        {
			self.textColor = [UIColor whiteColor];
			self.font = [UIFont fontWithName:kRegularBoldFont size:18.0f];
		}
            break;
        case kDetailContactMark:
        {
			self.textColor = kDetailNameBlueColor;
			self.font = [UIFont fontWithName:kRegularBoldFont size:14.0f];
		}
            break;
        case kNameInfoMark:
        {
			self.textColor = [UIColor blackColor];
			self.font = [UIFont fontWithName:kRegularFont size:14.0f];
		}
            break;
        case kNameMark:
        {
			self.textColor = [UIColor blackColor];
			self.font = [UIFont fontWithName:kRegularFont size:17.0f];
		}
            break;
        case kNameSignatureMark:
        {
			self.textColor = kColorOneBoxSub;
			self.font = [UIFont fontWithName:kRegularFont size:13.0f];
		}
            break;
        case kContactNameMark:
        {
			self.textColor = [UIColor blackColor];
			self.font = [UIFont fontWithName:kRegularBoldFont size:15.0f];
		}
            break;
        case kEmailSettingMark:
        {
			self.textColor = kMoreEmailSetting;
			self.font = [UIFont fontWithName:kRegularFont size:16.0f];
		}
            break;
        case kButtonTitleMark:
        {
			self.textColor = kLoginInColor;
			self.font = [UIFont fontWithName:kRegularFont size:17.0f];
		}
            break;   
		default:
			break;
	}
}

@end
