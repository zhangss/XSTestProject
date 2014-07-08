//
//  XSTestProjectAppDelegate.m
//  XSTestProject
//
//  Created by 张松松 on 12-2-28.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "XSTestProjectAppDelegate.h"

//TabBarController下的几大模块
#import "TestTableViewController.h" //测试列表
#import "TestViewController.h"
#import "GAConfiger.h"
#import "MutiTaskingTester.h"

//#import "MyPrint.h"
//#import "MyLibTwo.h"
#import "TestData.h"
//#import "NCMediator.h"

#define LOCAL_NOTIFICATION
#define REMOTE_NOTIFICATION

@implementation XSTestProjectAppDelegate

@synthesize window;
@synthesize tabbarController;

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

#pragma mark -
#pragma mark dealloc
- (void)dealloc
{
    [tabbarController release];
	[tabbarLabel1 release];
	[tabbarImgV1 release];
    [window release];
    
    [_managedObjectContext release];
    [_managedObjectModel release];
    [_persistentStoreCoordinator release];
    
    [super dealloc];
}


#pragma mark -
#pragma mark Application lifecycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{    
    // Override point for customization after application launch.

    // Add the view controller's view to the window and display.
	[self initTabbarController];
    [self.window addSubview:tabbarController.view];
    [self.window makeKeyAndVisible];
    
    //静态方法
//    [MyPrint printA];
//    [MyLibTwo printB];
//    NCMediator *mediator = [NCMediator sharedInstance];
//    [mediator setTrackingId:@"123"];

    //初始化Tracker
    [[GAConfiger shareInStrance] addAndStartGA];
    
#pragma mark Register Local Notification
#ifdef LOCAL_NOTIFICATION
    self.localNoti = [[LocalNotificationInfo alloc] init];
    //检测是否是本地通知触发了启动
    if (![_localNoti receiveNotificationAppLaunch:launchOptions])
    {
        //注册通知
        [_localNoti registerLocalNotification];
    }
#endif
    
#pragma mark Register Remote Notification
#ifdef REMOTE_NOTIFICATION
    self.remoteNoti = [[RemoteNotificationInfo alloc] init];
    //检测是否是远程通知触发了启动
    [_remoteNoti receiveRemoteNotificationLaunch:launchOptions];
    //注册远程通知
    [_remoteNoti registerRemoteNotification];
#endif
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
    MutiTaskingTester *tester = [[MutiTaskingTester alloc] init];
    [tester startBackgroundTask];
}


- (void)applicationWillEnterForeground:(UIApplication *)application 
{
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application 
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
    
    NSError *error = nil;
    if (_managedObjectContext != nil) {
        if ([_managedObjectContext hasChanges] && ![_managedObjectContext save:&error]) {
            NSAssert(0, @"save changes failed when terminage application!");
        }
    }
    
    /*
     或者这样实现
     [self saveContext];
     */
}

#pragma mark -
#pragma mark Notificaiton Service
#pragma mark Local Notification
//本地通知回调
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    [_localNoti receiveNoticiationDelegate:notification];
}

#pragma mark Remote Notification
//注册远程通知成功回调
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    //处理Token
    [_remoteNoti receiveDeviceToken:deviceToken];
}

//注册远程通知失败回调
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    [_remoteNoti receiveError:error];
}

//接收到APNS通知的回调 iOS3
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [_remoteNoti receiveRemoteNotificationDelegate:userInfo];
}

//接收到APNS通知的回调 iOS7
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [_remoteNoti receiveRemoteNotificationDelegate:userInfo];
}

