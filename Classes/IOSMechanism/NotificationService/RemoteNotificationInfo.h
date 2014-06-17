//
//  RemoteNotificationInfo.h
//  XSTestProject
//
//  Created by SAIC_Zhangss on 14-6-11.
//
//

#import <Foundation/Foundation.h>

@interface RemoteNotificationInfo : NSObject

/**
 *  第一次运行时存储NO 在UserDefault中，以此值为key
 */
FOUNDATION_EXPORT NSString * const kIsFirstLaunchKey;

/**
 *  是否应该取消注册APNs
 *  1.只有当用户手动关闭了APNs设置的时候次方法才会返回yes，此时注册会返回失败。
 *
 *  @return
 */
- (BOOL)isSholdUnregisterRemoteNotification;

/**
 *  注册远程通知服务，
 *  1.第一次注册用户会受到弹出框提示，需要用户点击yes才能成功
 *  2.注册是会后台异步调用APNs服务，如果没网的话不会注册成功也不会有失败回调。建议注册前判断网络
 *  3.苹果推荐每次启动都需要注册，第二次注册结果返回的很快，不会消耗太多。
 *  4.当用户手动关闭APNs通知之后，任何代码注册行为都不会有任何返回值。
 *  5.如果第一次授权时，用户点击NO，设置中会出现APNs相关设置么？
 */
- (void)registerRemoteNotification;

/**
 *  取消远程通知服务，
 *  1.代码取消需要慎重
 *  2.取消之后可以重新注册
 *  3.如果用户通过设置关闭推送，除非用户重新打开，否则不能重新注册
 *  4.注销API调用之后，将会删除在用户设置中的APNs相关选项，再次注册才会重新显示。故此API慎用！
 */
- (void)cancelRemoteNotification;

/**
 *  从APNs服务端成功回去DeviceToken
 *  1.该回调每次注册成功都会被调用，建议每次都注册，已持续更新token
 *  2.该回调在Token发生变更是也会回调，不一定是注册触发
 *  3.Token在开发和发布环境下是不一样的
 *  4.Token会随着设备的还原、系统升级、和APP删除重装发生改变，此时需要重新注册。
 *
 *  @param tokenData
 */
- (void)receiveDeviceToken:(NSData *)tokenData;

/**
 *  注册APNs返回失败
 *  1.一般都是证书错误或者用户设置错误导致失败
 *
 *  @param error
 */
- (void)receiveError:(NSError *)error;

/**
 *  从程序启动时获取通知内容
 *  1.此回调只有在APP关闭，并且用户点击通知进入APP时，带有推送数据内容
 *  2.点击应用Icon启动，不会带有推送内容
 *  3.通知内容只包含最新的一条
 *
 *  @param launchDic
 */
- (void)receiveRemoteNotificationLaunch:(NSDictionary *)launchDic;

/**
 *  通过远程通知回调获取通知内容
 *  1.此回调iOS3时只有在APP运行，并且用户点击通知进入APP时，带有推送数据内容
 *  2.回调在iOS7时API有更新，可以再APP关闭时，用户点击通知进入APP时触发回调。
 *  3.点击应用Icon启动，不会带有推送内容
 *  4.通知内容只包含最新的一条
 *
 *  @param userInfo 
 */
- (void)receiveRemoteNotificationDelegate:(NSDictionary *)userInfo;


@end
