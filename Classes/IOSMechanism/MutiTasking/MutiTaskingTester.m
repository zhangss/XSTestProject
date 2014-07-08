//
//  MutiTaskingTester.m
//  XSTestProject
//
//  Created by SAIC_Zhangss on 14-7-7.
//
//

#import "MutiTaskingTester.h"

@interface MutiTaskingTester ()

//后台任务标示符
@property (nonatomic,assign) UIBackgroundTaskIdentifier backTaskIdentifier;
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation MutiTaskingTester


- (BOOL)isMultitaskingSupported
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)])
    {
        return [[UIDevice currentDevice] isMultitaskingSupported];
    }
    else
    {
        //兼容4.0以下
        return NO;
    }
}

- (BOOL)isAppInBackgroundState
{
    //iOS4
    //获取APP当前运行状态
    UIApplicationState appState = [[UIApplication sharedApplication] applicationState];
    if (appState == UIApplicationStateActive)
    {
        /*
         The app is running in the foreground and currently receiving events.
         APP正在前台运行
         */
        NSLog(@"UIApplicationStateActive");
        return NO;
    }
    else if (appState == UIApplicationStateBackground)
    {
        /*
         在后台运行中
         */
        NSLog(@"UIApplicationStateBackground");
        return YES;
    }
    else if (appState == UIApplicationStateInactive)
    {
        /*
         The app is running in the foreground but is not receiving events. This might happen as a result of an interruption or because the app is transitioning to or from the background.
         APP在前台运行，但是被阻断了不能接收事件。
         */
        NSLog(@"UIApplicationStateInactive");
        return NO;
    }
    return NO;
}

- (void)startBackgroundTask
{
    if ([self isMultitaskingSupported] &&
        [self isAppInBackgroundState])
    {
        UIApplication *application = [UIApplication sharedApplication];
        //API 1: iOS4.0
        /**
         *  开启一个后台任务，可以使App退到后台之后继续运行一段时间。
         *  可以开启多个任务，但是必须确保每个被开启的任务在超时前被结束。
         *  用户锁屏之后会封存所有后台任务，包括后台任务时间，待用户在此解锁时继续，如此是为了减少功耗。
         *
         *  handler:超时回调，回调中必须结束任务，否则APP可能会被系统杀掉
         */
        _backTaskIdentifier = [application beginBackgroundTaskWithExpirationHandler:^(){
            
            //超时回调
            [self stopBackgroundTask];
        }];
        
        //API 2: iOS7.0
        /**
         *  name:用于在Debuger中显示，如果设置nil则系统使用方法名做名称
         */
        _backTaskIdentifier = [application beginBackgroundTaskWithName:@"123"
                                                     expirationHandler:^(){
                                                         NSLog(@"BarkgroundTask Time Over!");
                                                         if (![_timer isValid])
                                                         {
                                                             [_timer invalidate];
                                                         }
                                                         
                                                         //超时回调
                                                         [self stopBackgroundTask];
                                                         
                                                     }];
        
        if (_backTaskIdentifier == UIBackgroundTaskInvalid)
        {
            //创建多任务失败，系统可能没有资源能提供开启多任务
            NSLog(@"Begin MutiTask Failed");
        }

        /**
         *  打印已经使用的后台时间
         *  如果在前台调用的话，这个值会非常大
         */
        NSLog(@"Background Max Time:%fs",UIMinimumKeepAliveTimeout);
        NSLog(@"Background Used Time:%fs",[application backgroundTimeRemaining]);
        
        //doSomething...
        [self doBackgroundTask];
    }
    else
    {
        NSLog(@"Did not support mutiTask!");
    }
}

- (void)doBackgroundTask
{
    //doSomething...
    //每分钟输出一次后台任务剩余时间
    _timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(backgroundTimeLeft:) userInfo:nil repeats:YES];
    [_timer fire];
}

- (void)backgroundTimeLeft:(NSTimer *)timer
{
    //APP启动多任务时，该API事件调整为:APP后台任务剩余的是时间。
    NSLog(@"Left Time:%fs",[[UIApplication sharedApplication] backgroundTimeRemaining]);
}

/**
 *  后台任务结束之后 调用此方法通知系统结束自己已经使用完成。
 *  如果不调用则会在超时之后被调用
 */
- (void)stopBackgroundTask
{
    /**
     *  endBackgroundTask必须被调用，最差也是在超时回调中调用。
     *  如果不调用，系统可能会把APP杀掉
     *  If you do not, the system may kill your app.
     */
    [[UIApplication sharedApplication] endBackgroundTask:_backTaskIdentifier];
    _backTaskIdentifier = UIBackgroundTaskInvalid;
}

@end
