//
//  TimerViewController.m
//  XSTestProject
//
//  Created by SAIC_Zhangss on 14-6-5.
//
//

#import "TimerViewController.h"

#define kTimerInterval 10

#define TIMER_SCHEDULE_TYPE 2

@interface TimerViewController ()

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) UILabel *timingLabel;
@property (nonatomic,assign) dispatch_source_t gcdTimer;

@end

@implementation TimerViewController


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
    self.navigationItem.titleView = [XSTestUtils navigationTitleWithString:NSLocalizedString(@"NSTimer Info", @"NSTime介绍")];
    
    self.timingLabel = [[UILabel alloc] init];
    _timingLabel.frame = CGRectMake(VIEW_INTERVAL, VIEW_INTERVAL * 7, self.view.frame.size.width - VIEW_INTERVAL * 2, VIEW_INTERVAL *3);
    _timingLabel.backgroundColor = [UIColor grayColor];
    _timingLabel.numberOfLines = 0;
    _timingLabel.lineBreakMode = UILineBreakModeCharacterWrap;
    _timingLabel.text = @"Timing";
    [self.view addSubview:_timingLabel];
    
    UIButton *btnStart = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnStart.frame = CGRectMake(VIEW_INTERVAL, VIEW_INTERVAL * 10, VIEW_INTERVAL * 2, VIEW_INTERVAL * 2);
    [btnStart setTitle:NSLocalizedString(@"Start", @"开始") forState:UIControlStateNormal];
    [btnStart addTarget:self action:@selector(startTimer) forControlEvents:UIControlEventTouchUpInside];
    [btnStart sizeToFit];
    [self.view addSubview:btnStart];
    
    UIButton *btnReset = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnReset.frame = CGRectMake(VIEW_INTERVAL, VIEW_INTERVAL * 12, VIEW_INTERVAL * 2, VIEW_INTERVAL * 2);
    [btnReset setTitle:NSLocalizedString(@"Reset", @"重置") forState:UIControlStateNormal];
    [btnReset addTarget:self action:@selector(resetTimer) forControlEvents:UIControlEventTouchUpInside];
    [btnReset sizeToFit];
    [self.view addSubview:btnReset];
    
    UIButton *btnStop = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnStop.frame = CGRectMake(VIEW_INTERVAL, VIEW_INTERVAL * 14, VIEW_INTERVAL * 2, VIEW_INTERVAL * 2);
    [btnStop setTitle:NSLocalizedString(@"Stop", @"关闭") forState:UIControlStateNormal];
    [btnStop addTarget:self action:@selector(stopTimer) forControlEvents:UIControlEventTouchUpInside];
    [btnStop sizeToFit];
    [self.view addSubview:btnStop];
}

#pragma mark -
#pragma mark Timer 
- (void)startTimer
{
    NSLog(@"Start:%@",[NSDate date]);
#if (TIMER_SCHEDULE_TYPE == 0)
    [self scheduleTimerOnMainThread];
#elif (TIMER_SCHEDULE_TYPE == 1)
    [self scheduleTimerOnSubThread];
#else
    [self scheduleTimerWithGCD];
#endif
}

- (void)resetTimer
{
    NSLog(@"Reset Timer:%@",[NSDate date]);
#if (TIMER_SCHEDULE_TYPE == 0 || TIMER_SCHEDULE_TYPE == 1)
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:kTimerInterval]];
#else
//    dispatch_time_t timerType = dispatch_walltime(kTimerInterval * NSEC_PER_SEC, 0);
    dispatch_time_t timerType = dispatch_time(DISPATCH_TIME_NOW, kTimerInterval * NSEC_PER_SEC);
    dispatch_source_set_timer(_gcdTimer, timerType, kTimerInterval * NSEC_PER_SEC, 0);
#endif
}

- (void)stopTimer
{
    NSLog(@"Stop:%@",[NSDate date]);
#if (TIMER_SCHEDULE_TYPE == 0 || TIMER_SCHEDULE_TYPE == 1)
    if ([_timer isValid])
    {
        [self.timer invalidate];
        self.timer = nil;
    }
#else
    //暂停
    dispatch_suspend(_gcdTimer);
    //销毁
    dispatch_source_cancel(_gcdTimer);
#endif

}
#pragma mark MainThread
- (void)scheduleTimerOnMainThread
{
    NSLog(@"%s",__func__);
    self.timer = [NSTimer scheduledTimerWithTimeInterval:kTimerInterval target:self selector:@selector(timerMethods) userInfo:nil repeats:YES];
}

#pragma mark SubThread
- (void)scheduleTimerOnSubThread
{
    NSLog(@"%s",__func__);
    [NSThread detachNewThreadSelector:@selector(beginTimer)
                             toTarget:self
                           withObject:nil];
}

- (void)beginTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:kTimerInterval target:self selector:@selector(timerMethods) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    [[NSRunLoop currentRunLoop] run];
}

#pragma mark GCD Thread
- (void)scheduleTimerWithGCD
{
    NSLog(@"%s",__func__);
    //创建定时器 GCD队列
    dispatch_queue_t timerQueue = dispatch_queue_create([@"Timer queue" UTF8String], 0);
    
    //创建定时器资源
    _gcdTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, timerQueue);
    
    //设置定时器参数
//    dispatch_time_t timerType = dispatch_walltime(kTimerInterval * NSEC_PER_SEC, 0);
    //设置timer立即启动，kTimerInterval之后执行第一次
    dispatch_time_t timerType = dispatch_time(DISPATCH_TIME_NOW, kTimerInterval * NSEC_PER_SEC);
    //循环的Timer 每kTimerInterval秒执行一次
//    dispatch_source_set_timer(_gcdTimer, timerType, kTimerInterval * NSEC_PER_SEC, 0);
    //DISPATCH_TIME_FOREVER 表示一直阻塞，只会执行一次的timer
    dispatch_source_set_timer(_gcdTimer, timerType, DISPATCH_TIME_FOREVER, 0);
    
    //回调
    dispatch_source_set_event_handler(_gcdTimer, ^{
        [self timerMethods];
    });
    
    dispatch_source_set_cancel_handler(_gcdTimer, ^{
        [self timerCancel];
    });
    
    //timer 创建的事后是suspended状态，需要启动
    dispatch_resume(_gcdTimer);
}

- (void)timerCancel
{
    NSLog(@"End:%@",[NSDate date]);
}

#pragma mark -
#pragma mark TimerMethods
- (void)timerMethods
{
    NSString *log = [NSString stringWithFormat:@"Timing:%@",[NSDate date]];
    _timingLabel.text = log;
    NSLog(@"%@",[NSThread currentThread]);
    NSLog(@"%@",log);
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

@end
