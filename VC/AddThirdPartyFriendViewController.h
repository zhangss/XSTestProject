//
//  AddThirdPartyFriendViewController.h
//  Megafon
//
//  Created by zhangss on 11-10-12.
//  Copyright 2011 广州市易杰数码科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"

@class MBProgressHUD;
@interface AddThirdPartyFriendViewController : BaseController
<UITextFieldDelegate,
UIAlertViewDelegate> 
{
	NSString *titleString;
	UITextField *accountField;
    NSTimer     *m_AddThirdTimer;
    NSNumber    *m_ThirdAccountStatue;
    MBProgressHUD * S_MBProgreeHuD;
}
@property (nonatomic,retain) NSString *titleString;
@property (nonatomic,retain) NSNumber *thirdAccountStatue;
@end
