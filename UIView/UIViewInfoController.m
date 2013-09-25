    //
//  UIViewInfoController.m
//  XSTestProject
//
//  Created by 张永亮 on 12-11-24.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "UIViewInfoController.h"

#import "UIlabelInfoViewController.h"
#import "UIImageViewInfoViewController.h"
#import "UIRefreshControlInfoViewController.h"
#import "UICollectionViewInfoViewController.h"
#import "UITransitionViewController.h"
#import "ImageSplitViewController.h"
#import "UIKeyBordViewController.h"
#import "AssetsLibraryViewController.h"
#import "UIWebViewController.h"

@implementation UIViewInfoController

#pragma mark -
#pragma mark Init
- (id)init
{
    self = [super init];
    if (self)
    {
        m_tableData = [[NSMutableArray alloc] init];
        
        //UILabel
        NSString *tmpStr = [NSString stringWithString:NSLocalizedString(@"UILabel Info",@"")];
        [m_tableData addObject:tmpStr];
        
        //UIImageView
        tmpStr = [NSString stringWithString:NSLocalizedString(@"UIImageView Info",@"")];
        [m_tableData addObject:tmpStr];
        
        //UIRefreshControl
        tmpStr = [NSString stringWithString:NSLocalizedString(@"UIRefreshControl Info -- IOS6",@"")];
        [m_tableData addObject:tmpStr];
        
        //UICollectionView
        tmpStr = [NSString stringWithString:NSLocalizedString(@"UICollectionView Info -- IOS6",@"")];
        [m_tableData addObject:tmpStr];
        
        //UITransitionStyle
        tmpStr = [NSString stringWithString:NSLocalizedString(@"UITransitionStyle",@"")];
        [m_tableData addObject:tmpStr];
        
        //图片从中间裂开效果
        tmpStr = [NSString stringWithString:NSLocalizedString(@"Split Image",@"")];
        [m_tableData addObject:tmpStr];
        
        //键盘相关
        tmpStr = [NSString stringWithString:NSLocalizedString(@"UIKeyboard",@"")];
        [m_tableData addObject:tmpStr];
        
        //照片选择
        tmpStr = [NSString stringWithString:NSLocalizedString(@"AssertsLibrary",@"")];
        [m_tableData addObject:tmpStr];
        
        tmpStr = [NSString stringWithString:NSLocalizedString(@"UIWebView",@"")];
        [m_tableData addObject:tmpStr];
    }
    return self;
}

- (void)dealloc
{
    [m_tableData release];
    [super dealloc];
}

#pragma mark - 
#pragma mark Lief Cycle
/*
 This is the designated initializer for this class.
 
 The nib file you specify is not loaded right away. It is loaded the first time the view controller’s view is accessed. If you want to perform additional initialization after the nib file is loaded, override the viewDidLoad method and perform your tasks there.
 
 If you specify nil for the nibName parameter and you do not override the loadView method, the view controller searches for a nib file using other means. See nibName.
 
 If your app uses a storyboard to define a view controller and its associated views, your app never initializes objects of that class directly. Instead, view controllers are either instantiated by the storyboard—either automatically by iOS when a segue is triggered or programmatically when your app calls the storyboard object’s instantiateViewControllerWithIdentifier: method. When instantiating a view controller from a storyboard, iOS initializes the new view controller by calling its initWithCoder: method instead. iOS automatically sets the nibName property to a nib file stored inside the storyboard.
 
 For more information about how a view controller loads its view, see “The View Controller Life Cycle”.
 但是此时本视图中的控件都没有添加到视图中，此时通过IBoult关联的IB控件值为空。
 建议这个方法中，可以添加一些数据的添加和下载。
 */
#pragma mark - - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;


/*
 Creates the view that the controller manages.
 
 You should never call this method directly. The view controller calls this method when its view property is requested but is currently nil. This method loads or creates a view and assigns it to the view property.
 
 If the view controller has an associated nib file, this method loads the view from the nib file. A view controller has an associated nib file if the nibName property returns a non-nil value, which occurs if the view controller was instantiated from a storyboard, if you explicitly assigned it a nib file using the initWithNibName:bundle: method, or if iOS finds a nib file in the app bundle with a name based on the view controller’s class name. If the view controller does not have an associated nib file, this method creates a plain UIView object instead.
 
 If you use Interface Builder to create your views and initialize the view controller, you must not override this method.
 
 You can override this method in order to create your views manually. If you choose to do so, assign the root view of your view hierarchy to the view property. The views you create should be unique instances and should not be shared with any other view controller object. Your custom implementation of this method should not call super.
 
 If you want to perform any additional initialization of your views, do so in the viewDidLoad method.
 */
