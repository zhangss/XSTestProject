//
//  ReachabilityViewController.m
//  XSTestProject
//
//  Created by SAIC_Zhangss on 14-7-22.
//
//

#import "ReachabilityViewController.h"
#import "XSReachability.h"

@interface ReachabilityViewController ()

@property (nonatomic,strong) XSReachability *hostReachability;
@property (nonatomic,strong) XSReachability *internetReachability;
@property (nonatomic,strong) XSReachability *wifiReachability;

@end

@implementation ReachabilityViewController

#pragma mark -
#pragma mark Reachability
- (void)addNetworkReachabilityInspector
{
    if (_hostReachability == nil)
    {
        //检测特定Host，模拟器测试不准确，不建议使用
        self.hostReachability = [XSReachability reachabilityWithHostName:@"www.baidu.com"];
        //register notification
        if ([_hostReachability startNotifier])
        {
        }
        
        //检测网络，建议使用，不过模拟器测试貌似也有BUG
        self.internetReachability = [XSReachability reachabilityForInternetConnection];
        if ([_internetReachability startNotifier]) {
        }
        
        //检测本地WIFI,本地WIFI开关关闭之后永远返回不通
        self.wifiReachability = [XSReachability reachabilityForLocalWiFi];
        if ([_wifiReachability startNotifier]){
        }
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStateDidChange:) name:kReachabilityChangedNotification object:nil];
    }
}

- (void)networkStateDidChange:(NSNotification *)noti
{
    NSLog(@"Network Change");
    if ([[noti object] isKindOfClass:[XSReachability class]])
    {
        //make sure that is Mugo Notification
        XSReachability *reachability = (XSReachability *)noti.object;
        if (_hostReachability == reachability) {
            NSLog(@"Host");
        }
        else if (_internetReachability == reachability)
        {
            NSLog(@"Internet");
        }
        else if (_wifiReachability == reachability)
        {
            NSLog(@"WIFI");
        }
        else
        {
            NSLog(@"Other");
        }
        NetworkStatus status = reachability.currentReachabilityStatus;
        BOOL connectionRequired = reachability.connectionRequired;
        NSLog(@"connectionRequired:%@",connectionRequired ? @"YES" : @"NO");
        switch (status) {
            case NotReachable:
            {
                NSLog(@"Network NoReachable");
                break;
            }
            case ReachableViaWiFi:
            {
                NSLog(@"Network WIFI");
                //network change restart.
                break;
            }
            case ReachableViaWWAN:
            {
                NSLog(@"Network WWAN");
                //network change restart.
                break;
            }
            default:
                break;
        }
    }
}

@end
