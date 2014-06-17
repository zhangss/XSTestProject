//
//  LocalNotificationInfo.m
//  XSTestProject
//
//  Created by SAIC_Zhangss on 14-6-11.
//
//

#import "LocalNotificationInfo.h"

#define kLaunch @"Launch"
#define kDelegate @"delegate"
#define kType @"Type"

@implementation LocalNotificationInfo

- (void)registerLocalNotification
{
    if ([[[UIApplication sharedApplication] scheduledLocalNotifications] count] == 0)
    {
        NSLog(@"LocalNotification Register!");
        //初始化本地通知
        UILocalNotification *localNoti = [[UILocalNotification alloc] init];
        //设置通知产生时间
        localNoti.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];
        //设置循环重复时间
        localNoti.repeatInterval = NSCalendarUnitMinute;
        //设置badge
        localNoti.applicationIconBadgeNumber = 1;
        //音频格式awf,不要超过30s
        localNoti.soundName = UILocalNotificationDefaultSoundName;
        //通知内容
        localNoti.alertBody = @"我是一个本地通知";
        //设置为No时 Alert只有一个OK按钮
        localNoti.hasAction = YES;
        //设置按钮显示文字 可国际化
        localNoti.alertAction = @"打开";
        //设置附带的用户信息
        NSDictionary *dic = [NSDictionary dictionaryWithObject:@"value" forKey:@"key"];
        localNoti.userInfo = dic;
        
        //注册通知
        if (localNoti.fireDate)
        {
            [[UIApplication sharedApplication] scheduleLocalNotification:localNoti];
        }
        else
        {
            [[UIApplication sharedApplication] presentLocalNotificationNow:localNoti];
        }
    }
    else
    {
        NSLog(@"LocalNotification Already Registered!");
    }
}

- (BOOL)receiveNotificationAppLaunch:(NSDictionary *)dic
{
    if ([[dic objectForKey:UIApplicationLaunchOptionsLocalNotificationKey] isKindOfClass:[UILocalNotification class]])
    {
        UILocalNotification *noti = [dic objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
        noti.userInfo = [NSDictionary dictionaryWithObject:kLaunch forKey:kType];
        [self showNotificationInfo:noti];
        return YES;
    }
    return NO;
}

- (void)receiveNoticiationDelegate:(UILocalNotification *)noti
{
    noti.userInfo = [NSDictionary dictionaryWithObject:kDelegate forKey:kType];
    [self showNotificationInfo:noti];
}

- (void)showNotificationInfo:(UILocalNotification *)noti
{
    UIAlertView *alert =
    [[UIAlertView alloc] initWithTitle:@"通知"
                               message:[[noti userInfo] description]
                              delegate:nil
                     cancelButtonTitle:@"确定"
                     otherButtonTitles:nil];
    [alert show];
    noti.applicationIconBadgeNumber = 0;
    [self cancelNoticaition:noti];
}


- (void)cancelNoticaition:(UILocalNotification *)noti
{
    if (noti)
    {
        [[UIApplication sharedApplication] cancelLocalNotification:noti];
    }
    else
    {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }
}

@end
