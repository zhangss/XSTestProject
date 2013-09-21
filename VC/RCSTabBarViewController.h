//
//  RCSTabBarViewController.h
//  Megafon
//
//  Created by yafeng on 12-4-2.
//  Copyright (c) 2012年 广州市易杰数码科技有限公司. All rights reserved.
//

#import "RCSTabBar.h"
#import "AllServiceDefine.h"
#import "RCSNavigationController.h"

#define SELECTED_VIEW_CONTROLLER_TAG 98456345
#define HEIGHT_TABBAR 49.0
#define HEIGHT_NAVBAR 44.0
#define HEIGHT_STATEBAR 20.0
#define kTriggerOffSet 100.0f
#define RCSNavigatinonControllerOriginY 20

@class ConversationListViewCtl;
@class AllServicesViewController;
@class SNSViewController;

@interface RCSTabBarViewController : BaseController
<RCSTabBarDelegate,
UINavigationControllerDelegate,
UIGestureRecognizerDelegate>
{
	RCSTabBar* tabBar;
    NSMutableArray *tabBarItems;
}
@property (nonatomic, retain) RCSTabBar *tabBar;
@property (nonatomic, assign) NSUInteger currentIndex;  // 当前显示的viewController的index
@property (nonatomic ,assign) BOOL isDealTouch;
@property (nonatomic, retain) UIViewController *mixShowViewController; // 展示内容的viewcontroller
@property (nonatomic, retain) RCSNavigationController *showNavigationController; // rootview为showViewController
@property (nonatomic, retain) AllServicesViewController *leftViewController;
@property (nonatomic, assign) CGPoint touchBeganPoint;
@property (nonatomic, assign) BOOL isOutOfStage;    // 是否已经左移
@property (nonatomic, retain) ConversationListViewCtl *conversationListViewController;//为了缓存会话界面
@property (nonatomic ,retain) SNSViewController *snsViewController;//为了缓存SNS界面
@property (nonatomic ,retain) UIView *overView;

- (void)changeViewWithViewController:(UIViewController *)vc title:(NSString *)title;
- (void)leftBarBtnTapped:(id)sender;
- (void)addSwipeGestureForView:(UIView *)theView;
- (void)initFirstTouchDownAtItemAtIndex:(NSUInteger)itemIndex;
- (void)touchDownAtItemAtIndex:(NSUInteger)itemIndex;
- (BOOL)addViewControllerWithDictionary:(NSDictionary *)dictViewController;
//更新TabBar上的未读数量(MIX模块的)
- (void) updateMIXUnReadCountNotification;
- (void)hideSelfDefineTabBarWhenPushViewController;
- (void)showSelfDefineTabBarWhenPopToRootViewController;
- (void)changeSelfDefineTabBar:(BOOL)isHide isAnimate:(BOOL)animate;
- (BOOL)isSelfDefineTabBarHidden;
- (void)resetNavigationControllerFrame;
- (void)scrollCurrentViewToTop;
- (void)presentMainViewAfterLogin;
- (void)removeViewAfterLoginOut;
@end

