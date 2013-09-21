//
//  GAConfiger.m
//  XSTestProject
//
//  Created by 张松松 on 13-8-1.
//
//

/*
  GA单例
 */

#import "GAConfiger.h"
#import "GAI.h"

#define kTrackerID @"UA-42881193-1"

@interface GAConfiger ()

@end

@implementation GAConfiger

@synthesize tracker;

#pragma mark -
#pragma mark Singleton 单例模式
/*
 单例四部曲:
 1.设置一个静态实例,初始化为nil
 2.实现一个实例构造方法,生成或者返回实例
 3.重写allocWithZone方法,防止使用其他方法创建实例
 4.适当的实现allocWithZone,copyWithZone,release,autoRelease,retain,retainCount,dealloc等方法.
 
 单例的两种模式 1.空间优先，单例在需要使用的时候才创建，节省空间
              2.时间优先，单例在程序启动时就生成好了，以后不需要考虑是否需要创建，直接访问获取单例。
*/

//获取单例，有必要的话则创建一个
static GAConfiger *gaConfiger = nil;
+ (GAConfiger *)shareInStrance
{
    //双重判断，同步锁会影响访问时间，那么判断一下，然后需要的时候在同步锁，然后在判断创建对象会减少同步锁浪费的时间
    if (gaConfiger == nil)
    {
        //同步互斥锁 现在内部代码在单线程中执行，如果其他的线程需要访问则需等待
        @synchronized(self)
        {
            if (gaConfiger == nil)
            {
                gaConfiger = [[GAConfiger alloc] init];
                //???:不可以使用self 调用
                //不能在这儿 初始化 有问题会报错
//                [gaConfiger addAndStartGA];
            }
        }
    }
    return gaConfiger;
}

//重载此方法，此方法是从制定的区域内读取信息创建实例，禁止它则禁止使用其他方法创建单例
+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (gaConfiger == nil)
        {
            gaConfiger = [super allocWithZone:zone];
            return gaConfiger;
        }
    }
    return  nil;
}

//单例初始化时会调用这个方法，初始化一些东西
- (id)init
{
    self = [super init];
    if (self)
    {
        //初始化一些东西
    }
    return self;
}

//这个方法永远不会被调用，应为单例一直存在在内存中，直到程序结束
- (void)dealloc
{
    [super dealloc];
}

//重载此方法同样避免生成多个单例拷贝
+ (id)copyWithZone:(NSZone *)zone
{
    return self;
}

//什么也不做 单例不需要retain，也无需引用计数
- (id)retain
{
    return self;
}

//替换掉引用计数 这样永远都不会release这个单例
- (NSUInteger)retainCount
{
    return NSUIntegerMax;
}

//方法为空 不希望release掉这个单例
- (oneway void)release
{

}

//自动释放返回自己 什么也不做，不希望release
- (id)autorelease
{
    return self;
}

#pragma mark -
#pragma mark Google Analytics
- (void)addAndStartGA
{
#pragma mark GAI 部分设置
    //获取GAI单例
    GAI *gai = [GAI sharedInstance];
    //设置是否捕获异常程序
    gai.trackUncaughtExceptions = YES;
    
    /*
     设置捕获信息的频率
     负数则表示 不会自动捕获并上传给GA
     0 标示立即上传
     正数 标示每个多少S上传一次
     默认120S
     */
    gai.dispatchInterval = 120.0;
    
    /*
     是否需要打印日志在Consonle中
     默认NO;
     */
    gai.debug = NO;
    
    /*
     是否停止向GA发送数据
     YES 停止向GA发送数据
     NO  不停止
     默认时NO;
     */
    gai.optOut = NO;
    
    /*
     如果特殊情况要手动POST消息到GA（如异常退出时或退出应该前要保存一次到GA），直接调用dispatch方法。
     */
    //[gai dispatch];

    /*
     当前GA的版本号及产品?
     */
    NSLog(@"kGAIProduct:%@",kGAIProduct);
    NSLog(@"kGAIVersion:%@",kGAIVersion);
    
    /*
     GA SDK返回错误的时候(NSError)肯能包含这个字段，用以标示错误信息
     */
    NSLog(@"kGAIErrorDomain:%@",kGAIErrorDomain);
    
    /*
     获取设置Tracker 跟踪检测者 需要trackerID
     1.trackerID不能为空
     2.没必要retain这个tracker,Libray库会retain它
     3.如果发生错误或者trackerID有问题则会返回nil,会造成崩溃
     */
    tracker = [gai trackerWithTrackingId:kTrackerID];
    
#pragma mark GATraker 部分设置
    tracker.appName = @"XSTest";
    tracker.appId = @"com.easier.test";
    tracker.appVersion = @"0.9.0.1";
    //是否匿名被采样者IP 默认false
    tracker.anonymize = NO;
    //是否使用https协议 默认True
    tracker.useHttps = YES;
    //被采样的比例，如果不在比例范围内的用户不会被提交任何信息
    tracker.sampleRate = 100.0;
    //客户端进入后台多长时间之后 开始一个新的采集任务
    tracker.sessionTimeout = 10*60;
        
    //Tracking ID 和 Client ID
    NSLog(@"trackingId:%@",tracker.trackingId);
    NSLog(@"clientId:%@",tracker.clientId);
}

/******************************************************************************
 函数名称 : addGATrackerWithCategory:...
 函数描述 : 增加GA监测点
 输入参数 : 类别，行为名称等
 输出参数 : 无
 返回值 : 无
 备注 :
 添加人:
 ******************************************************************************/
- (void)addGATrackerWithCategory:(NSString *)category
                      withAction:(NSString *)action
                       withLabel:(NSString *)label
                       withValue:(NSNumber *)value
{
    BOOL isSuccess = [tracker sendEventWithCategory:category withAction:action withLabel:label withValue:value];
    if (!isSuccess)
    {
        NSLog(@"GA Failed");
    }
}

//检测用户操作的时间
- (BOOL)sendGATimingWithCategory:(NSString *)category
                       withValue:(NSTimeInterval)time
                        withName:(NSString *)name
                       withLabel:(NSString *)label
{
    BOOL isSuccess = [tracker sendTimingWithCategory:category withValue:time withName:name withLabel:label];
    if (!isSuccess)
    {
        NSLog(@"GA Failed");
    }
    return isSuccess;
}

@end
