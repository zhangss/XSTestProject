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

//#import "MyPrint.h"
//#import "MyLibTwo.h"
#import "TestData.h"
//#import "NCMediator.h"

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
