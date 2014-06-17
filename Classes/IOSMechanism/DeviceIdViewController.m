//
//  DeviceIdViewController.m
//  XSTestProject
//
//  Created by SAIC_Zhangss on 14-6-16.
//
//

#import "DeviceIdViewController.h"
#import <AdSupport/AdSupport.h>

@interface DeviceIdViewController ()

@end

@implementation DeviceIdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/**
 *  与CFUUID原理相同，只是使用OC封装了一下而已
 *
 *  @return uuid
 */
- (NSString *)uuidNS
{
    NSString *result = [[NSUUID UUID] UUIDString];
    return result;
}

/**
 *  生成UUID
 *  1.每次调用CFUUIDCreate就会创建一个新的UUID
 *  2.创建的UUID需要用户自己保存，可以保存到沙盒、UserDefault或者钥匙串中
 *  3.删除应用之后，除非保存到钥匙串中，否则不可恢复。
 *
 *  @return
 */
- (NSString *)uuidCF
{
//    CFUUIDRef puuid = CFUUIDCreate(kCFAllocatorDefault);
//    NSString *result = (NSString*)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, puuid));
    
    CFUUIDRef puuid = CFUUIDCreate(nil);
    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
    NSString *result = (NSString *)CFStringCreateCopy(NULL, uuidString);
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

/**
 *  获取厂商id
 *  1.同一个APP每次获取都是相同的
 *  2.同一个设备上具有相同Vendor的APP获取到的都是相同的
 *  3.Vendor是指bundleid的前两部分如com.test.app中的com.test，表示同一个提供商
 *  4.如果同一个设备上所有具有相同vendor的应用，有一个被删除或者被新安装，id会重置。
 *  5.id重置之后，只有当应用重新启动并获取是才会更新。
 *
 *  @return
 */
- (NSString *)vendorId
{
    NSString *idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    return idfv;
}


- (NSString *)advertisementId
{
    NSString *idfa = nil;
    //检查用户是否禁用了广告追踪服务
    if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled])
    {
        /**
         *  此id推荐使用在统计广告次数、转换事件？、用户量统计、安全和欺诈行为检测和调测。
         */
        idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    }
    else
    {
        NSLog(@"User deny of AdvertisingTracking!");
    }
    return idfa;
}

@end
