//
//  MessageSetting.h
//  RCS
//
//  Created by zhangshengrong on 11-7-5.
//  Copyright 2011 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseController.h"
#import "MBProgressHUD.h"

@interface MessageSettingViewController : BaseController<UITableViewDelegate,UITableViewDataSource> {
	
	UITableView *msgTable;
	
	NSArray *titleImageArray;
	NSArray *contentArray;
    NSArray *titleImageArray1;
	NSArray *contentArray1;
	
	MBProgressHUD *m_progressHUD;	//等待框 
	UISwitch *m_switchView;			//开关

	NSString *m_strLocationMessageType;//位置分享类型
	UILabel *m_locationTextLabel;//位置分享标题label
	UILabel *m_msgTypeLabel;//位置分享类型label
	
	BOOL	 m_bflag;	//转圈的标记
	UIActivityIndicatorView *m_progressView;
	UITableViewCell *m_cellIpLegacy;//IP Legacy用到的cell
    UISwitch  *switchPreview;
   // UISwitch *m_switchStatusReportView;			//状态报告开关
}
@property(nonatomic,retain)UISwitch  *switchPreview;

- (void) updateLocationMessageType;//added by sunliang

@end
