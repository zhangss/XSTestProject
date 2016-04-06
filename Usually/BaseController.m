    //
//  BaseController.m
//  XSTestProject
//
//  Created by 张松松 on 12-2-28.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseController.h"
#import "GAConfiger.h"

static NSMutableDictionary *timmingDic = nil;

@implementation BaseController

//抛出的通知 修改为换肤所用的图片
- (void)updateTheme:(id)notification {
	NSDictionary *themeInfo = nil;
	
	//手动调用
	if ([notification isKindOfClass:[NSDictionary class]]) {
		themeInfo = notification;
	}//通知调用方法
	else if ([notification isKindOfClass:[NSNotification class]]) {
		themeInfo = [notification object];
	}
	
	if (themeInfo == nil) {
		//UIImage *image = [UIImage imageNamed:DEFAULT_NAVIGATION_BG];
		//self.navigationController.navigationBar.tintColor = DEFAULT_NAVIGATION_COLOR;
		//self.navigationController.navigationBar.layer.contents = (id)image.CGImage;	
	}else {
		//UIImage *image = [UIImage imageNamed:[themeInfo objectForKey:@"navigationBar"]];
		//self.navigationController.navigationBar.tintColor = [themeInfo objectForKey:@"navigationColor"];
		//self.navigationController.navigationBar.layer.contents = (id)image.CGImage;	
	}
}

- (void)loadView {
	[super loadView];
	//注册观察者
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTheme:) name:kThemeDidChangeNotification object:nil];
	
	//LoadView的时候 显示换肤结果
	NSString *themeName = [ThemeManager sharedInstance].currentTheme;
	NSDictionary *dict = [[ThemeManager sharedInstance] getThemeContent:themeName];
	[self updateTheme:dict];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *className = NSStringFromClass([self class]);
    if (nil == timmingDic)
    {
        timmingDic = [[NSMutableDictionary alloc] init];
    }
    NSDate *nowDate = [NSDate date];
    [timmingDic setObject:nowDate forKey:className];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];    
    NSString *className = NSStringFromClass([self class]);
//    //在缓存字典中查找该类的页面名称
//    NSString *formatName = [[RCSLogicData globalData] getFormatNameForVCWithClassName:className];
//    
//    if (nil != formatName)
//    {
//        self.trackedViewName = formatName;
//    }
//    else
//    self.tracker = [GAConfiger shareInStrance].tracker;
    if (className.length > 0)
    {
        self.screenName = className;
    }
    else
    {
        self.screenName = @"something";
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //***Begin*** [项目中每个页面展现均需要发送通知GA] add by zhangss 2013-7-31
    NSString *className = NSStringFromClass([self class]);
    NSDate *nowDate = [timmingDic objectForKey:className];
    //    [nowDate release];
    //    [nowDate release];
    
    if (nil == nowDate)
    {
        return;
    }
    
    NSDate *sendDate = [NSDate date];
    NSTimeInterval sendTime = [sendDate timeIntervalSinceDate:nowDate];
    //    NSString *formatSendTime = [lastDate description];
    NSString *tmpString = [NSString stringWithFormat:@"%.2f",sendTime];
    CGFloat time = [tmpString floatValue];
    [[GAConfiger shareInStrance] sendGATimingWithCategory:@"AppElementLoading" withValue:time withName:className withLabel:nil];
    [timmingDic removeObjectForKey:className];
    //***End*** [项目中每个页面展现均需要发送通知GA] add by zhangss 2013-7-31
}

- (void)viewDidUnload {
    [super viewDidUnload];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangeNotification object:nil];
}


- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangeNotification object:nil];
    [super dealloc];
}

@end
