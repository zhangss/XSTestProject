//
//  WaitingView.h
//  XSTestProject
//
//  Created by zhangss on 13-9-25.
//
//

#import <UIKit/UIKit.h>

@interface WaitingView : UIView
{
    MBProgressHUD *_progressHUD;
    MBProgressHUD *_autoDisMissHUD;
}

- (void)showWaitView:(NSString *)showStr;
- (void)hideWaitView;
- (void)showAutoDismissView:(NSString*)showStr;

@end
