//
//  WaitingView.m
//  XSTestProject
//
//  Created by zhangss on 13-9-25.
//
//

#import "WaitingView.h"

@implementation WaitingView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _progressHUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
        [[UIApplication sharedApplication].keyWindow addSubview:_progressHUD];
    }
    return self;
}

- (void)showWaitView:(NSString *)showStr
{
    if (showStr == nil || [showStr length] < 1)
    {
        showStr = NSLocalizedString(@"等待中...",nil);
    }
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:_progressHUD];
    _progressHUD.labelText = showStr;
    [_progressHUD show:YES];
}

- (void)hideWaitView
{
    [_progressHUD hide:NO];
}

- (void)showAutoDismissView:(NSString*)showStr
{
    if (showStr == nil || [showStr length] < 1)
    {
        return;
    }
    if (_autoDisMissHUD != nil)
    {
        [_autoDisMissHUD removeFromSuperview];
        _autoDisMissHUD = nil;
    }
    
    _autoDisMissHUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
    _autoDisMissHUD.frame = CGRectMake(0.0f, 0.0f, 320.0f, 480.0f);
    _autoDisMissHUD.removeFromSuperViewOnHide = YES;
    _autoDisMissHUD.mode = MBProgressHUDModeText;
    _autoDisMissHUD.labelText = showStr;
    [[UIApplication sharedApplication].keyWindow addSubview:_autoDisMissHUD];
    [_autoDisMissHUD show:YES];
    
    [_autoDisMissHUD hide:YES afterDelay:1.0f];
}

@end
