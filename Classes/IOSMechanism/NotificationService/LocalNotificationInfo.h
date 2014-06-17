//
//  LocalNotificationInfo.h
//  XSTestProject
//
//  Created by SAIC_Zhangss on 14-6-11.
//
//

#import <Foundation/Foundation.h>

@interface LocalNotificationInfo : NSObject

/**
 *  注册本地通知
 */
- (void)registerLocalNotification;

/**
 *  取消本地通知
 *
 *  @param noti 为空则取消所有通知
 */
- (void)cancelNoticaition:(UILocalNotification *)noti;

/**
 *  本地通知回调，APPDidLaunch回调，只有在APP关闭情况下才会回调
 *  收到通知之后，用户操作
 *  1.点击APPIcon启动 不会调用该回调
 *  2.点击通知启动     调用该回调
 *  @param dic
 *
 *  @return
 */
- (BOOL)receiveNotificationAppLaunch:(NSDictionary *)dic;

/**
 *  本地通知回调，LocalNotifcation回调，只有在APP运行时才会回调，无论前台后台
 *  收到通知之后，用户操作
 *  1.点击APPIcon启动 不会调用该回调
 *  2.点击通知启动     调用该回调
 *  3.已经启动中       调用该回调
 *
 *  @param noti
 */
- (void)receiveNoticiationDelegate:(UILocalNotification *)noti;

@end
