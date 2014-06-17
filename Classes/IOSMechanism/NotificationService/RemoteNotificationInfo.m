//
//  RemoteNotificationInfo.m
//  XSTestProject
//
//  Created by SAIC_Zhangss on 14-6-11.
//
//

#import "RemoteNotificationInfo.h"

#define kLaunch @"Launch"
#define kDelegate @"delegate"
#define kType @"Type"

NSString * const kIsFirstLaunchKey = @"kIsFirstLaunch";

@interface RemoteNotificationInfo ()
@property (nonatomic,assign) BOOL isFirstLaunch;
@end

@implementation RemoteNotificationInfo


- (id)init
{
    self = [super init];
    if (self)
    {
        [self isFirstLaunchApp];
    }
    return self;
}

/**
 *  获取APP是否第一次运行，结果影响注册APNs的类型
 */
- (void)isFirstLaunchApp
{
    _isFirstLaunch = [[NSUserDefaults standardUserDefaults] boolForKey:kIsFirstLaunchKey];
    if (!_isFirstLaunch)
    {
        _isFirstLaunch = YES;
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kIsFirstLaunchKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (BOOL)isSholdUnregisterRemoteNotification
{
    /**
     *  返回远程推送支持的样式
     *  1.样式在APP第一安装是调用注册接口设置的
     *  2.样式可以被用户修改，在设备的设置-通知中心-找到相关APP设置
     *  3.UIRemoteNotificationTypeNone表示禁用推送通知
     */
    if ([[UIApplication sharedApplication] enabledRemoteNotificationTypes] == UIRemoteNotificationTypeNone && !_isFirstLaunch)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)registerRemoteNotification
{
    //如果没有注册 则注册APNS通知
    UIRemoteNotificationType type;
    
    if (_isFirstLaunch)
    {
        type = (UIRemoteNotificationTypeBadge |
                UIRemoteNotificationTypeSound |
                UIRemoteNotificationTypeAlert);
    }
    else
    {
        type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
    }
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:type];
}

- (void)cancelRemoteNotification
{
    UIRemoteNotificationType type = UIRemoteNotificationTypeNone;
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:type];
    
    //慎用！会删除与APP通知相关的设置选项
//    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
}

- (void)receiveDeviceToken:(NSData *)tokenData
{
    //转换为String
    NSString *devicetoken = [NSString stringWithFormat:@"%@",tokenData];
    //    NSString *deviceToken = @"<b8dccc76 4e1e985c b82e18ab 52e4c7ea 2d6fac9c 3ead7346 b095f18f 07870fdd>";
    //处理Token
    devicetoken = [[[devicetoken
                     stringByReplacingOccurrencesOfString:@"<" withString:@""]
                    stringByReplacingOccurrencesOfString:@">" withString:@""]
                   stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"DeviceToken:\n%@",devicetoken);
    
    //Send Token To Server...
    
}

- (void)receiveError:(NSError *)error
{
    NSLog(@"RemoteNotification Register Error\n%@",error);
}

- (void)receiveRemoteNotificationLaunch:(NSDictionary *)launchDic
{
    if ([launchDic objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey])
    {
        NSMutableDictionary *notiInfo = [NSMutableDictionary dictionaryWithDictionary:[launchDic objectForKey:UIApplicationLaunchOptionsLocalNotificationKey]];
        [notiInfo setObject:kLaunch forKey:kType];
        [self showNotificationInfo:notiInfo];
    }
}

- (void)receiveRemoteNotificationDelegate:(NSDictionary *)userInfo
{
    NSMutableDictionary *notiInfo = [NSMutableDictionary dictionaryWithDictionary:userInfo];
    [notiInfo setObject:kDelegate forKey:kType];
    [self showNotificationInfo:notiInfo];
}

- (void)showNotificationInfo:(NSDictionary *)notiInfo
{
    UIAlertView *alert =
    [[UIAlertView alloc] initWithTitle:[notiInfo objectForKey:kType]
                               message:[notiInfo description]
                              delegate:nil
                     cancelButtonTitle:@"确定"
                     otherButtonTitles:nil];
    [alert show];
}

@end