#pragma mark -
#pragma mark Background Fetch iOS7
- (BOOL)isSupportBackgroundRefresh
{
    /*
     This property reflects whether the app can be launched into the background to handle background behaviors, such as processing background location updates and performing background fetches. If your app relies on being launched into the background to perform tasks, you can use the value of this property to determine if doing so is possible and to warn the user if it is not. Do not warn the user if the value of this property is set to UIBackgroundRefreshStatusRestricted; a restricted user does not have the ability to enable multitasking for the app.
     当用户处在UIBackgroundRefreshStatusRestricted状态下时不应该提示用户
     当处在UIBackgroundRefreshStatusDenied状态时可以提示用户开启后台更新数据
     */
    
    //iOS7
    UIBackgroundRefreshStatus status = [[UIApplication sharedApplication] backgroundRefreshStatus];
    if (status == UIBackgroundRefreshStatusRestricted)
    {
        /*
         Background updates are unavailable and the user cannot enable them again. For example, this status can occur when parental controls are in effect for the current user.
         这种状态下属于设备配置了不支持后台更新的权限。如家长控制了该设备用户权限。
         */
        NSLog(@"UIBackgroundRefreshStatusRestricted");
        return NO;
    }
    else if (status == UIBackgroundRefreshStatusDenied)
    {
        /*
         The user explicitly disabled background behavior for this app or for the whole system.
         用户明确禁止了这个APP或者这个系统不能进行后台更新
         */
        NSLog(@"UIBackgroundRefreshStatusDenied");
        return NO;
    }
    else if (status == UIBackgroundRefreshStatusAvailable)
    {
        /*
         这个APP可以进行后台更新
         */
        NSLog(@"UIBackgroundRefreshStatusAvailable");
        return YES;
    }
    return NO;
}

