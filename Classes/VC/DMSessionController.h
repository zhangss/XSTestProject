//
//  DMSessionController.h
//  Megafon
//
//  Created by teng jianzhao on 12-2-8.
//  Copyright 2012 广州市易杰数码科技有限公司. All rights reserved.
//
//  Management zhangss

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "BgScrollView.h"
#import "DirectMCell.h"
#import "HPGrowingTextView.h"
#import "AsyImageView.h"
#import "ThirdAccountInfo.h"

@protocol DMSessionControllerDelegate

- (void)refrashTableView;

@end

@interface DMSessionController : BaseController<UITableViewDelegate,UITableViewDataSource,
UITextFieldDelegate,BgScrollViewDelegate,HPGrowingTextViewDelegate>
{
	UITableView     *_tableView;
	NSMutableArray  *allDirectMs;       // 所有私信的数据源
	NSString        *thirdUid;          //私聊好友的uid
	NSString        *thirdName;		    //私聊好友的name
    NSDate          *m_dmPreTimeMark;   //显示私信的最早一条Feed的时间
    NSDate          *m_dmNextTimeMark;  //显示私信的最后一条Feed的时间
	
	UIView          *operatorView;
	DirectMCell     *calCellH;
	HPGrowingTextView *theFieldSend;    //可以输入多行的控件
	CGSize          keyBoardSize;       //保存键盘大小 适应IOS 5.0
	UIButton        *hideKeyboardBtn;   //隐藏键盘的Button
	id <DMSessionControllerDelegate> m_delegate;
	UIImageView     *txtBackgroundView;
	AsyImageView    *m_headImageView;
    ThirdAccountInfo *twAccount;
}

@property (nonatomic, retain) NSDate *m_dmPreTimeMark;
@property (nonatomic, retain) NSDate *m_dmNextTimeMark;
@property (nonatomic, retain) NSString *thirdUid;
@property (nonatomic, retain) NSString *thirdName;
@property (nonatomic, assign) id <DMSessionControllerDelegate> m_delegate;

- (void)setHeadImage:(AsyImageView *)m_image;

@end
