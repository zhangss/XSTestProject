//
//  NewDirectorMessageController.h
//  Megafon
//
//  Created by Miaohz on 11-10-11.
//  Copyright 2011 广州市易杰数码科技有限公司. All rights reserved.
//
//  Management zhangss

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "TwitterFriend.h"
#import "HPGrowingTextView.h"
#import "TopBar.h" 

@interface NewDirectorMessageController : BaseController<UITextFieldDelegate,HPGrowingTextViewDelegate> 
{
	UIView            *sendView;
	TwitterFriend     *toPerson;
	UITextField       *nameField;
	
	HPGrowingTextView *msgField;     //可以输入多行的控件
	CGSize            keyBoardSize;  //保存键盘大小 适应IOS 5.0
	
	TopBar            *m_topBar;    
	UIImageView       *sendBackgroundView;
    BOOL              isSending;     //记录当前是否正在发送私信
}

@property (nonatomic, retain) UIView        *sendView;
@property (nonatomic, retain) UITextField   *nameField;
@property (nonatomic, retain) HPGrowingTextView *msgField;
@property (nonatomic, retain) TwitterFriend *toPerson;
@property (nonatomic, retain) TopBar        *m_topBar;

//ChooseReceiverController调用
- (void)setTextName:(TwitterFriend *)m_nameText;
@end