// This is where subclasses should create their custom view hierarchy if they aren't using a nib. Should never be called directly.
#pragma mark - - (void)loadView;


/*
 Called after the controller’s view is loaded into memory.
 This method is called after the view controller has loaded its view hierarchy into memory. This method is called regardless of whether the view hierarchy was loaded from a nib file or created programmatically in the loadView method. You usually override this method to perform additional initialization on views that were loaded from nib files.
 */
// Called after the view has been loaded. For view controllers created in code, this is after -loadView. For view controllers unarchived from a nib, this is after the view is set.
//此方法在ViewController实例中的view被加载完毕后调用，如需要重定义某些要在View加载后立刻执行的动作或者界面修改，则应把代码写在此函数中。
#pragma mark - - (void)viewDidLoad;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.titleView = [XSTestUtils navigationTitleWithString:NSLocalizedString(@"UIlabel Info",@"")];
    
    UITableView *myTableV = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    myTableV.dataSource = self;
    myTableV.delegate = self;
    [self.view addSubview:myTableV];
    [myTableV release];
}


/*
 Notifies the view controller that its view is about to be added to a view hierarchy.
 
 This method is called before the receiver’s view is about to be added to a view hierarchy and before any animations are configured for showing the view. You can override this method to perform custom tasks associated with displaying the view. For example, you might use this method to change the orientation or style of the status bar to coordinate with the orientation or style of the view being presented. If you override this method, you must call super at some point in your implementation.
 
 If a view controller is presented by a view controller inside of a popover, this method is not invoked on the presenting view controller after the presented controller is dismissed.
 */
// Called when the view is about to made visible. Default does nothing
#pragma mark - - (void)viewWillAppear:(BOOL)animated;


/*
 Notifies the view controller that its view was added to a view hierarchy.
 You can override this method to perform additional tasks associated with presenting the view. If you override this method, you must call super at some point in your implementation.
 
 If a view controller is presented by a view controller inside of a popover, this method is not invoked on the presenting view controller after the presented controller is dismissed.
 */
// Called when the view has been fully transitioned onto the screen. Default does nothing
#pragma mark - - (void)viewDidAppear:(BOOL)animated;


/*
 Notifies the view controller that its view is about to be removed from a view hierarchy.
 
 This method is called in response to a view being removed from a view hierarchy. This method is called before the view is actually removed and before any animations are configured.
 
 Subclasses can override this method and use it to commit editing changes, resign the first responder status of the view, or perform other relevant tasks. For example, you might use this method to revert changes to the orientation or style of the status bar that were made in the viewDidDisappear: method when the view was first presented. If you override this method, you must call super at some point in your implementation.
 */
// Called when the view is dismissed, covered or otherwise hidden. Default does nothing
#pragma mark - - (void)viewWillDisappear:(BOOL)animated;


/*
 Notifies the view controller that its view was removed from a view hierarchy.
 
 You can override this method to perform additional tasks associated with dismissing or hiding the view. If you override this method, you must call super at some point in your implementation.
 */
// Called after the view was dismissed, covered or otherwise hidden. Default does nothing
#pragma mark - - (void)viewDidDisappear:(BOOL)animated;

/*
 Returns a Boolean value indicating whether the view is currently loaded into memory.
 Calling this method reports whether the view is loaded. Unlike the view property, it does not attempt to load the view if it is not already in memory.
 */
#pragma mark - - (BOOL)isViewLoaded NS_AVAILABLE_IOS(3_0);

/*
 Notifies the view controller that its view is about to layout its subviews.
 When a view’s bounds change, the view adjusts the position of its subviews. Your view controller can override this method to make changes before the view lays out its subviews. The default implementation of this method does nothing.
 */
// Called just before the view controller's view's layoutSubviews method is invoked. Subclasses can implement as necessary. The default is a nop.
#pragma mark - - (void)viewWillLayoutSubviews NS_AVAILABLE_IOS(5_0);


/*
 Notifies the view controller that its view just laid out its subviews.
 When a view’s bounds change, the view adjusts the position of its subviews. Your view controller can override this method to make changes after the view lays out its subviews. The default implementation of this method does nothing.
 */
// Called just after the view controller's view's layoutSubviews method is invoked. Subclasses can implement as necessary. The default is a nop.
#pragma mark - - (void)viewDidLayoutSubviews NS_AVAILABLE_IOS(5_0);