- (void)setMinimumBackgroundFetchInterval
{
    //iOS7
    /*
     后台获取的意思是:当应用处于后台时，系统会给出一定的时间使APP在后台能够运行一些代码去更新数据刷新UI，这样在用户回到前台之后就能看到最新的数据，增加用户体验。
     配置步骤：
     1.首先是修改应用的Info.plist:在UIBackgroundModes中加入fetch，即可告诉系统应用需要后台获取的权限。另外一种更简单的方式，利用Xcode5的Capabilities特性，打开Capabilities页面下的Background Modes选项，并勾选Background fetch选项即可。注意：依照苹果一贯的做法来看，如果声明了需要某项后台权限，但是结果却没有相关实现的话，被拒掉的可能性还是比较大的。
     2.设置获取时间间隔：这个时间只对设置了UIBackgroundModes的APP生效。默认设置为UIApplicationBackgroundFetchIntervalNever,从不进行后台获取。这里所指定的时间间隔只是代表了“在上一次获取或者关闭应用之后，在这一段时间内一定不会去做后台获取”，而真正具体到什么时候会进行后台获取，系统将根据你的设定，选择比如接收邮件的时候顺便为你的应用获取一下，或者也有可能专门为你的应用唤醒一下设备。作为开发者，我们应该做的是为用户的电池考虑，尽可能地选择合适自己应用的后台获取间隔。设置为UIApplicationBackgroundFetchIntervalMinimum的话，系统会尽可能多尽可能快地 为你的应用进行后台获取，但是比如对于一个天气应用，可能对实时的数据并不会那么关心，就完全不必设置为 UIApplicationBackgroundFetchIntervalMinimum，也许1小时会是一个更好的选择。新的Mac OSX 10.9上已经出现了功耗监测，用于让用户确定什么应用是能耗大户，有理由相信同样的东西也可能出现在iOS上。如果不想让用户因为你的应用是耗电大户而怒删的话，从现在开始注意一下应用的能耗还是蛮有必要的（做绿色环保低碳的iOS app，从今天开始～）。
     */
    if ([self isSupportBackgroundRefresh])
    {
        [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    }
}

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    /**
     *  系统将会在执行fetch的时候调用这个方法，然后开发者需要做的是在这个方法里完成获取的工作，然后刷新UI，并通知系统获取结束，以便系统尽快回到休眠状态。
     *  获取数据这是应用相关的内容，在此不做赘述，应用在前台能完成的工作在这里都能做，唯一的限制是系统不会给你很长时间来做fetch，一般会小于一分钟，而且fetch在绝大多数情况下将和别的应用共用网络连接。这些时间对于fetch一些简单数据来说是足够的了，比如微博的新条目（大图除外），接下来一小时的天气情况等。如果涉及到较大文件的传输的话，用后台获取的API就不合适了，而应该使用另一个新的文件传输的API，我们稍后再说。
     *  类似前面提到的后台任务完成时必须通知系统一样，在在获取完成后，也必须通知系统获取完成，方法是调用-application:performFetchWithCompletionHandler:的handler。这个CompletionHandler接收一个UIBackgroundFetchResult作为参数，可供选择的结果有UIBackgroundFetchResultNewData,UIBackgroundFetchResultNoData,UIBackgroundFetchResultFailed三种，分别表示获取到了新数据（此时系统将对现在的UI状态截图并更新App Switcher中你的应用的截屏），没有新数据，以及获取失败。
     
     *  当然，实际情况中会比这要复杂得多，用户当前的ViewController是否合适做获取，获取后的数据如何处理都需要考虑。另外要说明的是上面的代码在获取成功后直接在appDelegate里更新UI，这只是为了能在同一处进行说明，但却是不正确的结构。比较好的做法是将获取和更新UI的业务 逻辑都放到fetchViewController里，然后向其发送获取消息的时候将completionHandler作为参数传入，并在 fetchViewController里完成获取结束的报告。
     *  另一个比较神奇的地方是系统将追踪用户的使用习惯，并根据对每个应用的使用时刻给一个合理的fetch时间。比如系统将记录你在每天早上9点上班的 电车上，中午12点半吃饭时，以及22点睡觉前会刷一下微博，只要这个习惯持续个三四天，系统便会将应用的后台获取时刻调节为9点，12点和22点前一点。这样在每次你打开应用都直接有最新内容的同时，也节省了电量和流量。
     *
     */
    
    /*
     如何模拟
     1.可以复制一个Run的Scheme，然后勾选Background Fetch，然后运行该Scheme。
     2.可以从Xcode5-Debug-Simulate Background Fetch，模拟完成一次
     */
    
    UINavigationController *navigationController = (UINavigationController*)self.window.rootViewController;
    id fetchViewController = navigationController.topViewController;
    if ([fetchViewController respondsToSelector:@selector(fetchDataResult:)]) {
        [fetchViewController fetchDataResult:^(NSError *error, NSArray *results)
        {
            if (!error)
            {
                if (results.count != 0)
                {
                    //Update UI with results.
                    //Tell system all done.
                    completionHandler(UIBackgroundFetchResultNewData);
                }
                else
                {
                    completionHandler(UIBackgroundFetchResultNoData);
                }
            }
            else
            {
                completionHandler(UIBackgroundFetchResultFailed);
            }
        }];
    }
    else
    {
        completionHandler(UIBackgroundFetchResultFailed);
    }

}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application 
{
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


#pragma mark -
#pragma mark Methods

- (void)initTabbarController 
{
	//初始化控制器TabbarController
	tabbarController = [[UITabBarController alloc] init];
	tabbarController.delegate = self;
	
    //初始化各个模块的控制器
	TestTableViewController *testTableV = [[TestTableViewController alloc] init];
	UINavigationController *testTableVNavi = [[UINavigationController alloc] initWithRootViewController:testTableV];
	testTableVNavi.tabBarItem = [[[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Main",@"") image:nil tag:0] autorelease];
	[testTableV release];
	
	TestViewController *testV = [[TestViewController alloc] init];
	UINavigationController *testVNavi = [[UINavigationController alloc] initWithRootViewController:testV];
	testVNavi.tabBarItem = [[[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Test2",@"") image:nil tag:1] autorelease];
	[testV release];
	
	NSArray *tabbarArray = [[NSArray alloc] initWithObjects:testTableVNavi,testVNavi,nil];
	tabbarController.viewControllers = tabbarArray;
	[tabbarArray release];
    [testVNavi release];
    [testTableVNavi release];
	
    //给导航栏及工具栏添加阴影
	[self addLayerShadowOnNaviAndTab];
	
    //在系统的工具栏上贴图
    //[self customTabBarMethod];
}


- (void)customTabBarMethod 
{
	//整个TabBar换背景图片
	UIImageView *tabBarBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 46)];
	tabBarBG.image = [UIImage imageNamed:@"bg_tabbar"];
	[tabbarController.tabBar addSubview:tabBarBG];
	[tabBarBG release];
	
	//给每个TabBarItem部分附图片 选中现实的图片和Label
	tabbarImgV1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_messages_selected"]];
	tabbarImgV1.frame = CGRectMake(0, -2, 80, 49);
	
	tabbarLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 80, 17)];
	tabbarLabel1.textAlignment = UITextAlignmentCenter;
	tabbarLabel1.text = NSLocalizedString(@"MIX",@"");
	tabbarLabel1.backgroundColor = [UIColor clearColor];
	[tabbarLabel1 labelWithType:kTabBarTitle];
	tabbarLabel1.textColor = [UIColor whiteColor];
	
	[tabbarController.tabBar addSubview:tabbarLabel1];
	[tabbarController.tabBar addSubview:tabbarImgV1];
	
	//同样的道理可以在tabbar上贴未读数图标（ImageV+Label）
	//通过通知、开线程为未读数赋值
	
	/*系统的未读数
	 UITabBarItem* oneboxBar = (UITabBarItem*)[tabBarCtl.tabBar.items objectAtIndex:0];
	 oneboxBar.badgeValue = nil;
	 */
}


- (void)addLayerShadowOnNaviAndTab 
{
    //给导航栏添加阴影
	for (UINavigationController *controller in tabbarController.viewControllers) 
    {
		CALayer *navLayer = controller.navigationBar.layer;
		navLayer.masksToBounds = NO;
		navLayer.shadowColor = [UIColor blackColor].CGColor;
		navLayer.shadowOffset = CGSizeMake(0.0f, 2.0f);
		navLayer.shadowOpacity = 0.5f;
		navLayer.shouldRasterize = YES;
	}
	
    //给标签栏添加阴影
	CALayer *tabLayer = tabbarController.tabBar.layer;
	tabLayer.masksToBounds = NO;
	tabLayer.shadowColor = [UIColor blackColor].CGColor;
	tabLayer.shadowOffset = CGSizeMake(0.0f, -2.0f);
	tabLayer.shadowOpacity = 0.6f;
	tabLayer.shouldRasterize = YES;
}

#pragma mark -
#pragma mark UITabBarControllerDelegate
//测试在什么时候后调用
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
	/*
	if(self.tabBarCtl.selectedIndex==0)
	{
		tabbarImgV1.image = [UIImage imageNamed:@"icon_messages"];
		tabbarLabel1.textColor = [UIColor grayColor];
	}
	else(self.tabBarCtl.selectedIndex==1){
		tabImg2.image = [UIImage imageNamed:@"icon_Contact_on"];
		label2.textColor = [UIColor grayColor];
	}*/
	return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
	/*
	if(self.tabBarCtl.selectedIndex==0)
	{
		tabImg1.image = [UIImage imageNamed:@"icon_messages_selected"];
		label1.textColor = [UIColor whiteColor];
	}
	else(self.tabBarCtl.selectedIndex==1){
		tabImg2.image = [UIImage imageNamed:@"icon_Contact_on_selected"];
		label2.textColor = [UIColor whiteColor];
	}*/
}

#pragma mark -
#pragma mark CoreData Methods
- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack
/*
 Managed Object Context 参与对数据对象进行操作的全过程，检查数据对象的变化，进行对数据的增删改查等。
 */
// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

/*
 Managed Object Model 应用程序的数据模型，包括实体Entity，属性Property及查询请求FethcRequest等
 */
// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    /*
     //从本地所有的xcdatamodeld文件中获取这个coredata数据模板
    _managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];
    return _managedObjectModel;
     */
     
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"XSTestModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

/*
 Persistent Stroe Coordinator数据文件管理器,处理底层的对数据的存储和读写等。
 */
// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"XSTestModel.sqlite"]; //数据库的名字
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        /*
         //此处可换成增加断言
         NSAssert(0, @"persistentStoreCoordinator init failed!");
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    
    //Path1 此处这样实现 路径1/2基本上差不多
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSLog(@"Data Base:Path1 %@",basePath);
    
    //Path2
    NSURL *basePath2 = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSLog(@"Data Base:Path2 %@",basePath2);
    return basePath2;
}


//- (NSManagedObjectContext *) managedObjectContext{
//    if(_managedObjectContext == nil){
//        
//        //1.首先获取存储文件（或数据库文件）存放位置，这里设置为App的Document目录下，存储文件（或数据库文件）为ShoppingCar Database。
//        NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
//                                                             inDomains:NSUserDomainMask] lastObject];
//        NSURL *storeDatabaseURL = [url URLByAppendingPathComponent:@"ShoppingCart.sqlite"];
//        // 设置SQLite 数据库存储路径 /ShoppingCart.sqlite
//        NSError *error = nil;
//        
//        //2.创建NSPersistentStoreCoordinator 对象，指定存储类型（SQLite数据库）和存储路径
//        //根据被管理对象模型创建NSPersistentStoreCoordinator 对象实例
//        NSPersistentStoreCoordinator *persistentStoreCoordinator =
//        [[NSPersistentStoreCoordinator alloc]
//         initWithManagedObjectModel:[NSManagedObjectModel mergedModelFromBundles:nil]];
//        
//        //根据指定的存储类型和路径，创建一个新的持久化存储（Persistent Store）
//        if(![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
//                                                     configuration:nil
//                                                               URL:storeDatabaseURL options:nil error:&error])
//        {
//            NSLog(@"Error while loading persistent store ...%@", error);
//        }
//        
//        //3.实例化被管理对象上下文（Managed Object Context），并赋值其持久化存储协调器
//        _managedObjectContext = [[NSManagedObjectContext alloc] init];
//        
//        //设置当前被管理对象上下文的持久化存储协调器
//        [_managedObjectContext setPersistentStoreCoordinator:persistentStoreCoordinator]; }
//    
//    // 返回初始化的被管理对象上下文实例
//    return _managedObjectContext;
//}

#pragma mark CoreData Operate Add/Delete/Search/Modify
// 向SQLite插入一些初始数据 供测试用途
- (void) addEntity{
    // 创建Person 被管理对象实例
    /*
     1.获取ManagedObjectContext
     2.利用NSEntityDescription生成NSManagedObject对象
     3.然后对对象做操作后调用ManagedObjectContext进行保存
     */
    TestData *testData1 = (TestData *)[NSEntityDescription insertNewObjectForEntityForName:@"TestData"
                                                                    inManagedObjectContext:_managedObjectContext];
    
    testData1.title = @"1";
    testData1.subTitle = @"I am One!";
    testData1.creatTime = [NSDate dateWithTimeInterval:1 sinceDate:[NSDate date]];
    
    TestData *testData2 = (TestData *)[NSEntityDescription insertNewObjectForEntityForName:@"TestData"
                                                                    inManagedObjectContext:_managedObjectContext];
    
    testData2.title = @"2";
    testData2.subTitle = @"I am Two!";
    testData2.creatTime = [NSDate dateWithTimeInterval:10 sinceDate:[NSDate date]];

    
    TestData *testData3 = (TestData *)[NSEntityDescription insertNewObjectForEntityForName:@"TestData"
                                                                    inManagedObjectContext:_managedObjectContext];
    
    testData3.title = @"3";
    testData3.subTitle = @"I am Three!";
    testData3.creatTime = [NSDate dateWithTimeInterval:100 sinceDate:[NSDate date]];

    
    // 保存数据，持久化存储 SQLite数据库
    // 开发测试的时候，可以把下面的代码注释掉，分析比较一下
    /*if([self.managedObjectContext hasChanges]){
     [self.managedObjectContext save:nil];
     }*/
    NSError *error = nil;
    if ([_managedObjectContext save:&error])
    {
        NSLog(@"%@",error);
    }
}



// 显示SQLite 数据库，购物车中的内容
// 查询功能
- (NSArray *) getEntity
{
    // NSFetchRequest 对象用来检索数据
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    // 根据指定Entity名称和被管理对象上下文，创建NSEntityDescription对象，
    NSEntityDescription *myEntityQuery = [NSEntityDescription
                                          entityForName:@"TestData"
                                          inManagedObjectContext:_managedObjectContext];
    // 指定实体
    [request setEntity:myEntityQuery];
    
    //排序
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"creatTime" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [request setSortDescriptors:sortDescriptors];
    [sortDescriptors release];
    [sortDescriptor release];

    NSError *error = nil;
    // 返回符合查询条件NSFetchRequest的记录数组
    NSArray *personArr = [self.managedObjectContext executeFetchRequest:request error:&error];
    NSLog(@"%@",personArr);
    [request release];
    return personArr;
}

- (void)deleteEntity:(NSManagedObject *)aEntity
{
    [_managedObjectContext deleteObject:aEntity];
    NSError *error = nil;
    if (![_managedObjectContext save:&error]) {
        //handle error
    }
}

@end
