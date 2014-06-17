//
//  XSTestProjectAppDelegate.h
//  XSTestProject
//
//  Created by 张松松 on 12-2-28.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocalNotificationInfo.h"
#import "RemoteNotificationInfo.h"

@interface XSTestProjectAppDelegate : NSObject <UIApplicationDelegate,UITabBarControllerDelegate> {
    UIWindow *window;
	UITabBarController *tabbarController;
	
	/*Tabbar上面贴图片 及文字*/
	UIImageView *tabbarImgV1;
	UILabel     *tabbarLabel1;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UITabBarController *tabbarController;
@property (nonatomic, strong) LocalNotificationInfo *localNoti;
@property (nonatomic, strong) RemoteNotificationInfo *remoteNoti;

//初始化TabBar控制器
- (void)initTabbarController;

//给导航栏及Tabbar添加阴影
- (void)addLayerShadowOnNaviAndTab;

//系统的Tabbar上贴图片
- (void)customTabBarMethod;

#pragma mark -
#pragma mark CoreData 
@property (readonly, retain, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, retain, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, retain, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (NSArray *)getEntity;
//***End***

@end