/*
 Sent to the view controller when the app receives a memory warning.
 Your app never calls this method directly. Instead, this method is called when the system determines that the amount of available memory is low.
 You can override this method to release any additional memory used by your view controller. If you do, your implementation of this method must call the super implementation at some point.
 */
// Called when the parent application receives a memory warning. On iOS 6.0 it will no longer clear the view by default.
#pragma mark - - (void)didReceiveMemoryWarning;
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

/*
 Called just before releasing the controller’s view from memory.
 
 When a low-memory condition occurs and the current view controller’s views are not needed, the system may opt to remove those views from memory. This method is called prior to releasing the actual views so you can perform any cleanup prior to the view being deallocated. For example, you might use this method to remove views as observers of notifications or record the state of the views so it can be reestablished when the views are reloaded.
 
 At the time this method is called, the view property is still valid (it has not yet been set to nil).
 此方法在ViewControll实例中的View被卸载完毕后调用，如需要重定义某些要在View卸载后立刻执行的动作或者释放的内存等动作，则应把代码写在此函数中。
 
 当出现内存警告的时候，是调用正在显示的视图控制器的父视图控制器的viewdidUnload方法，而不是正在显示的视图控制器的viewDidUnload方法。因为如果调用了正在显示的视图控制器的viewDidUnload方法，那么用户正在看的界面就会消失，虽然释放了内存但是用户显然没法接受，自然要释放该视图下面看不到的视图控制器中的视图。被释放的视图，下次加载的时候再调用viewDidLoad的方法，所以ViewDidUnload的方法是和viewDidload方法相互对应的。
 */
#pragma mark - - (void)viewDidUnload;
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


/*
 Called when the controller’s view is released from memory.
 
 When a low-memory condition occurs and the current view controller’s views are not needed, the system may opt to remove those views from memory. This method is called after the view controller’s view has been released and is your chance to perform any final cleanup. If your view controller stores separate references to the view or its subviews, you should use this method to release those references. You can also use this method to remove references to any objects that you created to support the view but that are no longer needed now that the view is gone. You should not use this method to release user data or any other information that cannot be easily recreated.
 
 At the time this method is called, the view property is nil.
 */
#pragma mark - - (void)viewDidUnload NS_DEPRECATED_IOS(3_0,6_0); // Called after the view controller's view is released and set to nil. For example, a memory warning which causes the view to be purged. Not invoked as a result of -dealloc.

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [m_tableData count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [m_tableData objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark -
#pragma mark Device Direction
/*
 //iPhone的重力感应装置感应到屏幕由横向变为纵向或者由纵向变为横向是调用此方法。如返回结果为NO，则不自动调整显示方式；如返回结果为YES，则自动调整显示方式。
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *viewController = nil;
    if (0 == indexPath.row)
    {
        UIlabelInfoViewController *labelInfoVC = [[UIlabelInfoViewController alloc] init];
        viewController = labelInfoVC;

    }
    else if (1 == indexPath.row)
    {
        UIImageViewInfoViewController *imageViewInfoVC = [[UIImageViewInfoViewController alloc] init];
        viewController = imageViewInfoVC;
    }
    else if (2 == indexPath.row)
    {
        UIRefreshControlInfoViewController *refreshViewInfoVC = [[UIRefreshControlInfoViewController alloc] init];
        viewController = refreshViewInfoVC;
    }
    else if (3 == indexPath.row)
    {
        UICollectionViewInfoViewController *collectionViewInfoVC = [[UICollectionViewInfoViewController alloc] init];
        viewController = collectionViewInfoVC;

    }
    else if (4 == indexPath.row)
    {
        UITransitionViewController *transitionVC = [[UITransitionViewController alloc] init];
        viewController = transitionVC;
    }
    else if (5 == indexPath.row)
    {
        ImageSplitViewController *splitImageVC = [[ImageSplitViewController alloc] init];
        viewController = splitImageVC;
    }
    else if (6 == indexPath.row)
    {
        UIKeyBordViewController *keyBoradVC = [[UIKeyBordViewController alloc] init];
        viewController = keyBoradVC;
    }
    else if (7 == indexPath.row)
    {
        AssetsLibraryViewController *assertsVC = [[AssetsLibraryViewController alloc] init];
        viewController = assertsVC;
    }
    else if (8 == indexPath.row)
    {
        UIWebViewController *assertsVC = [[UIWebViewController alloc] init];
        viewController = assertsVC;
    }
    
    if (viewController)
    {
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    }
}



@end
